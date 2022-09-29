# DNS Zones

This is deployed manually once per account to setup DNS by creating a Hosted Zone within the AWS account.

Once a hosted zone is created, there will be a nameserver record created for the zone. 
Once deployed, the nameserver record lists the name servers that need to be added to appropriate environment's 
terraform file in the [di-infrastucture](https://github.com/alphagov/di-infrastructure/tree/main/terraform/domain) repo.

To deploy the template to the appropriate AWS account, 
replace `<environment>` with `build`, `staging`, `integration`, `production`:
```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation create-stack --stack-name dns-zones --template-body file:///<a-local-path>/di-accounts-infra/platform-dns/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Account" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```


