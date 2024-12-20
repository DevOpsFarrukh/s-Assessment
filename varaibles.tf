variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "ingress_rule_list" {
  description = "List of security group ingress rules"
  default     = []
  type = list(object({
    source_security_group_id = string
    cidr_blocks              = list(string)
    description              = string
    from_port                = number
    protocol                 = string
    to_port                  = number
  }))

}

variable "egress_rule_list" {
  description = "List of security group egress rules"
  default = [
    {
      source_security_group_id = null
      cidr_blocks              = ["0.0.0.0/0"]
      description              = "Default egress rule"
      from_port                = 0
      protocol                 = "all"
      to_port                  = 65535
    }
  ]
  type = list(object({
    source_security_group_id = string
    cidr_blocks              = list(string)
    description              = string
    from_port                = number
    protocol                 = string
    to_port                  = number
  }))
}

variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map(any)
}

variable "aws_region" {
  description = "Tags to be applied to the resource"
}


variable "environment_name" {
  description = "Tags to be applied to the resource"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}


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
