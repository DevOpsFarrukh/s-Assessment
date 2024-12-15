output "cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.this.id
}



output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "node_group_roles" {
  description = "IAM Role for EKS Node Groups"
  value       = aws_iam_role.eks_node_group_role.name
}
