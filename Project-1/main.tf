module "vpc_create" {
  source = "./Module/VPC"

  ENV = "DEV"
  VPC_CIDR = "10.1.0.0/16"
  PUBLIC_SUBNET_CIDR_1 = "10.1.1.0/24"
  PUBLIC_SUBNET_CIDR_2 = "10.1.2.0/24"
  PRIVATE_SUBNET_CIDR_1 = "10.1.3.0/24"
  PRIVATE_SUBNET_CIDR_2 = "10.1.4.0/24"

}

module "elb-auto-create" {
    source = "./Module/AUTO_SCALING"
    ENV = "DEV"
    PUBLIC_SUBNET_1 = module.vpc_create.public_subnet1_id
    PUBLIC_SUBNET_2 = module.vpc_create.public_subnet2_id
    }

