data "aws_organizations_organization" "gds" {}


data "aws_cloudformation_stack" "aws-signer" {
  name = "aws-signer-pipeline"
}

module "home-backend-pipeline" {
  source     = "git@github.com:govuk-one-login/ipv-terraform-modules.git//secure-pipeline/deploy-pipeline"
  stack_name = "home-backend-pipeline"
  parameters = {
    SAMStackName    = "home-backend"
    Environment     = "demo"
    VpcStackName    = "vpc"
    IncludePromotion = "No"
    # AWSOrganizationId          = data.aws_organizations_organization.gds.id
    LogRetentionDays           = 7
    SigningProfileArn          = data.aws_cloudformation_stack.aws-signer.outputs["SigningProfileArn"]
    SigningProfileVersionArn   = data.aws_cloudformation_stack.aws-signer.outputs["SigningProfileVersionArn"]
    OneLoginRepositoryName     = "di-account-management-backend"
    SlackNotificationType      = "Failures"
    BuildNotificationStackName = "di-account-test-notifications"
  }

  tags_custom = {
    System = "DI Account Home"
  }
}

module "home-stubs-pipeline" {
  source     = "git@github.com:govuk-one-login/ipv-terraform-modules.git//secure-pipeline/deploy-pipeline"
  stack_name = "home-stubs-pipeline"
  parameters = {
    SAMStackName    = "home-stubs"
    Environment     = "demo"
    VpcStackName    = "vpc"
    IncludePromotion = "No"
    # AWSOrganizationId          = data.aws_organizations_organization.gds.id
    LogRetentionDays           = 7
    SigningProfileArn          = data.aws_cloudformation_stack.aws-signer.outputs["SigningProfileArn"]
    SigningProfileVersionArn   = data.aws_cloudformation_stack.aws-signer.outputs["SigningProfileVersionArn"]
    OneLoginRepositoryName     = "account-management-stubs"
    SlackNotificationType      = "Failures"
    BuildNotificationStackName = "di-account-test-notifications"
  }

  tags_custom = {
    System = "DI Account Home"
  }
}

module "home-data-backend-pipeline" {
  source     = "git@github.com:govuk-one-login/ipv-terraform-modules.git//secure-pipeline/deploy-pipeline"
  stack_name = "home-data-backend-pipeline"
  parameters = {
    SAMStackName    = "home-data-backend"
    Environment     = "demo"
    VpcStackName    = "vpc"
    IncludePromotion = "No"
    # AWSOrganizationId          = data.aws_organizations_organization.gds.id
    LogRetentionDays           = 7
    SigningProfileArn          = data.aws_cloudformation_stack.aws-signer.outputs["SigningProfileArn"]
    SigningProfileVersionArn   = data.aws_cloudformation_stack.aws-signer.outputs["SigningProfileVersionArn"]
    OneLoginRepositoryName     = "di-account-data-backend"
  }

  tags_custom = {
    System = "DI Account Home"
  }
}