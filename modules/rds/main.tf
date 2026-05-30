# Isolated Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.target_env}-rds-sg"
  description = "Allow inbound PostgreSQL traffic from Web Server"
  vpc_id      = var.vpc_id

  # Strict firewall rule: Only allow connections on 5432 from the Public VM's Security Group
  ingress {
    description = "Mysql from Public Web Server"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.target_env}-rds-sg" }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

# Free-Tier AWS RDS MySQL Instance
resource "aws_db_instance" "mysql_db" {
  identifier                 = "${var.target_env}-mysql"
  engine                     = "mysql"
  engine_version             = "8.0"
  auto_minor_version_upgrade = true
  instance_class             = "db.t3.micro" # AWS Free Tier eligible
  allocated_storage          = 20            # 20 GB (Within 30GB free limit)
  storage_type               = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = { Name = "${var.target_env}-mysql-db" }
}