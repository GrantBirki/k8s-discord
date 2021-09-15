variable "IMAGE_TAG" {
  description = "The image tag to use for deployments"
  default     = "latest"
  type        = string
}

variable "ENVIRONMENT" {
  description = "The Environment context which all containers are running in (dev/prod)"
  type        = string
  default     = "prod"
}
