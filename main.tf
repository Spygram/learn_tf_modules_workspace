
module "vpc" {
  source         = "./modules/vpc"
  target_env     = terraform.workspace
  aws_region     = var.aws_region
  vpc_cidr       = var.vpc_cidr
  available_zone = data.aws_availability_zones.available.names
  public_subnet  = var.public_subnet_cidrs
  private_subnet = var.private_subnet_cidrs
}

# compute module
module "compute" {
  source            = "./modules/compute"
  target_env        = terraform.workspace
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  instance_type     = var.instance_type
  db_endpoint       = module.rds.rds_endpoint
}