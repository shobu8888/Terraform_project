resource "aws_db_subnet_group" "marida_db_sub" {
    name = "maria_subnet_gp"
    subnet_ids = [aws_subnet.private1.id , aws_subnet.private2.id]
}

resource "aws_db_parameter_group" "maria-para" {
    name = "maria-para"
    family = "mariadb10.11"

    parameter {
    name  = "max_allowed_packet"
    value = "16777216"
    }
  
}


resource "aws_db_instance" "MariaDB_local" {
  allocated_storage    = 20
  db_name              = "mariadb"
  engine               = "mariadb"
  engine_version       = "10.11.6"
  instance_class       = "db.t3.micro"
  username             = "db"
  password             = "db12344321"
  storage_type = "gp2"
  parameter_group_name = aws_db_parameter_group.maria-para.name
  skip_final_snapshot  = true
  multi_az             = false
  vpc_security_group_ids = [aws_security_group.sg_mariadb.id]
  db_subnet_group_name = aws_db_subnet_group.marida_db_sub.name
  backup_retention_period = 30
  availability_zone = aws_subnet.private1.availability_zone

  tags =  {
    Name = "MariaDB_local"
  }
 
}

output "MariaDB-ip" {
  value = aws_db_instance.MariaDB_local.endpoint
}