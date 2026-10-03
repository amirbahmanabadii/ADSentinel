BeforeAll {
    $ProjectRoot = (Resolve-Path "$PSScriptRoot/../..").Path
    $EntryPoint = Join-Path $ProjectRoot 'src/ADSentinel.ps1'
    $ConfigPath = Join-Path $ProjectRoot 'config/config.example.json'
}

Describe 'ADSentinel Foundation' {

    Context 'Repository structure' {

        It 'has the ADSentinel entry point' {
            Test-Path $EntryPoint | Should -BeTrue
        }

        It 'has an example configuration file' {
            Test-Path $ConfigPath | Should -BeTrue
        }
    }

    Context 'Configuration' {

        It 'contains valid JSON' {
            {
                Get-Content $ConfigPath -Raw |
                    ConvertFrom-Json |
                    Out-Null
            } | Should -Not -Throw
        }

        It 'identifies the application as ADSentinel' {
            $Config = Get-Content $ConfigPath -Raw | ConvertFrom-Json

            $Config.application.name | Should -Be 'ADSentinel'
        }
    }

    Context 'Entry point' {

        It 'requires PowerShell 7.4 or newer' {
            $Content = Get-Content $EntryPoint -Raw

            $Content | Should -Match '#Requires\s+-Version\s+7\.4'
        }

        It 'contains strict mode enforcement' {
            $Content = Get-Content $EntryPoint -Raw

            $Content | Should -Match 'Set-StrictMode\s+-Version\s+Latest'
        }

        It 'executes successfully without throwing' {
    { & $EntryPoint } | Should -Not -Throw
        }
    }
}
