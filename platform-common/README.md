# Accounts - Authentication Account Management (AAM) - Seed Stack

## Intro
Externalises values referenced across multiple CloudFormation Stacks.
This prevents having to individually update each reference of a single value across multiple Stacks.
Values will instead resolve as SSM parameters or Secrets acting as the single source of truth.

## Deployment
To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

### Creating a New Stack

Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in the commands below.
```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation create-stack --stack-name platform-common \
--template-body file://$(pwd)/platform-common/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>"  
```
