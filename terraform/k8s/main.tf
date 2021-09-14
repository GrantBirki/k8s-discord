module "backend" {
  source = "./modules/containers/backend"
}

module "frontend" {
  depends_on = [
    module.backend
  ]
  source = "./modules/containers/frontend"
}
