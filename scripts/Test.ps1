#Requires -Version 7.4

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot
$SourcePath = Join-Path $ProjectRoot 'src'
$UnitTestPath = Join-Path $ProjectRoot 'tests/Unit'
$ConfigurationPath = Join-Path $ProjectRoot 'config/config.example.json'

Write-Output '========================================'
Write-Output ' ADSentinel Validation'
Write-Output '========================================'
Write-Output ''

Write-Output '[1/4] Validating example configuration...'

try {
    Get-Content -Path $ConfigurationPath -Raw |
        ConvertFrom-Json -ErrorAction Stop |
        Out-Null

    Write-Output '[PASS] Configuration JSON is valid.'
}
catch {
    Write-Error "Configuration validation failed: $($_.Exception.Message)"
    exit 1
}

Write-Output ''
Write-Output '[2/4] Validating PowerShell syntax...'

$PowerShellFiles = Get-ChildItem `
    -Path $SourcePath, (Join-Path $ProjectRoot 'scripts'), $UnitTestPath `
    -Recurse `
    -File |
    Where-Object Extension -In '.ps1', '.psm1', '.psd1'

$SyntaxErrors = @()

foreach ($File in $PowerShellFiles) {
    $Tokens = $null
    $ParseErrors = $null

    [System.Management.Automation.Language.Parser]::ParseFile(
        $File.FullName,
        [ref]$Tokens,
        [ref]$ParseErrors
    ) | Out-Null

    if ($ParseErrors.Count -gt 0) {
        $SyntaxErrors += $ParseErrors
    }
}

if ($SyntaxErrors.Count -gt 0) {
    $SyntaxErrors | Format-List
    Write-Error "PowerShell syntax validation failed with $($SyntaxErrors.Count) error(s)."
    exit 1
}

Write-Output "[PASS] PowerShell syntax is valid for $($PowerShellFiles.Count) file(s)."

Write-Output ''
Write-Output '[3/4] Running PSScriptAnalyzer...'

Import-Module PSScriptAnalyzer -ErrorAction Stop

$AnalyzerErrors = @()
$AnalyzerResults = @()

$SourceFiles = Get-ChildItem `
    -Path $SourcePath `
    -Recurse `
    -File |
    Where-Object Extension -In '.ps1', '.psm1', '.psd1'

foreach ($File in $SourceFiles) {
    try {
        $FileResults = @(
            Invoke-ScriptAnalyzer `
                -Path $File.FullName `
                -ErrorAction Stop
        )

        $AnalyzerResults += $FileResults
    }
    catch {
        $AnalyzerErrors += [PSCustomObject]@{
            File      = $File.FullName
            Exception = $_.Exception.Message
        }
    }
}

if ($AnalyzerErrors.Count -gt 0) {
    $AnalyzerErrors |
        Format-Table File, Exception -Wrap -AutoSize

    Write-Error "PSScriptAnalyzer failed while analyzing $($AnalyzerErrors.Count) file(s)."
    exit 1
}

if ($AnalyzerResults.Count -gt 0) {
    $AnalyzerResults |
        Format-Table RuleName, Severity, ScriptName, Line, Message -Wrap -AutoSize

    Write-Error "PSScriptAnalyzer reported $($AnalyzerResults.Count) issue(s)."
    exit 1
}

Write-Output "[PASS] PSScriptAnalyzer analyzed $($SourceFiles.Count) file(s) with 0 issues."

Write-Output ''
Write-Output '[4/4] Running Pester unit tests...'

Import-Module Pester -MinimumVersion 6.0 -ErrorAction Stop

$PesterConfiguration = New-PesterConfiguration
$PesterConfiguration.Run.Path = $UnitTestPath
$PesterConfiguration.Run.PassThru = $true
$PesterConfiguration.Output.Verbosity = 'Detailed'

$TestResult = Invoke-Pester -Configuration $PesterConfiguration

if ($TestResult.FailedCount -gt 0) {
    Write-Error "Pester reported $($TestResult.FailedCount) failed test(s)."
    exit 1
}

Write-Output ''
Write-Output '========================================'
Write-Output ' ADSentinel validation completed.'
Write-Output ' All checks passed.'
Write-Output '========================================'

exit 0