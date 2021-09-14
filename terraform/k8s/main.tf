module "backend" {
  source = "./modules/containers/backend"
}

module "frontend" {
  source = "./modules/containers/frontend"
}
