# Accounts - Platform Common Config

## Intro
Externalise values referenced across multiple CloudFormation Stacks.
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
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

To update:
```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation update-stack --stack-name platform-common \
--template-body file://$(pwd)/platform-common/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Stack Outputs
| Type           | Name                                                      | Description                                                                                                                                                                                                            |
|----------------|-----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SSM Parameter  | `/<environment>/Platform/Logs/Subscription/CSLS/ARN`      | ARN of endpoint used to consume CloudWatch Logs into [CSLS](https://github.com/alphagov/centralised-security-logging-service)                                                                                          |
| SSM Parameter  | `/<environment>/Platform/ACM/Global/Certificate/Home/ARN` | ARN of the Global Cert for the home subdomain. To be used for setting the domain on a CloudFront Distribution.                                                                                                         |
| SSM Parameter  | `/<environment>/Platform/WAF/Global/ACL/ARN`              | ARN of the default Global Web ACL. To be used for protecting a CloudFront Distribution.                                                                                                                                |
| Secret Manager | `pipeline-grafana-api-key`                                | Grafana API key - see [here](https://govukverify.atlassian.net/wiki/spaces/PLAT/pages/3062726680/How+to+prepare+AWS+accounts+for+containing+SAM+deployment+pipelines#Grafana-Annotations%2C-API-key-and-key-rotation)  |
