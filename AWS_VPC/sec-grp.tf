resource "aws_security_group" "sg_local" {
  name        = "sg_local"
  description = "sg created via tf"
  vpc_id      = aws_vpc.local-vpc.id

  tags = {
    Name = "sg_local"
  }

  egress {
    to_port = 0
    from_port = 0 
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }

    ingress {
    to_port = 22
    from_port = 22 
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }

    ingress {
    to_port = 80
    from_port = 80 
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
  }
}