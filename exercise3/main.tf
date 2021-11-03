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

resource "azurerm_app_service_plan" "plan" {
  name                = "plan-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku {
    size = 1
    capacity = 1
    tier = 1
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}

output "webapp_name" {
  description = "output Name of the webapp"
  value       = azurerm_app_service.app.name
}
