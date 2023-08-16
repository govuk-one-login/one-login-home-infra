# Accounts - Global Resources 

This template contains
- The WAF for produciton & integration (externally accessible)
- An IP limnited WAF for lower environments (internally accessible)
- A certificate for the external domain

## Deployment

To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

Replace `<environment>` with `dev`, `build-admin`, `staging-admin`, `integration-admin`, `production-admin` in either of the commands below.

### Updating the Stack

```bash
gds-cli aws di-account-<environment> \
aws cloudformation update-stack --stack-name platform-global-resources \
--template-body file://$(pwd)/template.yaml \
--region us-east-1 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```bash