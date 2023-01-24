module "vpc" {
  source               = "./modules/vpc"
  vpc-name             = var.vpc_name
  vpc-cidr-block       = "10.0.0.0/16"
  public-subnets-data  = var.public-subnets-data
  private-subnets-data = var.private-subnets-data
}
module "ec2" {
  source                  = "./modules/ec2"
  ami_id                  = var.ami_id
  instance_type           = var.instance_type
  availability_zone       = var.availability_zone
  availability_zone1      = var.availability_zone1
  key_name                = var.key_name
  public_key              = var.public_key
  public-instance-secgrp  = module.vpc.public-security
  private-instance-secgrp = module.vpc.private-security
  public-subnet-id        = module.vpc.public-subnet-id
  private-subnet-id       = module.vpc.private-subnet-id
  instance_name           = var.instance_name
  private_instance_name   = var.private_instance_name
  private_user_data       = file("./templates/postgres.sh")
}