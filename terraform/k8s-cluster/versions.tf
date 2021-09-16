terraform {
  backend "remote" {
    organization = "birki-io" # Change this to your own organization

    workspaces {
      name = "k8s-cluster-testing" # Change this to your own workspace name
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.2.1"
    }
  }

  required_version = "=1.0.6" # Change this to a different version if you want
}
