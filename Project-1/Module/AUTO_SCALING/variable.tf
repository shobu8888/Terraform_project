variable "AWS_REGION" {
    type = string
    default = "us-east-1"
}

variable "ENV" {
    type = string
    default = ""
}

variable "INS_TYPE" {
    type = string
    default = "t2.micro"
}

variable "PUBLIC_SUBNET_1" {
    type = string
    default = ""
}


variable "PUBLIC_SUBNET_2" {
    type = string
    default = ""
}

variable "VPC_ID" {
    type = string
    default = ""
}


variable "AMIS" {
  type = map
  default = {
    "us-east-1" = "ami-0ff8a91507f77f867"
    "us-east-2" = "ami-0b59bfac6be064b78"
  }
}

variable "public_key_path" {
    type = string
    default = "~/.ssh/level-up.pub"
}