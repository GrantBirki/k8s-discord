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
