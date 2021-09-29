data "azurerm_container_registry" "acr" {
  name                = "${var.PROJECT_NAME}k8sacr${var.ENVIRONMENT}" # Did you get an error saying that your repo must be globally unique? Try adding some extra charcters here
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_container_registry.acr
  ]
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.PROJECT_NAME}k8sacr${var.ENVIRONMENT}"
  resource_group_name = azurerm_resource_group.default.name
  location            = var.CLOUD_LOCATION
  sku                 = "Basic"
  admin_enabled       = true
  # georeplication_locations = ["${var.CLOUD_LOCATION}"]
  # retention_policy {
  #   enabled = true
  # }

  tags = {
    managed_by = "terraform"
  }

}
