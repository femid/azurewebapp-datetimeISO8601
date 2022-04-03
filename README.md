# simpleazurewebapp
Deploys a WebApp displaying JSON Output of Current Date in ISO 8601 format


Simple Web App Terraform Deployment
===================================
Requirements:
- az cli 
- Terraform executable
- Github account with a Personal Access Token (PAT) to read public repos

Fork a copy of this Github repo & use the url to the master branch in your execution:
 https://github.com/femid/simpleazurewebapp

Store these Terraform files in a local directory:
- main.tf and variables.tf
 
Navigate in PowerShell to directory containing the files above 
	E.g. cd C:\temp\SimpleWebApp

Steps to build the webapp
-------------------------
"az login" on administrative terminal & login via web prompt
"az account show" to verify you are on the right tenant

"terraform init" to initialize the directory & download the provider packages
"terraform fmt" to format any files if needed
"terraform validate" to check if the config is valid

"terraform plan out=deployplan" to create a deployment plan for the resources to be created/modified. Enter variables as prompted:
- Azure SubscriptionID
- Resourcegroup Name
- Location
- App ServicePlan Name
- WebApp Name (4 digit random number will be auto-appended)
- GitHub URL (use the forked copy from your github repo)
- GitHub PAT (needs "Read Public Repos" permission)

"terraform apply "deployplan"" to execute the stored plan and variables
Note the hostname output at the end of the 'apply' process

To retrieve webapp content:
"curl <hostname>" or using PowerShell: "Invoke-WebRequest -Uri <hostname> | Select-Object Content"
JSON Date output will be shown under the Content section


