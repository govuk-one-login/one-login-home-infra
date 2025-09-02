resource "aws_cloudformation_stack" "vpc_stack" {
  # See https://govukverify.atlassian.net/wiki/spaces/PLAT/pages/3531735041/VPC
  provider     = aws.london
  name         = "dev-platform-vpc"
  template_url = "https://template-storage-templatebucket-1upzyw6v9cs42.s3.amazonaws.com/vpc/template.yaml"

  parameters = {
    AvailabilityZoneCount     = 3
    AllowedDomains            = "*.account.gov.uk,*.service.gov.uk,*.govuk.digital,*.zendesk.com,*.notifications.service.gov.uk,*.cloudfront.net"
    AllowRules                = <<-EOT
    pass tls $HOME_NET any -> $EXTERNAL_NET 443 (tls.sni; content:"gov.uk"; endswith; msg:"Pass TLS to *.gov.uk"; flow:established; sid:2001; rev:1;)
    pass tls $HOME_NET any -> $EXTERNAL_NET 443 (tls.sni; content:"api.notifications.service.gov.uk"; endswith; msg:"Pass TLS to *.notifications.service.gov.uk"; flow:established; sid:2003; rev:1;)
    pass tls $HOME_NET any -> $EXTERNAL_NET 443 (tls.sni; content:"govuk.zendesk.com"; endswith; msg:"Pass TLS to *.zendesk.com"; flow:established; sid:2002; rev:1;)
    EOT
    DynamoDBApiEnabled        = "Yes"
    DynatraceApiEnabled       = "Yes"
    ECRApiEnabled             = "Yes"
    ExecuteApiGatewayEnabled  = "Yes"
    KMSApiEnabled             = "Yes"
    LambdaApiEnabled          = "Yes"
    LogsApiEnabled            = "Yes"
    S3ApiEnabled              = "Yes"
    SecretsManagerApiEnabled  = "Yes"
    SNSApiEnabled             = "Yes"
    SQSApiEnabled             = "Yes"
    SSMApiEnabled             = "Yes"
    SSMParametersStoreEnabled = "Yes"
    StatesApiEnabled          = "Yes"
    VpcLinkEnabled            = "Yes"
    XRayApiEnabled            = "Yes"
  }

  capabilities = ["CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
}
