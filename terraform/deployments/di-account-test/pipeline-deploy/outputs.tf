
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
output "waf-acl-pipeline_stack_id" {
  value = module.waf-acl-pipeline.stack_id
}
output "waf-acl-pipeline_stack_outputs" {
  value = module.waf-acl-pipeline.stack_outputs
}
output "waf-acl-pipeline_stack_tags" {
  value = module.waf-acl-pipeline.stack_tags
}