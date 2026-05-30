# Create public subnets
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = var.available_zone[count.index]
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.target_env}-public-subnet-${count.index + 1}" }
}

# Create private subnets in the same availability zones as the public subnets
resource "aws_subnet" "private" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet[count.index]
  availability_zone       = var.available_zone[count.index]
  map_public_ip_on_launch = false
  tags                    = { Name = "${var.target_env}-private-subnet-${count.index + 1}" }
}

# Create a DB subnet group for RDS using the private subnets
resource "aws_db_subnet_group" "rds" {
  name       = "${var.target_env}-rds-subnet-group"
  subnet_ids = aws_subnet.private[*].id # Uses your private subnet IDs automatically

  tags = { Name = "${var.target_env}-rds-subnet-group" }
}
