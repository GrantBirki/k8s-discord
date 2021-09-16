data "terraform_remote_state" "aks" {
  backend = "remote"

  config = {
    organization = "birki-io" # Change this to your organization
    workspaces = {
      name = "k8s-cluster-testing" # Change this to your own workspace name pointing to your k8s-cluster TF remote
    }
  }
}

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


data "azurerm_kubernetes_cluster" "cluster" {
  name                = data.terraform_remote_state.aks.outputs.kubernetes_cluster_name
  resource_group_name = data.terraform_remote_state.aks.outputs.resource_group_name
}

provider "kubernetes" {
  host = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host

  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  experiments {
    manifest_resource = true
  }
}
