# Accounts - Common IAM permissions

## Intro

This template contains IAM permissions for access that's not specific to an application.
It should not be used for managing developer access.

## Deployment

To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

This template must be deployed manually in each AWS account.

### Creating a New Stack

Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in the commands below.

```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation create-stack --stack-name common-iam-permissions \
--template-body file://$(pwd)/iam-permissions/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

To update:

```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation update-stack --stack-name common-iam-permissions \
--template-body file://$(pwd)/iam-permissions/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Stack outputs

None
