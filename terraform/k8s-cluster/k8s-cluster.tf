provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "${var.project_name}-k8s-rg"
  location = var.cloud_location

  tags = {
    created_by = "Terraform"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.project_name}-k8s-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.project_name}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.vm_size
    os_disk_size_gb = var.node_disk_size_gb
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    created_by = "Terraform"
  }
}
