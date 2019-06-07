# CloudView Connector Azure

## License
_**THIS SCRIPT IS PROVIDED TO YOU "AS IS."  TO THE EXTENT PERMITTED BY LAW, QUALYS HEREBY DISCLAIMS ALL WARRANTIES AND LIABILITY FOR THE PROVISION OR USE OF THIS SCRIPT.  IN NO EVENT SHALL THESE SCRIPTS BE DEEMED TO BE CLOUD SERVICES AS PROVIDED BY QUALYS**_

## Deployment Options
* [**Create Bulk Azure Connector in CloudView using ARM Template**](/Template) : It creates application and the secret key, assign it permission to delegate as a user to make Azure Service Management APIs and assign reader role over current subscription. If the choice selected is current, With all these information, it creates a Azure Connector in Cloudview corrosponding to that subscription. If the choice selected is all, it creates Azure connectors for all the subscriptions user have access to.
`*Note: It doesn't support bulk onboarding using management group*`

* [**Create Bulk Azure Connectors in CloudView using Powershell**](/Powershell) : It creates Azure Connectors in Cloudview for all subscriptions under an AD or management group. If opted, one can also provide a CSV with the list of subscriptions to onboard into CloudView.
`*Note: It doesn't create application and the secret key, assign it permission to delegate as a user to make Azure Service Management APIs and assign reader role over subscriptions.`
