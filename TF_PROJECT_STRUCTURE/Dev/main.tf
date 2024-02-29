module "dev-vpc" {
    source = "../Module/VPC"
    enviornment = var.Env
    aws_region = var.AWS_REGION
  
}

module "dev-ec2" {
  source = "../Module/EC2"
  ENVIRONMENT = var.Env
  AWS_REGION = var.AWS_REGION
  VPC_ID = module.dev-vpc.my_vpc_id
  PUBLIC_SUBNETS = module.dev-vpc.public_subnets
}


provider "aws" {
  region = var.AWS_REGION
}