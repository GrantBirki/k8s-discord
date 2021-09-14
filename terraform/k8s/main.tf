module "kong" {
  source = "./modules/kong"
}

module "monitoring" {
  source = "./modules/monitoring"
}
