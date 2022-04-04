#variables for web app deployment
variable "subscription_id" {
  type = string
  description = "Azure subscription ID to deploy the infrastructure to"
}

variable "resource_group_name" {
  type = string
  description = "Name of Resource group for infrastructure. E.g WEBAPP-TEST-RG"
}

variable "location" {
  type = string
  description = "Azure region to host resources. E.g. South Central US, UK South, West Europe, etc. https://github.com/claranet/terraform-azurerm-regions/blob/master/REGIONS.md"
}

variable "appserviceplan_name" {
  type = string
  description = "Name of the App service plan to host the Web App. E.g AppServicePlan-B1"
}

variable "webapp_name" {
  type = string
  description = "Unique name of Web app to host the site. E.g. WebApp-FD"
}

variable "github_token" {
  type = string
  description = "Personal Access Token(PAT) with at least 'Read Public Repos' permission"
}

variable "repo_url" {
  type = string
  description = "GitHub repo URL that your GitHub PAT can access. E.g 'https://github.com/<YOUR GITHUB ACCOUNT>/simpleazurewebapp'"
}
