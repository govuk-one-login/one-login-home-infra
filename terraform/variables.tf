variable "environment" {
  type        = string
  description = "The environment name"
  validation {
    condition     = contains(["staging", "integration", "production"], var.environment)
    error_message = "Valid values for var: environment are (staging, integration, production)"
  }

}

variable "notifications_slack_channel_id" {
  type        = string
  description = "ID of the channel to send Slack notifications to"
}
