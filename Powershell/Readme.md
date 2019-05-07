# CloudView_connector_Azure

## License
_**THIS SCRIPT IS PROVIDED TO YOU "AS IS."  TO THE EXTENT PERMITTED BY LAW, QUALYS HEREBY DISCLAIMS ALL WARRANTIES AND LIABILITY FOR THE PROVISION OR USE OF THIS SCRIPT.  IN NO EVENT SHALL THESE SCRIPTS BE DEEMED TO BE CLOUD SERVICES AS PROVIDED BY QUALYS**_

## Description
The aim of this repository is to build a solution which will help you onboard multiple subscriptions within Management Groups or all subscriptions within a AD to Qualys CloudView. We have built a powershell program which will perform this solution.

This repository contains ==>

  1. [**Main powershell program**](/Cloudview_Connector_Azure.ps1) 
  2. [**Configuration file**](/example/config.json)
  3. [**CSV with list of subscriptions**](/example/azure-subscriptions.csv)
 

## Deployment Options
* **All subscriptions under a Tenant or AD** : To onboard **all** the subscriptions under a Tenent or AD
    * Input ```"all"``` in the subscriptions field of [configuration file](/example/config.json)
    
* **All subscriptions within a Management Group** : To onboard all subscriptions within a management group
    * Input ```"ManagementGroupName"``` in the subscriptions field of [configuration file](/example/config.json)
    
* **Multiple subscriptions listed in a CSV** : To onboard selected subscriptions
    * Input the complete path of CSV file containing the list of subscriptions to be onboarded in the subscriptions field of [configuration file](/example/config.json)


     
    **Prerequisites:**(an Azure AD application and service principal that can read resources) ([An example](/example/prerequisite.md))
    
       1. Enable access to few API's in API library for project: 
             * For all projects to be onboarded, navigate to API & Services > Library and enable Cloud Resource Manager API, Compute Engine API, Kubernetes Engine API and Cloud SQL Admin API from the API library. 

       2. Create a service account in any project and download a configuration file: 
             * Navigate to IAM & admin > Service accounts and click CREATE SERVICE ACCOUNT. Provide a name and description (optional) for the service account and click CREATE. 
             * Click CREATE KEY.  Select JSON as Key type and click CREATE. A message saying “Private key saved to your computer” is displayed and the JSON file is downloaded to your computer. Click CLOSE and then click DONE. 

       3. Attach role (Resource Manager -> Organization Viewer, Folder Viewer, Project Viewer and    IAM -> Security Reviewer) to the Service account created in step1: 
             * Navigate to Organization 
             * Navigate to IAM & admin > IAM 
             * Click on ADD tab 
             * Paste the service account email address in the New member field 
             * Add roles mentioned above in the Role field and click on CONTINUE 
            
## Usage

#### Get started 
  * Making the [choice of deployment mode](#Deployment-Options) ``` All subscriptions in AD or All subscriptions in Management Group or Multiple subscriptions in AD```
  
  * Preparing the configuration file ([An example](/example/config.json))
      * _username: "Qualys username to call CloudView API"_
      * _password: "Qualys password to call CloudView API"_
      * _baseurl: "Qualys baseurl for CloudView API"_
      * _subscriptions: "Either the CSV containing list of projectIds or **all** or **ManagementGroupName**"_
      * _directoryId: "an unique identifier of your Azure Active Directory"_
      * _applicationId: "an unique identifier of the Application you created for Qualys"_
      * _authenticationKey: "Authentication key associated with the Application created above"_
      * _debug: true/false_
      
  * Preparing the csv file if deployment mode is not all the subscriptions Within AD or Management Group ([An example](/example/azure-subscriptions.csv))
  
      subscriptionId |
      ---------|
      subscription1|
      subscription2|
      
   * Run the [main powershell program](/Cloudview_Connector_Azure.ps1)

