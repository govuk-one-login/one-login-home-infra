# Accounts - Platform Common Config

## Intro
Consolidated alerting functionality to create a general platform alerting template with a subscription endpoint for PagerDuty and a single Chatbot configuration for all Slack alerts.

## Deployment
To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

### Creating a New Stack

Replace `<environment>` with `build`, `staging`, `integration`, `production` in the commands below.
```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation create-stack --stack-name platform-alerting \
--template-body file://$(pwd)/platform-alerting/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

To update:
```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation update-stack --stack-name platform-alerting \
--template-body file://$(pwd)/platform-alerting/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Stack Outputs
| Type           | Name                                                      | Description                                                                                                                                                                                                            |
|----------------|-----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SNS Topic      | `<environment>-BuildNotificationTopicArn`                 | ARN of the pipeline build notification SNS topic                                                                                   |
