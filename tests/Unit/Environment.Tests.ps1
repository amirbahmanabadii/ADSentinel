#Requires -Version 7.4

Set-StrictMode -Version Latest

BeforeAll {
    $ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
    $EnvironmentModule = Join-Path $ProjectRoot 'src/Core/Environment.psm1'

    Import-Module $EnvironmentModule -Force
}

Describe 'ADSentinel Environment' {

    Context 'Module interface' {

        It 'exports Get-ADSentinelEnvironment' {
            Get-Command Get-ADSentinelEnvironment -ErrorAction Stop |
                Should -Not -BeNullOrEmpty
        }
    }

    Context 'Environment detection' {

        BeforeAll {
            $Result = Get-ADSentinelEnvironment
        }

        It 'returns an environment object' {
            $Result | Should -Not -BeNullOrEmpty
        }

        It 'returns the local computer name' {
            $Result.ComputerName |
                Should -Be ([Environment]::MachineName)
        }

        It 'returns the current PowerShell version' {
            $Result.PowerShellVersion |
                Should -Be $PSVersionTable.PSVersion.ToString()
        }

        It 'returns the current PowerShell edition' {
            $Result.PowerShellEdition |
                Should -Be $PSVersionTable.PSEdition
        }

        It 'reports Windows status as a Boolean' {
            $Result.IsWindows |
                Should -BeOfType [bool]
        }

        It 'reports Active Directory module availability as a Boolean' {
            $Result.ActiveDirectoryModuleAvailable |
                Should -BeOfType [bool]
        }

        It 'reports Active Directory capability as a Boolean' {
            $Result.ActiveDirectoryCapable |
                Should -BeOfType [bool]
        }

        It 'returns a UTC detection timestamp' {
            $Result.DetectionTimeUtc |
                Should -BeOfType [datetime]

            $Result.DetectionTimeUtc.Kind |
                Should -Be ([DateTimeKind]::Utc)
        }

        It 'does not report Active Directory capability on non-Windows platforms' -Skip:$IsWindows {
            $Result.ActiveDirectoryCapable |
                Should -BeFalse
        }
    }
}