module "vpc" {
  source                   = "../../../../modules-v14-gcp/vpc-v1"
  name                     = var.name
  public_subnets_block     = var.public_subnets_block
  private_subnets_block    = var.private_subnets_block
  proxy_only_subnets_block = var.proxy_only_subnets_block
  service                  = var.service
  service_type             = var.service_type
  routing_mode             = var.routing_mode
  project_id               = var.project_id
  region                   = var.region
  private_ip_google_access = var.private_ip_google_access
  pvt_svc_connect_subnets_block = var.pvt_svc_connect_subnets_block
}


module "new_firewall" {
  source       = "../../../../modules-v14-gcp/firewall-vpc"
  name         = var.name
  network_name = module.vpc.name
  environment  = var.environment
  project_id   = var.project_id
  cidr         = var.cidr
}

output "output-vpc" {
  value = module.vpc
}