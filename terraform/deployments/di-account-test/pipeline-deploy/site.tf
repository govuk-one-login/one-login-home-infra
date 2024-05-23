terraform {
  required_version = ">= 1.3.0"

  # Comment out when bootstrapping
  backend "s3" {
    bucket = "di-account-home-tfstate"
    key    = "di-account-home/pipeline_deploy.tfstate"
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
  allowed_account_ids = [""]
  region              = "eu-west-2"
}