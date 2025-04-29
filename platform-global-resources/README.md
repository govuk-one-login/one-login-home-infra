# Accounts - Global Resources

This template contains

- A certificate for the external domain

## Deployment

To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

Replace `<environment>` with `dev`, `build-admin`, `staging-admin`, `integration-admin`, `production-admin` in the command below.

### Updating the Stack

Make sure you've [set up your AWS CLI to use SSO](https://team-manual.account.gov.uk/teams/home-team/working-on-the-home-team/aws-accounts/#accessing-aws-via-the-command-line-interface-cli) as described in the team manual, then sign in:

```bash
aws sso login --profile di-account-dev
```

To update the stack, run:

```bash
aws cloudformation update-stack --stack-name platform-global-resources \
--template-body file://$(pwd)/template.yaml \
--region us-east-1 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```
