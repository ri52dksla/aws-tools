output "launch_template_id" {
  value = module.vpc_and_launch_template.launch_template_id
}

output "launch_template_latest_version" {
  value = module.vpc_and_launch_template.launch_template_latest_version
}

output "public_subnet_id" {
    value =  module.vpc_and_launch_template.public_subnet_ids[0]
    description = "Public Subnet Ids"
}

output "security_group_id" {
    value =  module.vpc_and_launch_template.security_group_id
}