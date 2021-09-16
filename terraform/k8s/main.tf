# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # Ignore Auth Warnings
  skip_provider_registration = true

  client_secret   = var.CLIENT_SECRET
  client_id       = var.CLIENT_ID
  tenant_id       = var.TENANT_ID
  subscription_id = var.SUBSCRIPTION_ID
}

module "backend" {
  source = "./modules/containers/backend"

  # Environment variables
  IMAGE_TAG   = var.IMAGE_TAG
  ENVIRONMENT = var.ENVIRONMENT
}

module "frontend" {
  source = "./modules/containers/frontend"

  # Secret variables
  DISCORD_TOKEN = var.DISCORD_TOKEN
  # Environment variables
  IMAGE_TAG   = var.IMAGE_TAG
  ENVIRONMENT = var.ENVIRONMENT
}
