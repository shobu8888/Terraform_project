variable "AWS_REGION" {
    type = string
    default = "us-east-1"
}

variable "ENV" {
    type = string
    default = ""
}
variable "VPC_CIDR" {
    type = string
    default = "10.0.0.0/16"
}

variable "PUBLIC_SUBNET_CIDR_1" {
    type = string
    default = "10.1.0.0/24"
}

variable "PUBLIC_SUBNET_CIDR_2" {
    type = string
    default = "10.2.0.0/24"
}
variable "PRIVATE_SUBNET_CIDR_1" {
    type = string
    default = "10.3.0.0/24"
}

variable "PRIVATE_SUBNET_CIDR_2" {
    type = string
    default = "10.4.0.0/24"
}