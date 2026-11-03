resource "aws_cloudformation_stack" "transit_gateway_cross_account_role" {
  name         = "transit-gateway-cross-account-role"
  template_url = "https://template-storage-templatebucket-1upzyw6v9cs42.s3.eu-west-2.amazonaws.com/tgw-cross-account-role/template-v2.yaml"

  parameters = {
    HubAccountId                 = var.transit_gateway_hub_account_id
    DisasterRecoveryHubAccountId = var.disaster_recovery_transit_gateway_hub_account_id
  }

  capabilities = var.capabilities
}
