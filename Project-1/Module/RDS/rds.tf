provider "aws" {
    region = var.AWS_REGION
  
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = aws_db_parameter_group.default.name
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.sec_group_db.id]
  multi_az = false
  skip_final_snapshot  = true
}

resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}


resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.PRIVATE_SUBNET_1 ,var.PRIVATE_SUBNET_2]

  tags = {
    Name = "My DB subnet group"
  }
}


resource "aws_security_group" "sec_group_db" {
  name        = "sec_group_db"
  description = "db"
  vpc_id      =  var.VPC_ID

   ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sec-grp-db-${var.ENV}"
  }
}