variable "vpc_cidr" { default = "10.0.0.0/16" }
# variable "public_subnet_cidrs" { default = ["10.0.1.0/24", "10.0.2.0/24"] }
# variable "private_subnet_cidrs" { default = ["10.0.3.0/24", "10.0.4.0/24"] }

variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "aws_region" { }
variable "available_zone" {
    type = list(string)
    description = "The availability zone to deploy the VPC resources in"
}

variable "instance_type" {  }