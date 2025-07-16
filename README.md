# One Login Home Infra

## Account Management Platform codebase

A repo for manually deployed CloudFormation templates.
These are deployed either with the AWS CLI, or managed by Terraform.

### AWS CLI

- [Account Management Frontend](account-mgmt-frontend-seed/README.md)
- [IAM Permissions](iam-permissions/README.md)
- Platform
  - [Alerting](platform-alerting/README.md)
  - [Common](platform-common/README.md)
  - [DNS](platform-dns/README.md)
  - [DNS Certs](platform-dns-certs/README.md)
  - [Global Resource](platform-global-resources/README.md)

### Terraform

- [Backup as a service monitoring](terraform/backup.tf)

The Terraform uses separate backend configuration and variables files for each environment.
To deploy into eg. staging:

```sh
cd terraform
aws sso login --profile di-account-staging-admin
AWS_PROFILE=di-account-staging-admin terraform init -backend-config=env/backend/staging.tfbackend
AWS_PROFILE=di-account-staging-admin terraform plan -var-file=env/staging.tfvars
AWS_PROFILE=di-account-staging-admin terraform apply -var-file=env/staging.tfvars
```

# Developer Guide

### Gitlint

This repository uses [Gitlint](https://jorisroovers.com/gitlint/latest/) to lint git commit messages.

Install Gitlint by running:

```bash
pip install pre-commit # or `brew install pre-commit` if using the Homebrew package manager
```

```bash
pip install gitlint # or `brew install gitlint` if using the Homebrew package manager
```

```bash
pre-commit install --hook-type commit-msg
```
