resource "aws_cloudformation_stack" "backup_vault_monitoring_stack" {
  count = contains(["staging", "integration", "production"], var.environment) ? 1 : 0
  # See https://github.com/govuk-one-login/backup-as-a-service/blob/main/backup-vault-monitoring/template.yaml
  provider     = aws.london
  name         = "backup-vault-monitoring"
  template_url = "https://backup-template-storage-templatebucket-747f3bzunrod.s3.eu-west-2.amazonaws.com/backup-vault-monitoring/template.yaml"

  parameters = {
    SlackWorkspaceId  = "T8GT9416G"
    SlackChannelId    = var.notifications_slack_channel_id
    DeployChatBot     = "No"
    CreateChatBotRole = "No"
  }

  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
}
