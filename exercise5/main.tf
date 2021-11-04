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

data "external" "getlocation" {
  program = ["Powershell.exe", "./GetLocation.ps1"]
  query = {
    environment = "${var.environment}"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = data.external.getlocation.result.location
}

output "locationname" {
  value = data.external.getlocation.result.location
}
