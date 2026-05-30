variable "vpc_cidr" { } # This variable is used to define the CIDR block for the VPC

variable "aws_region" { } # This variable is used to define the AWS region

variable "public_subnet" {} # This variable is used to define the CIDR blocks for the public subnets

variable "private_subnet" {} # This variable is used to define the CIDR blocks for the private subnets

variable "available_zone" { # This variable is used to define the availability zones for the subnets
    type = list(string)
    description = "The availability zone to deploy the VPC resources in"
}

variable "target_env" {}