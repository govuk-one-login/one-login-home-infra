# Accounts - Common IAM permissions

## Intro

Secure pipelines template used to facilitate parallel stack deployments in the Dev environment.

## Deployment

To deploy the template to the appropriate AWS account, ensure you are at the root of the project.

This template should **ONLY** be deployed manually in the `dev` environment.

### Creating a New Stack
Replace `<stack>` with the CloudFormation stack the pipeline will facilitate the deployment of, e.g. `account-management-frontend`

```bash
gds-cli aws di-account-dev \
aws cloudformation create-stack --stack-name dev-"<stack>"-pipeline \
--template-body file://$(pwd)/dev-instance-pipeline/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="dev" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="dev" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

To update:

```bash
gds-cli aws di-account-dev \
aws cloudformation update-stack --stack-name dev-"<stack>"-pipeline \
--template-body file://$(pwd)/dev-instance-pipeline/template.yaml \
--region eu-west-2 --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
--parameters ParameterKey=Environment,ParameterValue="dev" \
--tags Key=Product,Value="GOV.UK Sign In" Key=System,Value="Accounts" \
Key=Environment,Value="dev" Key=Owner,Value="govuk-accounts-tech@digital.cabinet-office.gov.uk"
```

### Stack outputs

| Type         | Name                                         | Description                                                                                                                                                                                  |
|--------------|----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Stack Output | `GitHubActionsRoleArn`                       | Role ARN for deploying and signing artifacts in GitHub Actions. Restricted for usage only in the repository specified in the `GitHubRepositoryName` parameter and on branches named `main`.  |
| Stack Export | `dev-<stack>-pipeline-GitHubActionsRoleName` | Role name for deploying and signing artifacts in GitHub Actions. Restricted for usage only in the repository specified in the `GitHubRepositoryName` parameter and on branches named `main`. |
| Stack Output | `GitHubActionsValidateRoleArn`               | Role ARN for running `sam validate` in GitHub Actions. Restricted for usage only in the repository specified in the `GitHubRepositoryName` parameter.                                        |
| Stack Output | `GitHubArtifactSourceBucketName`             | The name of the bucket into which GitHub should publish artifacts for deployment.                                                                                                            |
| Stack Output | `PipelineName`                               | The name of the pipeline provisioned.                                                                                                                                                        |