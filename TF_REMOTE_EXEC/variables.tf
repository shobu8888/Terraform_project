

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "Security_Group" {
  type = list
  default = ["sg-06d8937e8335f2cd1"]
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-0b0ea68c435eb488d"
        us-east-2 = "ami-05803413c51f242b7"
    }
}

variable "PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "PRIVATE_KEY" {
  default = "levelup_key"
}

variable "USER_NAME" {
  default = "ubuntu"
}