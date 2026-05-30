terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.46.0"
    }
  }
}

backend "s3" {
    bucket  = "sujansd2026"
    key     = "vpc/terraform.tfstate"
    region  = var.aws_region
    encrypt = true
  }

provider "aws" {
  # Configuration options
  region = var.aws_region
}