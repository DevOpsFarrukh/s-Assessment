# Environment Name
variable "environment_name" {
  description = "Name of the environment (e.g., dev, staging, prod)"
  type        = string
}

# Subnets and Security Groups
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
}

# Kubernetes Cluster Version
variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

# Tags
variable "tags" {
  description = "Tags to associate with resources"
  type        = map(string)
}

# Node Groups
variable "node_groups" {
  description = "Configuration for EKS node groups"
  type = map(object({


    
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
    instance_type    = string
    disk_size        = number
  }))
}

# EKS Endpoint Access
variable "endpoint_public_access" {
  description = "Enable public access to the EKS endpoint"
  type        = bool
}

variable "endpoint_private_access" {
  description = "Enable private access to the EKS endpoint"
  type        = bool
}
