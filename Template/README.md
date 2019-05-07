# Azure_Connector
Deploy Qualys Azure Connector

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FQualys-Public%2FCloudview_connector_Azure%2Fmaster%2FTemplate%2Fazuredeploy.json) 
[![Visualize](http://armviz.io/visualizebutton.png)](http://armviz.io/#/?load=https://raw.githubusercontent.com/Qualys-Public/azure_connector/master/Template/azuredeploy.json)

## License
_**THIS SCRIPT IS PROVIDED TO YOU "AS IS."  TO THE EXTENT PERMITTED BY LAW, QUALYS HEREBY DISCLAIMS ALL WARRANTIES AND LIABILITY FOR THE PROVISION OR USE OF THIS SCRIPT.  IN NO EVENT SHALL THESE SCRIPTS BE DEEMED TO BE CLOUD SERVICES AS PROVIDED BY QUALYS**_


## Description

This Resource Manager Template will deploy the following:

* Create or use an existing Azure Automation account
* Imports the AzureAD PowerShell Module
* Create a Credential in Automation account for your subscription
* Create a Credential in Automation account for your Qualys Cloud Platform
* Create a Variable in Automation account to store base url of Qualys Cloud Platform
* Create a Powershell runbook in Automation account
* Create a job in Azure Automation account to execute the runbook

* Automation runbooks used by this template creates an application, a service principal and assign it delegated permission to impersonate user to call Windows Azure Service Management API with reader role.

## Usage
Click on Deply to Azure icon.
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FQualys-Public%2FCloudview_connector_Azure%2Fmaster%2FTemplate%2Fazuredeploy.json) 

_**Ensure that you input all the required fields asked in parameters section.**_

**Input Parameters:**

utilize [**azuredeploy-parameters.json**](/Template/Example/azuredeploy-parameters.json) as an example to supply parameters field.

      * _username: "Azure username to create the application and assign permissions"_
      * _password: "Azure password to create the application and assign permissions"_
      * _qualysuserName: "Qualys username to call CloudView API"_
      * _qualyspassword: "Qualys password to call CloudView API"_      
      * _baseURL: "Qualys baseurl for CloudView API"_
      * _automationAccountName: "The name you want to give to your automation account"_
      * _automationRegion: "The region where we you want to create your automation account "_
      * _jobId: "an unique identifier for the job created by executing the Powershell Runbook"_

