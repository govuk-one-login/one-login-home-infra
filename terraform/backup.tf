resource "aws_cloudformation_stack" "backup_vault_monitoring_stack" {
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

resource "aws_cloudformation_stack" "restore_testing_stack" {
  count = var.environment == "staging" ? 1 : 0
  # See https://github.com/govuk-one-login/backup-as-a-service/blob/main/restore-testing/template.yaml
  provider      = aws.london
  name          = "backup-restore-testing"
  template_body = file("./restore_testing.cf.yaml")

  parameters = {
    CronExpression = "cron(0 10 ? * 3#2 *)" # At 10:00 AM on the second Tuesday of each month (UTC+00:00)
  }

  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
}
