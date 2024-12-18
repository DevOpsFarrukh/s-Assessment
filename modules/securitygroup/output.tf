
output "security_group_id" {
  value = aws_security_group.default.id
}


output "ingress_rule_count" {
  description = "The count of ingress rules created"
  value       = length(aws_security_group_rule.default_ingress_rules)
}

output "egress_rule_count" {
  description = "The count of egress rules created"
  value       = length(aws_security_group_rule.default_egress_rules)
}