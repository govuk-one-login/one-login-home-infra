# Accounts - DNS Certs

## Intro

The CloudFormation template creates an ACM Certificate for `<subdomain>.account.gov.uk`
or `<subdomain>.<environment>.account.gov.uk` if environment is not `production`.

This Stack is deployed manually once per account/environment as part of the DNS set up process.
This stack should only be deployed ****after**** the
[di-infrastucture](https://github.com/alphagov/di-infrastructure/tree/main/terraform/domain) repo has been
deployed and a DNS lookup returns the nameservers for the domain.

This stack will create the SSL/TLS certificate for the subdomain.

### Domains

The template creates Certificates for the following subdomain(s):

- `home`

## Deployment

To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

Make sure you've [set up your AWS CLI to use SSO](https://team-manual.account.gov.uk/teams/home-team/working-on-the-home-team/aws-accounts/#accessing-aws-via-the-command-line-interface-cli) as described in the team manual, then sign in:

```bash
aws sso login --profile di-account-dev
```

Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in either of the commands below.

### Creating a New Stack

```bash
aws cloudformation create-stack --stack-name dns-certs \
--template-body file://$(pwd)/platform-dns-certs/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

### Updating the Stack

```bash
aws cloudformation update-stack --stack-name dns-certs \
--template-body file://$(pwd)/platform-dns-certs/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

### Stack Outputs

| Type          | Name                                                          | Description                                   |
| ------------- | ------------------------------------------------------------- | --------------------------------------------- |
| SSM Parameter | `/<Environment>/Platform/ACM/HostedZone/Certificate/Home/ARN` | The ARN of the ACM cert for the `home` domain |
