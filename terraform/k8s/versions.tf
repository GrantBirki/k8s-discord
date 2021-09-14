terraform {
  backend "remote" {
    organization = "birki-io" # Change this to your own organization

    workspaces {
      name = "k8s-workloads-testing" # Change this to your own workspace name
    }
  }
  required_version = "=1.0.6" # Change this to a different version if you want

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubectl" {
  host                   = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  token                  = data.azurerm_kubernetes_cluster.cluster.kube_config.0.password
  load_config_file       = true
  apply_retry_count      = 3
}
