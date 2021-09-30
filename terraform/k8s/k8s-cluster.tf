data "terraform_remote_state" "k8s_cluster" {
  backend = "remote"

  config = {
    organization = "birki-io" # Change this to your organization (CHANGE ME)
    workspaces = {
      name = "k8s-cluster-testing" # Change this to your own workspace name pointing to your k8s-cluster TF remote (CHANGE ME)
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

data "azurerm_container_registry" "acr" {
  name                = data.terraform_remote_state.k8s_cluster.outputs.acr_name
  resource_group_name = data.terraform_remote_state.k8s_cluster.outputs.resource_group_name
}

data "azurerm_kubernetes_cluster" "cluster" {
  name                = data.terraform_remote_state.k8s_cluster.outputs.kubernetes_cluster_name
  resource_group_name = data.terraform_remote_state.k8s_cluster.outputs.resource_group_name
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

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  token                  = data.azurerm_kubernetes_cluster.cluster.kube_config.0.password
  load_config_file       = true
  apply_retry_count      = 3
}