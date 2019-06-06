<#
    .DESCRIPTION
        A runbook which creates an application and service principal for Qualys Azure AV Connector with user impersonation permissions 
	to run Windows Azure Service Management API with reader role.
    .NOTES
        AUTHOR: Mikesh Khanal
        LASTEDIT: Mar 19, 2018
#>

add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
$AllProtocols = [System.Net.SecurityProtocolType]'Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$azureCredential = Get-AutomationPSCredential -Name "AzureCredentials"
$QualysCredential = Get-AutomationPSCredential -Name "QualysCredentials"
if(($azureCredential -ne $null) -AND ($QualysCredential -ne $null) )
{
	Write-Output "Attempting to authenticate as: [$($azureCredential.UserName)], [$($QualysCredential.UserName)]"
	$URI = Get-AutomationVariable -Name "baseurl"
	$URI = $URI + "/cloudview-api/rest/v1/azure/connectors"
	$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $QualysCredential.Username,$QualysCredential.GetNetworkCredential().password)))
	$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$headers.Add("X-Requested-With","Qualys Runbook (Powershell)")
	$headers.Add("Accept","application/json")
	$headers.Add("Content-Type","application/json")
	$headers.Add("Authorization",("Basic {0}" -f $base64AuthInfo))

	try
	{
    		echo "Logging in to Azure..."
    		Login-AzureRmAccount -Credential $azureCredential 
    		[string[]]$directoryId = @()
    		$directoryID = (Get-AzureRmSubscription).TenantId
    		echo "Logging in to Azure AD..."
    		Connect-AzureAD -TenantId $directoryID[0] -Credential $azureCredential
	}
	catch 
	{
    		Write-Error -Message $_.Exception
    		throw $_.Exception
	}

	# Check if the Azure AD PowerShell module has already been loaded.
	if ( ! ( Get-Module AzureAD ) ) {
    		# Check if the Azure AD PowerShell module is installed.
    		if ( Get-Module -ListAvailable -Name AzureAD ) 
		{
        		# The Azure AD PowerShell module is not load and it is installed. This module
        		# must be loaded for other operations performed by this script.
        		Write-Host -ForegroundColor Green "Loading the Azure AD PowerShell module..."
        		Import-Module AzureAD
    		} 
		else 
		{
        		Install-Module AzureAD
    		}
	}
	
	$choice =  Get-AutomationVariable -Name "choice"
	[string[]]$subscriptionId = @()
	if ($choice.ToLower() -eq "all")
	{
		$subscriptionId = (Get-AzureRmSubscription).SubscriptionId
	}
	else
	{
		$subscriptionId =   Get-AutomationVariable -Name 'AzureSubscriptionId'
	}
	$AzureServiceManagementAccess = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
    		ResourceAppId = "797f4846-ba00-4fd7-ba43-dac1f8f63013";
    		ResourceAccess =
			[Microsoft.Open.AzureAD.Model.ResourceAccess]@{
				Id = "41094075-9dad-400e-a0bd-54e686782033";
				Type = "Scope"}
	}

	Write-Host "Creating the AAD application (Qualys APP)"
	#Create an application, assign it credentials and assign it API permissions
	$SessionInfo = Get-AzureADCurrentSessionInfo
	$application = New-AzureADApplication -DisplayName "QualysAzureConnector-$($SessionInfo.TenantId)" -IdentifierUris "https://$($SessionInfo.TenantDomain)/$((New-Guid).ToString())" -RequiredResourceAccess $AzureServiceManagementAccess -ReplyUrls @("urn:ietf:wg:oauth:2.0:oob") #Create application

	Write-Host "Creating the key for AAD application (Qualys APP)"
	$password = New-AzureADApplicationPasswordCredential -ObjectId $application.ObjectId
	Write-Host "Creating the Service Principal for AAD application (Qualys APP)"
	$clientServicePrincipal = New-AzureADServicePrincipal -AppId $application.AppId
	$applicationId = $application.AppId
	$authenticationKey = $password.Value

	for ($i=0; $i -lt $subscriptionId.count; $i++)
	{
		$Subs = $subscriptionId[$i]
		$bodycontent = @{
   			"applicationId" = $applicationId;
   			"authenticationKey" = $authenticationKey;
   			"description" = "Azure-Subscription - " + $Subs;
   			"directoryId"= $SessionInfo.TenantId;
   			"name" = "Azure -" + $Subs;
   			"subscriptionId" = $Subs;
		}
		$body = $bodycontent | ConvertTo-Json
		echo $body
		echo $URI
		echo $headers

		echo "Waiting for creation of Service Principal"
		Start-Sleep -Seconds 20
		echo "20 seconds passed, 20 secs more"
		Start-Sleep -Seconds 20
		New-AzureRmRoleAssignment -RoleDefinitionName Reader -ObjectId $clientServicePrincipal.ObjectId -Scope "/subscriptions/$Subs"
		try
		{
    			$result = Invoke-WebRequest -UseBasicParsing -Headers $headers -Uri $URI -Method Post -Body $body
    			echo "Status Code: " $result.StatusCode
    			echo "Content: " $result.Content
		}
		catch
		{
			Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
			Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
        		Write-Error -Exception $_.Exception
		}
	}
}
else
{
   Write-Error -Exception $_.Exception 
}
