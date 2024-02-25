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
}

resource "aws_security_group" "sg_mariadb" {
  name        = "sg_mariadb"
  description = "sg created via tf sg_mariadb"
  vpc_id      = aws_vpc.local-vpc.id

  tags = {
    Name = "sg_mariadb"
  }

  egress {
    to_port = 0
    from_port = 0 
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }

    ingress {
    to_port = 3306
    from_port = 3306 
    security_groups = [aws_security_group.sg_local.id]
    protocol = "tcp"
  }
}