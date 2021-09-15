variable "DISCORD_TOKEN" {
  description = "The Discord Token for the Bot"
  type        = string
  sensitive   = true
}

variable "TEST_GUILD_ID" {
  description = "The Discord Guild ID to use for testing (if applicable)"
  default     = "none"
  type        = string
  sensitive   = true
}

variable "CLIENT_ID" {
  description = "The Client ID for the Bot"
  type        = string
  sensitive   = true
}

variable "ENVIRONMENT" {
  description = "The Environment context which all containers are running in (dev/prod)"
  type        = string
  default     = "prod"
}
