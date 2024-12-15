# AWS Region
aws_region = "us-east-1"                      # Replace with your AWS region

# VPC Configuration
vpc_cidr         = "10.0.0.0/16"              # CIDR block for the VPC
environment_name = "dev"                      # Name of the environment
dns_label        = "dev-dns"                  # DNS label for the VPC

# Availability Zones
frontend_az = "us-east-1a"                    # Frontend subnet AZ
app_az      = "us-east-1b"                    # App subnet AZ
backend_az  = "us-east-1c"                    # Backend subnet AZ
reserved_az = "us-east-1d"                    # Reserved subnet AZ

# Kubernetes Cluster Configuration
cluster_version = "1.27"                      # Kubernetes version for EKS

# Tags
tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
}


# Node Groups Configuration
node_groups = {
  worker_group_1 = {
    desired_capacity = 2
    max_capacity     = 3
    min_capacity     = 1
    instance_type    = "t3.medium"
    subnet_id        = "subnet-04ed3eb5159b0eb87"      # Replace with actual subnet ID for worker group 1
    disk_size        = 20
  }
}


