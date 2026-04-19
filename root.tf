terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "infra" {
  source = "./modules/vpc_ec2"

  aws_region          = var.aws_region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  instance_type       = var.instance_type
  ami_id              = var.ami_id
  key_name            = var.key_name
  my_ip               = var.my_ip
}

output "public_instance_ip" {
  value       = module.infra.public_ip
  description = "Public IP address of the public EC2 instance"
}

output "private_instance_ip" {
  value       = module.infra.private_ip
  description = "Private IP address of the private EC2 instance"
}