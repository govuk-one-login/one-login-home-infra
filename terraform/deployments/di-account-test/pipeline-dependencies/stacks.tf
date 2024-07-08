module "aws-signer" {
  source     = "git@github.com:govuk-one-login/ipv-terraform-modules.git//secure-pipeline/aws-signer"
  stack_name = "aws-signer-pipeline"
  parameters = {
    Environment = "dev"
    System      = "DI Account Home"
  }

  tags_custom = {
    System = "DI Account Home"
  }
}

module "github-identity" {
  source     = "git@github.com:govuk-one-login/ipv-terraform-modules.git//secure-pipeline/github-identity-provider"
  stack_name = "github-identity"
  parameters = {
    Environment = "demo"
  }

  tags = {
    System = "DI Account Home"
  }
}

module "vpc" {
  source           = "git@github.com:govuk-one-login/ipv-terraform-modules.git//secure-pipeline/vpc"
  stack_name       = "vpc"
  allow_rules_file = "firewall_rules.txt"
  parameters = {
    CidrBlock                 = "10.0.0.0/16"
    AvailabilityZoneCount     = 2
    ZoneAEIPAllocationId      = "none"
    ZoneBEIPAllocationId      = "none"
    ZoneCEIPAllocationId      = "none"
    VpcLinkEnabled            = "Yes"
    AllowedDomains            = "none"
    LogsApiEnabled            = "Yes"
    CloudWatchApiEnabled      = "Yes"
    XRayApiEnabled            = "Yes"
    SSMApiEnabled             = "Yes"
    SecretsManagerApiEnabled  = "Yes"
    KMSApiEnabled             = "Yes"
    DynamoDBApiEnabled        = "Yes"
    S3ApiEnabled              = "Yes"
    SQSApiEnabled             = "Yes"
    SNSApiEnabled             = "Yes"
    KinesisApiEnabled         = "Yes"
    FirehoseApiEnabled        = "Yes"
    EventsApiEnabled          = "No"
    StatesApiEnabled          = "Yes"
    ECRApiEnabled             = "Yes"
    LambdaApiEnabled          = "Yes"
    CodeDeployApiEnabled      = "No"
    ExecuteApiGatewayEnabled  = "Yes"
    SSMParametersStoreEnabled = "Yes"
    RestAPIGWVpcLinkEnabled   = "No"
    DynatraceApiEnabled       = "Yes"
  }

  tags = {
    System = "DI Account Home"
  }
}