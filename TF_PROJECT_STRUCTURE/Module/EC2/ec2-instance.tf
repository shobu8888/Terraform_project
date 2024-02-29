module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "ec2-${var.ENVIRONMENT}"

  instance_type          = var.INSTANCE_TYPE
  key_name               = aws_key_pair.pub_key_pair.key_name
  ami = lookup(var.AMIS,var.AWS_REGION)
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  subnet_id             = element(var.PUBLIC_SUBNETS,0)

  tags = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }
}

resource "aws_key_pair" "pub_key_pair" {
  public_key = file(var.public_key_path)
}



#Secutiry Group for Instances
resource "aws_security_group" "allow-ssh" {
  vpc_id      = var.VPC_ID
  name        = "allow-ssh-${var.ENVIRONMENT}"
  description = "security group that allows ssh traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name         = "allow-ssh"
    Environmnent = var.ENVIRONMENT
  }
}
