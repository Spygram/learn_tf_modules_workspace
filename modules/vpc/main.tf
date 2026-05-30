# This Terraform configuration defines a VPC with public and private subnets, an Internet Gateway, and a route table for the public subnets. It also includes a VPC endpoint for S3 and a DB subnet group for RDS.

#
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
    tags = {
        Name = "${var.target_env}-vpc"
    }
}

# Create an Internet Gateway and attach it to the VPC
resource "aws_internet_gateway" "sd-gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.target_env}-igw" }
}

# # Create public subnets
# resource "aws_subnet" "public" {
#   count                   = 2
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.public_subnet[count.index]
#   availability_zone       = var.available_zone[count.index]
#   map_public_ip_on_launch = true
#   tags                    = { Name = "${var.target_env}-public-subnet-${count.index + 1}" }
# }

# # Create private subnets in the same availability zones as the public subnets
# resource "aws_subnet" "private" {
#   count                   = 2
#   vpc_id                  = aws_vpc.main.id
#   cidr_block              = var.private_subnet[count.index]
#   availability_zone       = var.available_zone[count.index]
#   map_public_ip_on_launch = false
#   tags                    = { Name = "${var.target_env}-private-subnet-${count.index + 1}" }
# }

# # Create a DB subnet group for RDS using the private subnets
# resource "aws_db_subnet_group" "rds" {
#   name       = "${var.target_env}-rds-subnet-group"
#   subnet_ids = aws_subnet.private[*].id # Uses your private subnet IDs automatically

#   tags = { Name = "${var.target_env}-rds-subnet-group" }
# }

# # Create a route table for public subnets
# resource "aws_route_table" "public-rt" {
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.sd-gw.id
#   }
#   tags = { Name = "${var.target_env}-public-rt" }
# }

# resource "aws_route_table_association" "public" {
#   count          = 2
#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.public-rt.id
# }

# # aws route table - private
# resource "aws_route_table" "private-rt" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "${var.target_env}-private-rt"
#   }
# }

# resource "aws_route_table_association" "private" {
#   count          = 2
#   subnet_id      = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private-rt.id
# }

# resource "aws_vpc_endpoint" "s3" {
#   vpc_id            = aws_vpc.main.id
#   service_name      = "com.amazonaws.${var.aws_region}.s3"
#   vpc_endpoint_type = "Gateway"
#   route_table_ids   = [aws_route_table.private-rt.id]
#   tags              = { Name = "${var.target_env}-s3-endpoint" }
# }