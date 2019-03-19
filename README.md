# Azure_Connector
Deploy Qualys Azure Connector
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FQualys-Public%2Fazure_connector%2Fmaster%2Fazuredeploy.json) 

## License
_**THIS SCRIPT IS PROVIDED TO YOU "AS IS."  TO THE EXTENT PERMITTED BY LAW, QUALYS HEREBY DISCLAIMS ALL WARRANTIES AND LIABILITY FOR THE PROVISION OR USE OF THIS SCRIPT.  IN NO EVENT SHALL THESE SCRIPTS BE DEEMED TO BE CLOUD SERVICES AS PROVIDED BY QUALYS**_


## Description

#### What is AWS Elastic Beanstalk
[AWS Elastic Beanstalk](https://docs.aws.amazon.com/elastic-beanstalk/index.html) is a managed environment that provisions resources for easy deployment and scaling of web applications. It creates a load balanced and auto-scaled infrastructure with familiar Web Servers
and the runtime of your choice; it takes care of deployment, capacity provisioning, auto-scaling and
health monitoring of the application.

#### Qualys Cloud Agent (CA)
The changes done through SSH on any instance launched by Elastic Beanstalk are not persistent as the
instances are replaced or added as per scaling policy and the new instances don’t import changes from
previously configured instances. However, AWS provides a mechanism to use configuration files and
Qualys leverages the same to provide you configuration files that downloads and installs Qualys Cloud
Agent for continuous monitoring of the environment.

## Usage
To deploy Cloud Agent (CA) in your environment by using configuration files, copy the files based to your Operating System 
in a folder named .ebextensions, (**create a folder .ebextensions at the top level of your project's source code**).
The extension of these files must be _**.config**_.

_**Ensure that you replace all “REPLACE_ME” fields in the file with apt parameters.**_

**Input Parameters:**

* Activation ID:
An ID to authenticate agents so that they could be grouped and bind to your account

* Customer ID:
An ID to identify your account

* URL to download the installation file: 

Redeploy your applications and CA will be installed in underlying infrastructure and starts continuously monitoring your elastic beanstalk environment.
