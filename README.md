# Terraforms - infrescture as code - Azure

This project has goal some exercises using terraforms applyied to azure cloud context

## Installation

Download [terraforms](https://www.terraform.io/downloads.html) and configure the enviroment variable or 
using windows script as [chocolatey](https://chocolatey.org/) run:

```bash
choco install -y  terraform
```

Download the [azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli) ou install using power shell


# Getting Started

1. run the command to autanticate on azure using azure CLI
```bash
az login
```
2. inside each exercise run  
```bash
terraform init
```
to initialize the script with current version configured on main.tf
