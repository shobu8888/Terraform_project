module "ec2-instance" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"
    ami = "ami-0b0ea68c435eb488d"
    instance-type = "t2.micro"
    subnet_id   = "subnet-0ec9bf7cb30d51f25"

    tags = {
    Terraform   = "true"
    Environment = "dev"
    }
}
