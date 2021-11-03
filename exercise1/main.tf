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

variable "resource_group_name" {
  description = "The resources group name"
  default = "My-RG"
}
variable "location" {
  description = "The location name"
  default = "westeurope"
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
