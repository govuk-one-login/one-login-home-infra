# Accounts - Shared Redis

## Intro
The CloudFormation template creates the prerequisite Redis Cache resources used by
the applications like Authentication Account Management (AAM) webapp.

Creates a cluster mode __**disabled**__ ElastiCache Redis Cluster. 
Cache nodes are deployed into the private subnets A & B. 
Accessible from VPC networked resources within the Protected and Private subnets only.

This Stack is deployed manually once per account/environment as part of the AAM prerequisite set up process.

### Redis Node selection & Choices
 - `NodeCount` - number of cache clusters, between `1 - 6`, defaults is `2` based one one node per AZ

## Deployment
To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

### Creating a New Stack
Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in the commands below.
```bash
gds-cli aws di-account-build-admin \                                              INT ✘  2.7.6   19:53:14  
aws cloudformation create-stack --stack-name shared-redis \
--template-body file://$(pwd)/shared-redis/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Account" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Updating an Existing Stack
Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in the commands below.
```bash
gds-cli aws di-account-build-admin \                                              INT ✘  2.7.6   19:53:14  
aws cloudformation update-stack --stack-name shared-redis \
--template-body file://$(pwd)/shared-redis/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Account" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Stack Outputs

| Type           | Name                                          | Legacy | Description                                           |
|----------------|-----------------------------------------------|--------|-------------------------------------------------------|
| Secret Manager | `/<stackname>/Cluster/Password`               |        | The Cache's password                                  |
| SSM Parameter  | `/<stackname>/Cluster/Password/Secret`        |        | The ARN of the Cache's password secret                |
| SSM Parameter  | `/<stackname>/Cluster/Primary/Address`        |        | The DNS hostname of the primary cache node            |
| SSM Parameter  | `/<stackname>/Cluster/Primary/Port`           |        | The port number that the cache engine is listening on |
| SSM Parameter  | `<environment>-<stackname>-redis-password`    | X      | The Cache's password                                  |
| SSM Parameter  | `<environment>-<stackname>-redis-master-host` | X      | The DNS hostname of the primary cache node            |
| SSM Parameter  | `<environment>-<stackname>-redis-port`        | X      | The port number that the cache engine is listening on |
