# CloudView_connector_Azure

## License
_**THIS SCRIPT IS PROVIDED TO YOU "AS IS."  TO THE EXTENT PERMITTED BY LAW, QUALYS HEREBY DISCLAIMS ALL WARRANTIES AND LIABILITY FOR THE PROVISION OR USE OF THIS SCRIPT.  IN NO EVENT SHALL THESE SCRIPTS BE DEEMED TO BE CLOUD SERVICES AS PROVIDED BY QUALYS**_

## Description
The aim of this repository is to build a solution which will help you onboard multiple subscriptions within Management Groups or all subscriptions within a AD to Qualys CloudView. We have built a powershell program which will perform this solution.

This repository contains ==>

  1. [**Main powershell program**](/Powershell/Cloudview_Connector_Azure.ps1) 
  2. [**Configuration file**](/Powershell/config/config.json)
  3. [**CSV with list of subscriptions**](/Powershell/config/azure-subscriptions.csv)
 

## Deployment Options
* **All subscriptions under a Tenant or AD** : To onboard **all** the subscriptions under a Tenent or AD
    * Input ```"all"``` in the subscriptions field of [configuration file](/Powershell/Example/configAll.json)
    
* **All subscriptions within a Management Group** : To onboard all subscriptions within a management group
    * Input ```"ManagementGroupId"``` in the subscriptions field of [configuration file](/Powershell/Example/configAllManagement.json)
    
* **Multiple subscriptions listed in a CSV** : To onboard selected subscriptions
    * Input the complete path of CSV file containing the list of subscriptions to be onboarded in the subscriptions field of [configuration file](/Powershell/Example/config.json)


     
    **Prerequisites:**(an Azure AD application and service principal that can read resources) ([An example](/Powershell/Example/prerequisite.md))
    
       1. Create application in Azure Active Directory: 
             * Log on to the Microsoft Azure console.Goto Azure Active Directory -> App Regisrations .
             * Click New application registration and provide "Name" (A name for the application (e.g. My_Azure_Connector)),  "Application Type" (Select Web app/API), "Sign-on URL" (Enter any valid URL (e.g. https://localhost/azure_con))
             * Click Create. The newly created app appears in the list of applications. Copy the Application ID and Directory ID for config file.

       2. Provide permission to the new application to access the Windows Azure Service Management API and create a secret key: 
             * Navigate to Azure Active Directory -> App Regisrations and select the application that you created and go to API permissions under Manage Section. 
             * Click Add a permission > Azure Service Management API and click Select.
             * Click Delegated Permissions, and select user_impersonation and then click Add Permissions.
             * Select the application that you created and go to Certificates & secrets and click on New client secret under Client secrets.
             * Add a description and expiry duration for the key and click Save.
             * The value of the key appears in the Value field. Copy the key value at this time. You won’t be able to retrieve it later. Paste the key value as Authentication Key into the connector details.

       3. Attach role (Reader Role) to the application created in step1: 
             * Navigate to Management Groups 
             * Select the group you want to add permissions to. 
             * Click on Details, next to the name of the management group 
             * Navigate to Access Control(IAM) and Clickon ADD -> Add role assignment 
             * Type in Reader in "Role" field and assign it to your application. 
            
## Usage

#### Get started 
  * Making the [choice of deployment mode](#Deployment-Options) ``` All subscriptions in AD or All subscriptions in Management Group or Multiple subscriptions in AD```
  
  * Preparing the configuration file ([An example](/Powershell/Example/config.json))
      * _username: "Qualys username to call CloudView API"_
      * _password: "Qualys password to call CloudView API"_
      * _baseurl: "Qualys baseurl for CloudView API"_
      * _subscriptions: "Either the CSV containing list of projectIds or **all** or **ManagementGroupName**"_
      * _directoryId: "an unique identifier of your Azure Active Directory"_
      * _applicationId: "an unique identifier of the Application you created for Qualys"_
      * _authenticationKey: "Authentication key associated with the Application created above"_
      * _debug: true/false_
      
  * Preparing the csv file if deployment mode is not all the subscriptions Within AD or Management Group ([An example](/Powershell/config/azure-subscriptions.csv))
  
      subscriptionId |
      ---------|
      subscription1|
      subscription2|
      
   * Run the [main powershell program](/Powershell/Cloudview_Connector_Azure.ps1)


## *NOTE: This script has been tested using Powershell 5.1* ##
## *You can use the same script for Powershell 6 by removing the section TO BE REMOVED* ##
