data "aws_availability_zone" "aval"{
 
}

resource "aws_instance" "MyFirstInstnace" {
  ami           =  lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zone.aval.name[1]
  tags = {
    Name="demoinstance_1"
  }
}


