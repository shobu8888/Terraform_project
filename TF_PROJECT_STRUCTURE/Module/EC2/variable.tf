variable "public_key_path" {
    type = string
    default = "~/.ssh/level-up.pub" 
}

variable "VPC_ID" {
    type = string
    default = ""
  
}


variable "ENVIRONMENT" {
    type = string
    default = ""
  
}

variable "AWS_REGION" {
default = "us-east-1"
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0ff8a91507f77f867"
        eu-west-1 = "ami-047bb4163c506cd98"
    }
}


variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "PUBLIC_SUBNETS" {
  type = list
}