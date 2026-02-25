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