# di-accounts-infra

## Accounts Platform codebase

A repo for manually deployed CloudFormation templates

- [Account Management Frontend](account-mgmt-frontend-seed/README.md)
- [IAM Permissions](iam-permissions/README.md)
- Platform
  - [Alerting](platform-alerting/README.md)
  - [Common](platform-common/README.md)
  - [DNS](platform-dns/README.md)
  - [DNS Certs](platform-dns-certs/README.md)
  - [Global Resource](platform-global-resources/README.md)
- [Shared Redis](shared-redis/README.md)
-
## Prerequisites

### Pre-commit

#### Install
```bash
brew install pre-commit
pre-commit --version
```

#### Enable on Pre-commit Git Hooks on Local Machine
```bash
cd di-accounts-infra
pre-commit install
```

## Pre-commit Problems

### finds a secrets
When a `Detect secrets.........Failed` occurs, run
```bash
detect-secrets audit .secrets.baseline
```
and confirm if the secrets highlighted are actually secret or are they a placeholder value only.
