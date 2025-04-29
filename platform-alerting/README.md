# Accounts - Platform Common Config

## Intro

Consolidated alerting functionality to create a general platform alerting template with a subscription endpoint for PagerDuty and a single Chatbot configuration for all Slack alerts.

## Deployment

Make sure you've [set up your AWS CLI to use SSO](https://team-manual.account.gov.uk/teams/home-team/working-on-the-home-team/aws-accounts/#accessing-aws-via-the-command-line-interface-cli) as described in the team manual, then sign in:

```bash
aws sso login --profile di-account-dev
```

### Creating a New Stack

Replace `<environment>` with `build`, `staging`, `integration`, `production` in the commands below.

```bash
aws cloudformation create-stack --stack-name platform-alerting \
--template-body file://$(pwd)/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

To update:

```bash
aws cloudformation update-stack --stack-name platform-alerting \
--template-body file://$(pwd)/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

### Stack Outputs

| Type      | Name                                      | Description                                      |
| --------- | ----------------------------------------- | ------------------------------------------------ |
| SNS Topic | `<environment>-BuildNotificationTopicArn` | ARN of the pipeline build notification SNS topic |
