module "vpc" {
  source         = "./modules/vpc"
  
  aws_region     = var.aws_region
  available_zone = data.aws_availability_zones.available.names
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  instance_type   = var.instance_type
}