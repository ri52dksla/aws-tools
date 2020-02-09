
output "public_subnet_ids" {
  value       = module.vpc.public_subnets
  description = "Public Subnet Ids"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnets
  description = "Private Subnet Ids"
}

output "launch_template_id" {
  value = aws_launch_template.this.id
}

output "launch_template_latest_version" {
  value = aws_launch_template.this.latest_version
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "ID of the Security Group that is attached to Launch Template Network Interface"
}
