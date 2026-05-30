resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
    tags = {
        Name = "${var.target_env}-vpc"
    }
}

resource "aws_internet_gateway" "sd-gw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${var.target_env}-igw" }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = var.available_zone[count.index]
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.target_env}-public-subnet-${count.index + 1}" }
}

resource "aws_subnet" "private" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet[count.index]
  availability_zone       = var.available_zone[count.index]
  map_public_ip_on_launch = false
  tags                    = { Name = "${var.target_env}-private-subnet-${count.index + 1}" }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sd-gw.id
  }
  tags = { Name = "${var.target_env}-public-rt" }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.public-rt.id]
  tags              = { Name = "${var.target_env}-s3-endpoint" }
}