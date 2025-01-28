provider "aws" {
  region = "us-east-1" # Change this to your desired region
}

module "vpc" {
  source = "../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  project_name        = var.project_name
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

module "bastion_host" {
  source = "../modules/bastion_host"
  
  
}
module "eks" {
  source = "../modules/eks"

  cluster_name           = var.cluster_name
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  eks_version            = "1.27"
  node_group_instance_type = "t3.medium"
  node_group_desired_size = 2
  node_group_max_size     = 3
  node_group_min_size     = 1
}