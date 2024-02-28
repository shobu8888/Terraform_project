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
