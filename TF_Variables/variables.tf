variable "AWS_ACCESS_KEY" {
  
}
variable "AWS_SECRET_KEY" {
  
}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "Security_Group" {
  type = list
  default = ["sg-1","sg-2"]
}