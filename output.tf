#######################################
# Outputs
#######################################
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}


# output "cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }



