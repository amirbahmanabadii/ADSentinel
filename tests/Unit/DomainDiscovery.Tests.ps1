#Requires -Version 7.4

BeforeAll {
    $ModulePath = Join-Path `
        $PSScriptRoot `
        '../../src/Modules/DomainDiscovery.psm1'

    Import-Module $ModulePath -Force
}

Describe 'ADSentinel Domain Discovery' {

    Context 'Module interface' {

        It 'exports Get-ADSentinelDomainDiscovery' {
            Get-Command Get-ADSentinelDomainDiscovery `
                -ErrorAction Stop |
                Should -Not -BeNullOrEmpty
        }

        It 'exposes the Server parameter' {
            $Command = Get-Command Get-ADSentinelDomainDiscovery

            $Command.Parameters.ContainsKey('Server') |
                Should -BeTrue
        }

        It 'exposes the Credential parameter' {
            $Command = Get-Command Get-ADSentinelDomainDiscovery

            $Command.Parameters.ContainsKey('Credential') |
                Should -BeTrue
        }

        It 'defines Server as a string parameter' {
            $Command = Get-Command Get-ADSentinelDomainDiscovery

            $Command.Parameters['Server'].ParameterType |
                Should -Be ([string])
        }

        It 'defines Credential as PSCredential' {
            $Command = Get-Command Get-ADSentinelDomainDiscovery

            $Command.Parameters['Credential'].ParameterType |
                Should -Be ([System.Management.Automation.PSCredential])
        }
    }

    Context 'Platform requirements' {

        It 'rejects Active Directory discovery on non-Windows platforms' -Skip:$IsWindows {
            {
                Get-ADSentinelDomainDiscovery
            } |
                Should -Throw '*Active Directory discovery requires Windows*'
        }

        It 'rejects explicit server discovery on non-Windows platforms' -Skip:$IsWindows {
            {
                Get-ADSentinelDomainDiscovery `
                    -Server 'dc01.example.test'
            } |
                Should -Throw '*Active Directory discovery requires Windows*'
        }

        It 'rejects credential-based discovery on non-Windows platforms' -Skip:$IsWindows {
            $Credential = [PSCredential]::new(
                'test@example.test',
                (
                    ConvertTo-SecureString `
                        'NotARealPassword' `
                        -AsPlainText `
                        -Force
                )
            )

            {
                Get-ADSentinelDomainDiscovery `
                    -Server 'dc01.example.test' `
                    -Credential $Credential
            } |
                Should -Throw '*Active Directory discovery requires Windows*'
        }
    }
}
Describe 'ADSentinel Domain Discovery - Mocked Active Directory' {

    BeforeAll {
        $ModuleName = 'DomainDiscovery'

        $TestCredential = [PSCredential]::new(
            'admin@sarv.net',
            (
                ConvertTo-SecureString `
                    'UnitTestPassword123!' `
                    -AsPlainText `
                    -Force
            )
        )
    }

    BeforeEach {
        Mock Get-Module `
            -ModuleName $ModuleName `
            -ParameterFilter {
                $ListAvailable -and
                $Name -eq 'ActiveDirectory'
            } `
            -MockWith {
                [PSCustomObject]@{
                    Name    = 'ActiveDirectory'
                    Version = [version]'1.0.1.0'
                }
            }

        Mock Import-Module `
            -ModuleName $ModuleName `
            -ParameterFilter {
                $Name -eq 'ActiveDirectory'
            }

        Mock Get-ADDomain `
            -ModuleName $ModuleName `
            -MockWith {
                [PSCustomObject]@{
                    DNSRoot              = 'sarv.net'
                    NetBIOSName          = 'SARV'
                    DomainMode           = 'Windows2025Domain'
                    DomainSID            = 'S-1-5-21-100-200-300'
                    PDCEmulator          = 'SRV-01.sarv.net'
                    RIDMaster            = 'SRV-01.sarv.net'
                    InfrastructureMaster = 'SRV-01.sarv.net'
                }
            }

        Mock Get-ADForest `
            -ModuleName $ModuleName `
            -MockWith {
                [PSCustomObject]@{
                    Name               = 'sarv.net'
                    ForestMode         = 'Windows2025Forest'
                    RootDomain         = 'sarv.net'
                    SchemaMaster       = 'SRV-01.sarv.net'
                    DomainNamingMaster = 'SRV-01.sarv.net'
                }
            }

        Mock Get-ADDomainController `
            -ModuleName $ModuleName `
            -MockWith {
                @(
                    [PSCustomObject]@{
                        HostName        = 'SRV-01.sarv.net'
                        IPv4Address     = '10.10.10.11'
                        Site            = 'Default-First-Site-Name'
                        IsGlobalCatalog = $true
                    }

                    [PSCustomObject]@{
                        HostName        = 'SRV-02.sarv.net'
                        IPv4Address     = '10.10.10.12'
                        Site            = 'Branch-Site'
                        IsGlobalCatalog = $false
                    }
                )
            }
    }

    Context 'Normalized discovery result' {

        It 'returns normalized domain and forest information' -Skip:(-not $IsWindows) {
            $Result = Get-ADSentinelDomainDiscovery `
                -Server 'SRV-01.sarv.net' `
                -Credential $TestCredential

            $Result.DomainName |
                Should -Be 'sarv.net'

            $Result.NetBIOSName |
                Should -Be 'SARV'

            $Result.ForestName |
                Should -Be 'sarv.net'

            $Result.RootDomain |
                Should -Be 'sarv.net'
        }

        It 'returns FSMO role holders' -Skip:(-not $IsWindows) {
            $Result = Get-ADSentinelDomainDiscovery `
                -Server 'SRV-01.sarv.net' `
                -Credential $TestCredential

            $Result.SchemaMaster |
                Should -Be 'SRV-01.sarv.net'

            $Result.DomainNamingMaster |
                Should -Be 'SRV-01.sarv.net'

            $Result.PDCEmulator |
                Should -Be 'SRV-01.sarv.net'

            $Result.RIDMaster |
                Should -Be 'SRV-01.sarv.net'

            $Result.InfrastructureMaster |
                Should -Be 'SRV-01.sarv.net'
        }

        It 'counts domain controllers and global catalogs' -Skip:(-not $IsWindows) {
            $Result = Get-ADSentinelDomainDiscovery `
                -Server 'SRV-01.sarv.net' `
                -Credential $TestCredential

            $Result.DomainControllerCount |
                Should -Be 2

            $Result.GlobalCatalogCount |
                Should -Be 1
        }

        It 'returns unique sorted Active Directory sites' -Skip:(-not $IsWindows) {
            $Result = Get-ADSentinelDomainDiscovery `
                -Server 'SRV-01.sarv.net' `
                -Credential $TestCredential

            $Result.Sites |
                Should -HaveCount 2

            $Result.Sites[0] |
                Should -Be 'Branch-Site'

            $Result.Sites[1] |
                Should -Be 'Default-First-Site-Name'
        }

        It 'returns a UTC discovery timestamp' -Skip:(-not $IsWindows) {
            $Result = Get-ADSentinelDomainDiscovery `
                -Server 'SRV-01.sarv.net' `
                -Credential $TestCredential

            $Result.DiscoveryTimeUtc.Kind |
                Should -Be ([DateTimeKind]::Utc)
        }
    }
}