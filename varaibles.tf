# AWS Region
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "environment_name" {
  description = "Name of the environment (e.g., dev, staging, prod)"
  type        = string
}

variable "dns_label" {
  description = "DNS label for the VPC"
  type        = string
}

# Availability Zones
variable "frontend_az" {
  description = "Availability Zone for frontend subnet"
  type        = string
}

variable "app_az" {
  description = "Availability Zone for app subnet"
  type        = string
}

variable "backend_az" {
  description = "Availability Zone for backend subnet"
  type        = string
}

variable "reserved_az" {
  description = "Availability Zone for reserved subnet"
  type        = string
}

# Kubernetes Cluster Configuration
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
    subnet_id        = string
    disk_size        = number
  }))
}
