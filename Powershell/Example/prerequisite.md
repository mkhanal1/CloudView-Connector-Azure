1. Create application in Azure Active Directory:
       * Log on to the Microsoft Azure console.Goto Azure Active Directory -> App Regisrations .
       ![Image1](/Powershell/Example/Images/1.PNG)
       * Click New application registration and provide "Name" (A name for the application (e.g. My_Azure_Connector)),  "Application Type" (Select Web app/API), "Sign-on URL" (Enter any valid URL (e.g. https://localhost/azure_con))
       ![Image2](/Powershell/Example/Images/2.PNG)
       * Click Create. The newly created app appears in the list of applications. Copy the Application ID and Directory ID for config file.
       ![Image3](/Powershell/Example/Images/3.PNG)

 2. Provide permission to the new application to access the Windows Azure Service Management API and create a secret key: 
       * Navigate to Azure Active Directory -> App Regisrations and select the application that you created and go to API permissions under Manage Section. 
       * Click Add a permission > Azure Service Management API and click Select.
       ![Image4](/Powershell/Example/Images/4.PNG)
       * Click Delegated Permissions, and select user_impersonation and then click Add Permissions.
       ![Image5](/Powershell/Example/Images/5.PNG)
       * Select the application that you created and go to Certificates & secrets and click on New client secret under Client secrets.
       ![Image6](/Powershell/Example/Images/6.PNG)
       * Add a description and expiry duration for the key and click Save.
       ![Image7](/Powershell/Example/Images/7.PNG)
       * The value of the key appears in the Value field. Copy the key value at this time. You won’t be able to retrieve it later. Paste the key value as Authentication Key into the connector details.
       ![Image8](/Powershell/Example/Images/8.PNG)

 3. Attach role (Reader Role) to the application created in step1: 
       * Navigate to Management Groups 
       * Select the group you want to add permissions to. 
       * Click on Details, next to the name of the management group 
       * Navigate to Access Control(IAM) and Clickon ADD -> Add role assignment
       ![Image9](/Powershell/Example/Images/9.PNG)
       * Type in Reader in "Role" field and assign it to your application.
       ![Image10](/Powershell/Example/Images/10.PNG)
