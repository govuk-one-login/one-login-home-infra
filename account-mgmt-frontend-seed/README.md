# Accounts - Authentication Account Management (AMF) - Seed Stack

## Intro

The CloudFormation template creates the prerequisite resources and placeholders used by
the Authentication Account Management (AMF) webapp, which haa default stack name of `account-mgmt-frontend`.

This Stack is deployed manually once per account/environment as part of the AMF prerequisite set up process.

### KMS Key

The KMS key's Public key is the AMF webapp server's Client Secret and needs to be securely sent to the OP.
The KMS key is used for signing JWTs so that OP can authenticate the RP (**runtime dependency**).

**N.B.** the KMS key created by this template is retained even when the Stack is deleted.

### Config Placeholders

The stack also create SSM Parameters and Secrets placeholder resources.
These placeholder resources are for storing config values used when the `account-mgmt-frontend` CloudFormation
stack is deployed (**deploy-time dependency**).

## Deployment

Make sure you've [set up your AWS CLI to use SSO](https://team-manual.account.gov.uk/teams/home-team/working-on-the-home-team/aws-accounts/#accessing-aws-via-the-command-line-interface-cli) as described in the team manual, then sign in:

```bash
aws sso login --profile di-account-dev
```

### Creating a New Stack

#### Step 1

##### Stack Parameters

- `AAMStackName` - The intended name of the AMF SAM Stack, defaults to `account-mgmt-frontend`.

Replace `<environment>` with `dev`, `build`, `staging`, `integration`, `production` in the commands below.

```bash
aws cloudformation create-stack --stack-name account-mgmt-frontend-seed \
--template-body file://$(pwd)/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="<environment>" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="<environment>" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk" \
--profile di-account-<environment>
```

#### Step 2

Get the KMS Key's Public Key and send it to the OP for registration of the RP.

- Go to the AWS Console and open the Key Management Service (KMS).
- Find key with Alias called `account-mgmt-frontend-JwtSigningKey` and select it.
- Select the Public Key tab and copy the value.
- \***\*Securely\*\*** send the copied value to the OP to begin Client Registration.

#### Step 3

Persist the following values into the placeholders in SSM Parameter store:

| SSM Parameter Key                              | Value Province                                 |
| ---------------------------------------------- | ---------------------------------------------- |
| `/account-mgmt-frontend/Config/OIDC/Client/Id` | Client ID returned by OP after RP registration |
| `/account-mgmt-frontend/Config/GTM/Id`         | Google Tag Manager ID                          |

#### Step 4

Persist the following values into the placeholders in Secrets Manager Parameter store:

| Secret Name                                        | Value Province                       |
| -------------------------------------------------- | ------------------------------------ |
| `/account-mgmt-frontend/Config/Publishing/API/Key` | GOV.UK Services - Publishing API Key |

**N.B** SecureString cannot be created with CloudFormation.

#### Step 5

Deploy the `account-mgmt-frontend` SAM stack.

### Stack Outputs

| Type           | Name                                               | Description                                                                            |
| -------------- | -------------------------------------------------- | -------------------------------------------------------------------------------------- |
| Stack Export   | `account-mgmt-frontend-seed-JwtSigningKeyId`       | ID of the JWT signing KMS key                                                          |
| Stack Export   | `account-mgmt-frontend-seed-JwtSigningKeyAlias`    | Alias of the JWT signing KMS key, normally `alias/account-mgmt-frontend-JwtSigningKey` |
| SSM Parameter  | `/account-mgmt-frontend/KMS/JwtSigningKey/Id`      | ID of the JWT signing KMS key                                                          |
| SSM Parameter  | `/account-mgmt-frontend/KMS/JwtSigningKey/Alias`   | Alias of the JWT signing KMS key, normally `alias/account-mgmt-frontend-JwtSigningKey` |
| SSM Parameter  | `/account-mgmt-frontend/Config/OIDC/Client/Id`     | Config Placeholder for Step 3                                                          |
| SSM Parameter  | `/account-mgmt-frontend/Config/GTM/Id`             | Config Placeholder for Step 3                                                          |
| Secret Manager | `/account-mgmt-frontend/Config/Publishing/API/Key` | Config Placeholder for Step 4                                                          |
