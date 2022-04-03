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
1. "az login" on administrative terminal & login via web prompt
2. "az account show" to verify you are on the right tenant
3. "terraform init" to initialize the directory & download the provider packages
4. "terraform validate" to check if the config is valid

5. "terraform plan out=deployplan" to create a deployment plan for the resources to be created/modified. 
6. Enter variables as prompted:
	- App ServicePlan name 
	- GitHub PAT (needs "Read Public Repos" permission)
	- Location (Azure region to host resources. E.g. South Central US, UK South, West Europe, Southeast Asia")
	- GitHub URL (use the forked copy from your github repo)
	- Resource Group name
	- Azure Subscription ID
	- WebApp Name (4 digit random number will be auto-appended)

6. "terraform apply "deployplan"" to execute the stored plan and variables. 
7. Note the hostname output at the end of the 'apply' process

To retrieve webapp content
--------------------------
"curl <hostname>" or using PowerShell: "Invoke-WebRequest -Uri <hostname> | Select-Object Content"
- JSON Date output will be shown under the Content section

Remove the infrastructure
-------------------------
"terraform destroy" and re-enter the same variables used during the "terraform plan..." step
