#Requires -Version 7.4

<#
.SYNOPSIS
    ADSentinel - Active Directory Infrastructure Toolkit.

.DESCRIPTION
    Entry point for ADSentinel.

    ADSentinel provides Active Directory discovery, health assessment,
    diagnostics, auditing, and reporting capabilities.

.NOTES
    Author: Amir Bahmanabadi
    Project: ADSentinel
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:ADSentinelVersion = '0.1.0-dev'

function Show-ADSentinelBanner {
    [CmdletBinding()]
    param()

    $banner = @'

    _    ____  ____             _   _            _
   / \  |  _ \/ ___|  ___ _ __ | |_(_)_ __   ___| |
  / _ \ | | | \___ \ / _ \ '_ \| __| | '_ \ / _ \ |
 / ___ \| |_| |___) |  __/ | | | |_| | | | |  __/ |
/_/   \_\____/|____/ \___|_| |_|\__|_|_| |_|\___|_|

        Active Directory Infrastructure Toolkit

'@

    Write-Host $banner
    Write-Host "Version : $script:ADSentinelVersion"
    Write-Host "Author  : Amir Bahmanabadi"
    Write-Host
}

try {
    Show-ADSentinelBanner

    Write-Output '[+] ADSentinel initialized successfully.'
    Write-Output '[i] Active Directory discovery engine is not loaded yet.'
    Write-Output '[i] Current milestone: Foundation'
}
catch {
    Write-Error "ADSentinel initialization failed: $($_.Exception.Message)"
    exit 1
}
