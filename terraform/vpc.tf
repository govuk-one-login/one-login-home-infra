resource "aws_cloudformation_stack" "transit_gateway_cross_account_role" {
  name         = "transit-gateway-cross-account-role"
  template_url = "https://template-storage-templatebucket-1upzyw6v9cs42.s3.eu-west-2.amazonaws.com/tgw-cross-account-role/template-v2.yaml"

  parameters = {
    HubAccountId                 = var.transit_gateway_hub_account_id
    DisasterRecoveryHubAccountId = var.disaster_recovery_transit_gateway_hub_account_id
  }

  capabilities = var.capabilities
}

resource "aws_cloudformation_stack" "vpc_spoke_stack" {
  # Spoke VPC attached to the Transit Gateway Hub.
  # See https://govukverify.atlassian.net/wiki/spaces/TGHM/pages/6982074448/Set+up+your+new+VPC+and+other+resources+needed+to+onboard
  name         = "vpc-spoke"
  template_url = "https://template-storage-templatebucket-1upzyw6v9cs42.s3.eu-west-2.amazonaws.com/vpc/template-v4.yaml"

  parameters = {
    VpcType     = "Spoke"
    Environment = var.environment

    # Egress allowlist mirrors the legacy vpc-enhanced stack so no functionality is lost.
    # Suricata AllowRules are Legacy-only (the TGW Hub performs central firewall inspection);
    # the SNIs they covered (gov.uk, Notify, Zendesk) are all covered by AllowedDomains.
    AllowedDomains = "*.account.gov.uk,*.service.gov.uk,*.settings.gov.uk,*.govuk.digital,*.zendesk.com,*.notifications.service.gov.uk,*.cloudfront.net"

    # VPC interface endpoints mirror the legacy stack.
    CloudFormationEndpointEnabled = "Yes"
    CloudWatchLogsApiEnabled      = "Yes"
    CodeBuildApiEnabled           = "Yes"
    DynamoDBApiEnabled            = "Yes"
    DynatraceApiEnabled           = "Yes"
    ECRApiEnabled                 = "Yes"
    ExecuteApiGatewayEnabled      = "Yes"
    KMSApiEnabled                 = "Yes"
    LambdaApiEnabled              = "Yes"
    S3ApiEnabled                  = "Yes"
    SecretsManagerApiEnabled      = "Yes" #pragma: allowlist secret
    SNSApiEnabled                 = "Yes"
    SQSApiEnabled                 = "Yes"
    SSMApiEnabled                 = "Yes"
    SSMParametersStoreEnabled     = "Yes"
    StatesApiEnabled              = "Yes"
    VpcLinkEnabled                = "Yes"
    XRayApiEnabled                = "Yes"

    # Egress test lambda to validate TGW egress for AMF's external domains (see runbook).
    DeployEgressTestLambda     = "Yes"
    EgressTestLambdaCustomURLs = "https://api.notifications.service.gov.uk,https://govuk1620731396.zendesk.com"
  }

  capabilities = var.capabilities
}
