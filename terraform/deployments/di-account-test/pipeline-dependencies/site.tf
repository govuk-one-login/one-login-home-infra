terraform {
  required_version = ">= 1.3.0"

  # Comment out when bootstrapping
  backend "s3" {
    bucket = "di-account-test-tfstate"
    key    = "di-account-test/pipeline_dependencies.tfstate"
    region = "eu-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  allowed_account_ids = ["654654326096"] #di-account-test-id
  region              = "eu-west-2"
}

module "state_bucket" {
  source         = "git@github.com:govuk-one-login/ipv-terraform-modules.git//common/state-bucket-logging-tls"
  bucket_name    = "di-account-test-tfstate"
  logging_bucket = "di-account-test-access-logs"
  enable_tls     = true
}

module "logging_bucket" {
  source         = "git@github.com:govuk-one-login/ipv-terraform-modules.git//common/state-bucket-logging-tls"
  bucket_name    = "di-account-test-access-logs"
  enable_tls     = true
}
