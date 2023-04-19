function Update-CPCProvisioningPolicy {
    <#
    .SYNOPSIS
    Update a Cloud PC Provisioning Policy
    .DESCRIPTION
    Update a Cloud PC Provisioning Policy
    .PARAMETER Name
    Name of the Provisioning Policy to update an image for example
    .EXAMPLE
    Update-CPCProvisioningPolicy -Name "Test-AzureADJoin" -imageType "Gallery" -ImageId "MicrosoftWindowsDesktop_windows-ent-cpc_win11-22h2-ent-cpc-m365" 
    .EXAMPLE
    Update-CPCProvisioningPolicy -Name "Test-AzureADJoin" -EnableSingleSignOn $true
    .NOTES
    #>
    [CmdletBinding(DefaultParameterSetName = 'Name')]
    param (
        [parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [string]$Name,

        [ValidateSet("Custom","Gallery")]
        [parameter(Mandatory = $false)][string]$ImageType,

        [parameter(Mandatory = $false)][string]$ImageId,

        [parameter(Mandatory = $false)][bool]$EnableSingleSignOn,

        [parameter(Mandatory = $false)][string]$NamingTemplate,

        [string]$OnPremisesConnectionIds,

        [ValidateSet('azureADJoin', 'hybridAzureADJoin')]
        [string]$DomainJoinType = 'azureADJoin'
    )

    Begin {
        Get-TokenValidity

        $Policy = Get-CPCProvisioningPolicy -name $Name

        If ($null -eq $Policy) {
            Throw "No User Settings Policy found with name $Name"
            return
        }

        $url = "https://graph.microsoft.com/$script:MSGraphVersion/deviceManagement/virtualEndpoint/provisioningPolicies/$($Policy.id)"

        Write-Verbose "Update url: $($url)"

    }

    Process {
        
        $params = @{
            displayName = $($Policy.displayName)
            
        }

        If ($ImageId){
            $params.Add("ImageType","$imageType")
            $params.Add("ImageId", "$ImageId")
        }

        If ($psboundparameters.ContainsKey("EnableSingleSignOn")){
            $params.Add("EnableSingleSignOn", $EnableSingleSignOn)
        }
 
        If ($NamingTemplate){
            $params.Add("CloudPcNamingTemplate","$NamingTemplate")
        }

        
        If ($OnPremisesConnectionIds) {
            $domainJoinConfigurations = @()
            foreach ($id in $OnPremisesConnectionIds) {
                Write-Verbose "OnPremisesConnectionId: $id"
                $domainJoinConfig = @{
                    Type                   = "$DomainJoinType"
                    OnPremisesConnectionId = $id
                }
                $domainJoinConfigurations += $domainJoinConfig
            }
            $params.Add("DomainJoinConfigurations", $domainJoinConfigurations)
        }

        Write-Verbose "Params: $($params)"

        $body = $params | ConvertTo-Json -Depth 10

        Write-Verbose "Body: $($body)"

        try {
            Write-Verbose "Updating User Settings Policy $($Name)"
            $Result = Invoke-WebRequest -uri $url -Method PATCH -Headers $script:authHeader -Body $body -ContentType "application/json" -SkipHttpErrorCheck
            Write-Verbose "Result: $($Result.Content)"
        }
        catch {
            Throw $_.Exception.Message
        }
    }
}