module "backend" {
  source = "./modules/containers/backend"
}

module "frontend" {
  source = "./modules/containers/frontend"

  # Secret variables
  DISCORD_TOKEN = var.DISCORD_TOKEN
  TEST_GUILD_ID = var.TEST_GUILD_ID
  CLIENT_ID     = var.CLIENT_ID
  # Environment variables
  ENVIRONMENT   = var.ENVIRONMENT
}
