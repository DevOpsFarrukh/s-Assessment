output "vpc_id" {
  value = module.vpc.vpc_id
}

output "security_group_id" {
  description = "The ID of the default security group created by the security group module"
  value       = module.securitygroup.security_group_id
}

output "ingress_rule_count" {
  description = "The count of ingress rules created by the security group module"
  value       = module.securitygroup.ingress_rule_count
}

output "egress_rule_count" {
  description = "The count of egress rules created by the security group module"
  value       = module.securitygroup.egress_rule_count
}