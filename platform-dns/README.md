# Accounts - DNS Hosted Zones

## Intro

The CloudFormation template creates a hosted zone for `<subdomain>.account.gov.uk`
or `<subdomain>.<environment>.account.gov.uk` if environment is not `production`.

This Stack is deployed manually once per account/environment
as part of the DNS set up process.

Once the hosted zone(s) is created, there will be a nameserver record created for each zone.

Once deployed, the nameserver record lists the name servers that need to be added to appropriate environment's
terraform file in the [di-infrastucture](https://github.com/alphagov/di-infrastructure/tree/main/terraform/domain) repo.

N.B. the hosted zone(s) created by this template are retained even when the Stack is deleted.

### Domains

The template creates a Hosted Zone for the following subdomain(s):

- `home`

### DNS Records

The template also sets DNS records for SPF, DKIM and DMARC policies that instruct email clients to
reject any emails coming from the domain.

## Deployment

Make sure you've [set up your AWS CLI to use SSO](https://team-manual.account.gov.uk/teams/home-team/working-on-the-home-team/aws-accounts/#accessing-aws-via-the-command-line-interface-cli) as described in the team manual, then sign in:

```bash
aws sso login --profile di-account-dev
```

Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in either of the commands below.

### Creating a New Stack

```bash
aws cloudformation create-stack --stack-name dns-zones-<environment> \
--template-body file://$(pwd)/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

### Updating the Stack

```bash
aws cloudformation update-stack --stack-name dns-zones-<environment> \
--template-body file://$(pwd)/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

### Stack Outputs

| Type          | Name                                              | Description                         |
| ------------- | ------------------------------------------------- | ----------------------------------- |
| Stack Export  | `HomeHostedZoneNameServers`                       | Comma separated list of Nameservers |
| Stack Export  | `HomeHostedZoneId`                                | Id of the Route 53 Hosted Zone      |
| SSM Parameter | `/<environment>/Platform/Route53/HostedZone/Home` | Id of the Route 53 Hosted Zone      |
