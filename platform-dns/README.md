# Accounts - DNS Hosted Zones

## Intro
The CloudFormation template creates a hosted zone for `<subdomain>.accounts.gov.uk` 
or `<subdomain>.<environment>.accounts.gov.uk` if environment is not `production`.

This Stack is deployed manually once per account/environment 
as part of the DNS set up process.  

Once the hosted zone(s) is created, there will be a nameserver record created for each zone.

Once deployed, the nameserver record lists the name servers that need to be added to appropriate environment's
terraform file in the [di-infrastucture](https://github.com/alphagov/di-infrastructure/tree/main/terraform/domain) repo.

N.B. the hosted zone(s) created by this template are retained even when the Stack is deleted.

### Domains
The template creates a Hosted Zone for the following subdomain(s):
 - `home`
 - `settings`

## Deployment
To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

Replace `<environment>` with `build`, `staging`, `integration`, `production` in either of the commands below.

### Creating a New Stack
```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation create-stack --stack-name dns-zones-<environment> \
--template-body file://$(pwd)/platform-dns/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Account" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Updating the Stack
```bash
gds-cli aws di-account-<environment>-admin \
aws cloudformation update-stack --stack-name dns-zones-<environment> \
--template-body file://$(pwd)/platform-dns/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Account" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Stack Outputs
| Type          | Name                                                  | Description                         |
|---------------|-------------------------------------------------------|-------------------------------------|
| Stack Export  | `HomeHostedZoneNameServers`                           | Comma separated list of Nameservers |
| Stack Export  | `HomeHostedZoneId`                                    | Id of the Route 53 Hosted Zone      |
| SSM Parameter | `/<environment>/Platform/Route53/HostedZone/Home`     | Id of the Route 53 Hosted Zone      |
| Stack Export  | `SettingsHostedZoneNameServers`                       | Comma separated list of Nameservers |
| Stack Export  | `SettingsHostedZoneId`                                | Id of the Route 53 Hosted Zone      |
| SSM Parameter | `/<environment>/Platform/Route53/HostedZone/Settings` | Id of the Route 53 Hosted Zone      |
