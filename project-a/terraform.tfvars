  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  project_name = "modules"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "test"

  #################------EKS Variables------##########
  cluster_name = "test"
