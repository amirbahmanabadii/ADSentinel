#Requires -Version 7.4

Set-StrictMode -Version Latest

function Get-ADSentinelEnvironment {
    <#
    .SYNOPSIS
        Returns information about the ADSentinel runtime environment.

    .DESCRIPTION
        Detects the operating system, PowerShell runtime, process
        architecture, and availability of Active Directory tooling.

        This function performs capability detection only. It does not
        connect to Active Directory or modify the local system.

    .OUTPUTS
        PSCustomObject
    #>

    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param()

    $ActiveDirectoryModule = Get-Module `
        -Name ActiveDirectory `
        -ListAvailable `
        -ErrorAction SilentlyContinue |
        Sort-Object Version -Descending |
        Select-Object -First 1

    $IsWindowsPlatform = $PSVersionTable.Platform -eq 'Win32NT'

    $Environment = [ordered]@{
        ComputerName                   = [Environment]::MachineName
        OperatingSystem               = [Environment]::OSVersion.VersionString
        IsWindows                     = $IsWindowsPlatform
        PowerShellVersion             = $PSVersionTable.PSVersion.ToString()
        PowerShellEdition             = $PSVersionTable.PSEdition
        PowerShellPlatform            = $PSVersionTable.Platform
        ProcessArchitecture           = [System.Runtime.InteropServices.RuntimeInformation]::ProcessArchitecture.ToString()
        FrameworkDescription          = [System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription
        ActiveDirectoryModuleAvailable = $null -ne $ActiveDirectoryModule
        ActiveDirectoryModuleVersion  = if ($ActiveDirectoryModule) {
            $ActiveDirectoryModule.Version.ToString()
        }
        else {
            $null
        }
        ActiveDirectoryCapable        = $IsWindowsPlatform -and ($null -ne $ActiveDirectoryModule)
        DetectionTimeUtc              = [DateTime]::UtcNow
    }

    [PSCustomObject]$Environment
}

Export-ModuleMember -Function Get-ADSentinelEnvironment
