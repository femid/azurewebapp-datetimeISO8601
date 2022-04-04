# simpleazurewebapp
Deploys an Azure WebApp displaying JSON Output of Current Date in ISO 8601 format

Simple Web App deployment using Terraform
=========================================
This web application is built using an Azure App Service plan, an App Service (Linux) running a Python script to generate the ISO 8601 standard date in a JSON format. An Azure App Service was used as they are highly configurable & can use different coding stacks (.NET, PHP, Python, etc.). Python scripts require the use of at least a basic (B1) app service plan, as the free tier (Y1) is not currently supported. If lowest cost was desired, Azure Function Apps could be used to deploy the code instead.


Requirements:
- az cli 
- Terraform executable
- Github account with a Personal Access Token (PAT) to read public repos

*Fork a copy of this Github repo & use the forked repo url & the "main" branch in your execution:*

Download the repo zipped files, then extract the two files in the `terraform` directory in a local directory:
- `main.tf` and `variables.tf`
 
Navigate in an (admin privleged) terminal to the directory containing the unzipped files above.

Steps to build the webapp
-------------------------
1. `az login` on administrative terminal & login via web prompt.
2. `az account show` to verify you are on the right tenant.
3. `terraform init` to initialize the directory & download the provider packages.
4. `terraform validate` to check if the config is valid.

5. `terraform plan -out=deployplan` to create a deployment plan & output file for the resources to be created/modified. 
6. Enter variables as prompted:
	- App ServicePlan name 
	- GitHub PAT (needs "Read Public Repos" permission)
	- Location (Azure region to host resources. E.g. South Central US, UK South, West Europe, Southeast Asia")
	- GitHub URL (use the forked copy from your github repo)
	- Resource Group name
	- Azure Subscription ID
	- WebApp Name (4 digit random number will be auto-appended)

6. `terraform apply "deployplan"` to execute the stored plan and variables. 
7. **Note the hostname output at the end of the `terraform apply...` process.**

To retrieve webapp content
--------------------------
1. Wait for a few minutes for the github code deployment to complete on the webapp.
2. Execute `curl "hostname"` or using PowerShell: `Invoke-WebRequest -Uri "hostname" | Select-Object Content`
- 	Replace `"hostname"` with the output default_hostname from the `terraform apply...` step
-	JSON Date output will be shown under the Content section

Remove the infrastructure
-------------------------
`terraform destroy` and re-enter the same variables used during the `terraform plan...` step.
