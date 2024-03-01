module "vpc_create" {
  source = "./Module/VPC"

  ENV = "DEV"
  VPC_CIDR = "10.1.0.0/16"
  PUBLIC_SUBNET_CIDR_1 = "10.1.1.0/24"
  PUBLIC_SUBNET_CIDR_2 = "10.1.2.0/24"
  PRIVATE_SUBNET_CIDR_1 = "10.1.3.0/24"
  PRIVATE_SUBNET_CIDR_2 = "10.1.4.0/24"

}