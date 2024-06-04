terraform {
  required_version = ">= 1.3.0"

  # Comment out when bootstrapping
  backend "s3" {
    bucket = "di-account-test-tfstate"
    key    = "di-account-test/pipeline_deploy.tfstate"
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