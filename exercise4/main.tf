terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
provider "azurerm" {
  features {

  }
}

locals {
  resource_name = "${var.resource_group_name}-${var.location}"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "pip" {
  name                = local.resource_name
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rg.name
  domain_name_label   = "bookdevops"
  allocation_method   = "Static"
}

data "azurerm_app_service_plan" "getting_existing_azure_plan" {
  name                = "service_plan_name_from_where_want_take"
  resource_group_name = "it_resource_group_name"
}

resource "azurerm_app_service" "app" {
  name                = "app-service-${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = data.azurerm_app_service_plan.getting_existing_azure_plan.id
}

output "webapp_name" {
  description = "output Name of the webapp"
  value       = azurerm_app_service.app.name
}

output "publicapi_name" {
  description = "output Name of the public api"
  value       = azurerm_public_ip.pip.name
}
