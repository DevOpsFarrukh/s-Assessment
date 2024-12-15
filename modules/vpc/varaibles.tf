variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string

}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
 
}

variable "environment_name" {
  description = "Name of the environment"
  type        = string
}

variable "dns_label" {
  description = "DNS label for the VPC"
  type        = string
}

variable "frontend_az" {
  description = "Availability Zone for Frontend Subnet"
  type        = string
 
}

variable "app_az" {
  description = "Availability Zone for App Subnet"
  type        = string
  
}



variable "backend_az" {
  description = "Availability Zone for Backend Subnet"
  type        = string

}


variable "reserved_az" {
  description = "Availability Zone for Reserved Subnet"
  type        = string
 
}
