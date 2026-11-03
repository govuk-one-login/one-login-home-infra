variable "environment" {
  type        = string
  description = "The environment name"
  validation {
    condition     = contains(["dev", "build", "staging", "integration", "production"], var.environment)
    error_message = "Valid values for var: environment are (dev, build, staging, integration, production)"
  }
}

variable "capabilities" {
  type    = list(string)
  default = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
}

variable "notifications_slack_channel_id" {
  type        = string
  description = "ID of the channel to send Slack notifications to"
}

variable "transit_gateway_hub_account_id" {
  type        = string
  description = "Transit Gateway Hub AWS Account ID where the Lambda execution role lives."
}

variable "disaster_recovery_transit_gateway_hub_account_id" {
  type        = string
  description = "Disaster recovery Transit Gateway Hub AWS Account ID where the Lambda execution role lives."
  default     = null
}
