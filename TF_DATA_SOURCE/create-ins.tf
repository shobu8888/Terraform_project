data "aws_availability_zone" "aval"{
 
} 

output "private_ip" {
  value = aws_instance.MyFirstInstnace.private_ip
}

resource "aws_instance" "MyFirstInstnace" {
  ami           =  lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zone.aval.names[1]
  tags = {
    Name="demoinstance_1"
  }

  provisioner "local-exec" {
    command = "echo aws_instance.MyFirstInstnace.public_ip >> abc.txt"
  }
}


