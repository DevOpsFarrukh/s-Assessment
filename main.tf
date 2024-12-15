#######################################
# VPC Module
#######################################
module "vpc" {
  source           = "./modules/vpc"
  aws_region       = var.aws_region
  vpc_cidr         = var.vpc_cidr
  environment_name = var.environment_name
  dns_label        = var.dns_label
  frontend_az      = var.frontend_az
  app_az           = var.app_az
  backend_az       = var.backend_az
  reserved_az      = var.reserved_az
}


#######################################
#EKS Module
######################################
module "eks" {
    
  source = "./modules/eks"
  environment_name         = var.environment_name
  subnet_ids               = [module.vpc.frontend_subnet_id, module.vpc.app_subnet_id, module.vpc.backend_subnet_id]
  security_group_ids       = [module.vpc.app_sg_id, module.vpc.backend_sg_id]
  cluster_version          = var.cluster_version
  tags                     = var.tags
  node_groups              = var.node_groups
  endpoint_public_access   = true
  endpoint_private_access  = false
}


