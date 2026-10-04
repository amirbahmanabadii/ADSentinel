#Requires -Version 7.4

Set-StrictMode -Version Latest

function Get-ADSentinelDomainDiscovery {
    <#
    .SYNOPSIS
        Discovers core Active Directory domain and forest information.

    .DESCRIPTION
        Performs read-only Active Directory discovery and returns a normalized
        object containing domain, forest, FSMO role, domain controller, global
        catalog, and site information.

        The function validates platform and ActiveDirectory module availability
        before attempting discovery.

    .OUTPUTS
        PSCustomObject containing normalized Active Directory discovery data.

    .NOTES
        ADSentinel performs read-only discovery. This function does not modify
        Active Directory configuration or objects.
    #>

    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param()

    if (-not $IsWindows) {
        throw [System.PlatformNotSupportedException]::new(
            'Active Directory discovery requires Windows.'
        )
    }

    $ActiveDirectoryModule = Get-Module `
        -ListAvailable `
        -Name ActiveDirectory |
        Sort-Object Version -Descending |
        Select-Object -First 1

    if ($null -eq $ActiveDirectoryModule) {
        throw [System.InvalidOperationException]::new(
            'The ActiveDirectory PowerShell module is required but was not found.'
        )
    }

    try {
        Import-Module ActiveDirectory -ErrorAction Stop

        $Domain = Get-ADDomain -ErrorAction Stop
        $Forest = Get-ADForest -ErrorAction Stop

        $DomainControllers = @(
            Get-ADDomainController `
                -Filter * `
                -Server $Domain.DNSRoot `
                -ErrorAction Stop
        )

        $GlobalCatalogs = @(
            $DomainControllers |
                Where-Object { $_.IsGlobalCatalog }
        )

        $Sites = @(
            $DomainControllers |
                Where-Object {
                    -not [string]::IsNullOrWhiteSpace($_.Site)
                } |
                Select-Object -ExpandProperty Site -Unique |
                Sort-Object
        )

        [PSCustomObject][ordered]@{
            DomainName              = $Domain.DNSRoot
            NetBIOSName             = $Domain.NetBIOSName
            DomainMode              = $Domain.DomainMode.ToString()
            DomainSID               = $Domain.DomainSID.ToString()

            ForestName              = $Forest.Name
            ForestMode              = $Forest.ForestMode.ToString()
            RootDomain              = $Forest.RootDomain

            SchemaMaster            = $Forest.SchemaMaster
            DomainNamingMaster      = $Forest.DomainNamingMaster
            PDCEmulator             = $Domain.PDCEmulator
            RIDMaster               = $Domain.RIDMaster
            InfrastructureMaster    = $Domain.InfrastructureMaster

            DomainControllerCount   = $DomainControllers.Count
            GlobalCatalogCount      = $GlobalCatalogs.Count
            Sites                   = $Sites

            DiscoveryTimeUtc        = [DateTime]::UtcNow
        }
    }
    catch {
        $Message = "Active Directory discovery failed: $($_.Exception.Message)"
        throw [System.InvalidOperationException]::new($Message, $_.Exception)
    }
}

Export-ModuleMember -Function Get-ADSentinelDomainDiscovery