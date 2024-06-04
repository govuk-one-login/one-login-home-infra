
output "gds_org_id" {
  value = data.aws_organizations_organization.gds.id
}

output "home-backend-pipeline_stack_id" {
  value = module.home-backend-pipeline.stack_id
}
output "home-backend-pipeline_stack_outputs" {
  value = module.home-backend-pipeline.stack_outputs
}
output "home-backend-pipeline_stack_tags" {
  value = module.home-backend-pipeline.stack_tags
}
output "home-stubs-pipeline_stack_id" {
  value = module.home-stubs-pipeline.stack_id
}
output "home-stubs-pipeline_stack_outputs" {
  value = module.home-stubs-pipeline.stack_outputs
}
output "home-stubs-pipeline_stack_tags" {
  value = module.home-stubs-pipeline.stack_tags
}