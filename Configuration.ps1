#Requires -module ComputerManagementDsc

<#
    .DESCRIPTION
        This configuration joins the computer to the specified domain and configures the PowerShell script execution policy
#>

Configuration JoinDomain
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
        $Credential
    )

    Import-DscResource -Module ComputerManagementDsc

    Node localhost
    {

        Computer JoinDomain
        {
            Name = $ComputerName
            DomainName = $DomainName
            Credential = $Credential # Credential to join to domain
        }

    }
}
