#Requires -module ComputerManagementDsc

<#
    .DESCRIPTION
        This configuration joins the computer to the specified domain and configures the PowerShell script execution policy
#>

Configuration DomainJoin
{
    param
    (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $ComputerName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $DomainName,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $DomainJoinOU,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $TimeZoneName
    )

    Import-DscResource -Module ComputerManagementDsc

    Node localhost
    {

        TimeZone SetTimeZone
        {
            IsSingleInstance = "Yes"
            TimeZone = $TimeZoneName
        }

        Computer JoinDomain
        {
            Name = $ComputerName
            DomainName = $DomainName
            Credential = $Credential # Credential to join to domain
            JoinOU = $DomainJoinOU
        }

        PendingReboot RebootAfterDomainJoin
        {
            Name = "Reboot after Domain Join"
            SkipPendingComputerRename = $false
        }

    }
}
