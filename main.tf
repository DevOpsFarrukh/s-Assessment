#######################################
# VPC Module
#######################################
module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr_block             = var.vpc_cidr_block
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  availability_zones         = var.availability_zones
  environment_name         = var.environment_name
}

######################################
#Security Group
######################################
module "securitygroup" {
  source = "./modules/securitygroup"
  ingress_rule_list = var.ingress_rule_list
  egress_rule_list  = var.egress_rule_list
  vpc_id            = module.vpc.vpc_id
  environment_name         = var.environment_name
}

#######################################
#EKS Module
######################################
module "eks" {
    
  source = "./modules/eks"
  environment_name         = var.environment_name
  subnet_ids               = module.vpc.private_subnet_cidr_blocks
  security_group_ids       = [aws_security_group.default.id]
  cluster_version          = var.cluster_version
  tags                     = var.tags
  node_groups              = var.node_groups
  endpoint_public_access   = true
  endpoint_private_access  = false 
}



