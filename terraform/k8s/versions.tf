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
