
variable "aws_region" { default = "us-east-1" } # This variable is used in provider.tf and main.tf
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "instance_type" {  }