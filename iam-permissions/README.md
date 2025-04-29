# Accounts - Common IAM permissions

## Intro

This template contains IAM permissions for access that's not specific to an application.
It should not be used for managing developer access.

## Deployment

This template must be deployed manually in each AWS account.

Make sure you've [set up your AWS CLI to use SSO](https://team-manual.account.gov.uk/teams/home-team/working-on-the-home-team/aws-accounts/#accessing-aws-via-the-command-line-interface-cli) as described in the team manual, then sign in:

```bash
aws sso login --profile di-account-dev
```

### Creating a New Stack

Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in the commands below.

```bash
aws cloudformation create-stack --stack-name common-iam-permissions \
--template-body file://$(pwd)/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

To update:

```bash
aws cloudformation update-stack --stack-name common-iam-permissions \
--template-body file://$(pwd)/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

### Stack outputs

None
