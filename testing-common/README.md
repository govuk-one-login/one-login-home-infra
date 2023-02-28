# Accounts - Testing Common

## Intro
The CloudFormation template creates the prerequisite Testing Common resources used by QA Team for executing tests.

## Deployment
To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

### Creating a New Stack
Replace `<environment>` with `dev`, `build`, `staging`, `integration` in the commands below.
Replace `<environment-role>` with di-account-role that you are trying to assume.
```bash
gds-cli aws di-account-<environment-role> \
aws cloudformation create-stack --stack-name testing-common \
--template-body file://$(pwd)/testing-common/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Updating an Existing Stack
Replace `<environment>` with `dev`, `build`, `staging`, `integration` in the commands below.
Replace `<environment-role>` with di-account-role that you are trying to assume.
```bash
gds-cli aws di-account-<environment-role> \
aws cloudformation update-stack --stack-name testing-common \
--template-body file://$(pwd)/testing-common/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```
