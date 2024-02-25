

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "public-key-path" {
  default = "key_pair.pub"
  
}

variable "private-key-path" {
  default = "key-pair"
}

variable "USER_NAME" {
  default = "ubuntu"
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0b0ea68c435eb488d"
        us-east-2 = "ami-05803413c51f242b7"
    }
}
