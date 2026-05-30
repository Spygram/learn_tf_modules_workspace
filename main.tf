module "vpc" {
  source = "./modules/vpc"

  target_env = terraform.workspace

  aws_region = var.aws_region # This variable is defined in variables.tf

  vpc_cidr = var.vpc_cidr # This variable is defined in variables.tf

  available_zone = data.aws_availability_zones.available.names # This data source is defined in data.tf

  public_subnet = var.public_subnet_cidrs # This variable is defined in variables.tf

  private_subnet = var.private_subnet_cidrs # This variable is defined in variables.tf

}