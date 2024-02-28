module "ec2-instance" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"
    ami = "ami-0b0ea68c435eb488d"
    instance_type = "t2.micro"
    subnet_id   = "subnet-0ec9bf7cb30d51f25"
    count = 2
    tags = {
        Name = "ec2-instance-${count.index}"
        Terraform   = "true"
        Environment = "dev"
    }
}

variable "user_name" {
  type = list(string)
  default = [ "ram" , "shayam" ]
}


resource "aws_iam_user" "name" {
  for_each = toset(var.user_name)
  name = each.value
}

output "user" {
  value = [for name1 in aws_aws_iam_user.name : "output is -  ${name1}"]
}