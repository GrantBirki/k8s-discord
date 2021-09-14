# You may edit any of the default values in this file to tweak your cluster settings
# Examples: Change the number of nodes, the size of your nodes, your nodes storage, the name of your cluster, the region, etc

variable "project_name" {
  description = "The name of your project"
  default     = "birki" # Change the name here to something unique for your own cluster
  type        = string
}

variable "node_count" {
  description = "Number of Nodes in your K8s cluster"
  default     = 2
  type        = number
}

variable "vm_size" {
  description = "Size of the VM to create"
  default     = "Standard_B2s"
  type        = string
}

variable "cloud_location" {
  description = "Location/Region for the cloud provider to deploy your cluster in"
  default = "West US 2"
  type = string
}

variable "node_disk_size_gb" {
  description = "The size in GB of the storage on each node"
  default     = 30
  type        = number
}

variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}
