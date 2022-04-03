#Deploy a resource group, app service plan, web app & deploy code from a GitHub repo url

# Configure the needed providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version =  "=3.0.2"
    }
    random = {
      source = "hashicorp/random"
      version = "=3.1.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

# create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# create a Linux app service plan 
resource "azurerm_service_plan" "appsrvplan" {
  name                = var.appserviceplan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1" #needed for Python
  depends_on = [
    azurerm_resource_group.rg
  ]
}


# Generate a random number (for use in webapp's name)
resource "random_integer" "rand_num" {
  min = 1000
  max = 9999
}

/* Apr 2 2022 - Unable to set linux version in newer web app resource, using depracated app service below
resource "azurerm_linux_web_app" "webapp" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.appsrvplan.id
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_service_plan.appsrvplan
  ]

  #application_stack{
  #  python_version = "3.9"
  #}

  site_config { }
}
*/

#create 'deprecated' app service with linux. Needed to set Python version
resource "azurerm_app_service" "webapp" {
  #concat name with random number 
  name                = format("%s-%s", var.webapp_name, random_integer.rand_num.id) 
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.appsrvplan.id

  site_config {
    linux_fx_version = "PYTHON|3.9" 
  }
depends_on = [
  azurerm_resource_group.rg,
  azurerm_service_plan.appsrvplan,
  random_integer.rand_num
]
}

#retrieve github PAT token (must have 'read public repos' permission)
resource "azurerm_source_control_token" "github_token" {
  type  = "GitHub"
  token =  var.github_token 
}

#repo to pull python files from
resource "azurerm_app_service_source_control" "github_source" {
  app_id   = azurerm_app_service.webapp.id
  repo_url = var.repo_url
  branch   = "master"
}

#get data from the webapp
data "azurerm_linux_web_app" "webapp_data" {
  name                = format("%s-%s", var.webapp_name, random_integer.rand_num.id) 
  resource_group_name = var.resource_group_name
    depends_on = [
    azurerm_resource_group.rg,
    azurerm_app_service.webapp
  ]
}

#output hostname for webapp data
output "default_hostname" {
  value = data.azurerm_linux_web_app.webapp_data.default_hostname
}
