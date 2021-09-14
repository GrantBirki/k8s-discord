data "azurerm_container_registry" "acr" {
  name                = "${var.project_name}k8sacr" # Did you get an error saying that your repo must be globally unique? Try adding some extra charcters here
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_container_registry.acr
  ]
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.project_name}k8sacr"
  resource_group_name = azurerm_resource_group.default.name
  location            = var.cloud_location
  sku                 = "Basic"
  admin_enabled       = true
  # georeplication_locations = ["${var.cloud_location}"]
  # retention_policy {
  #   enabled = true
  # }

  tags = {
    managed_by = "terraform"
  }

}
