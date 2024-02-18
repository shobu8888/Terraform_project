
resource "aws_instance" "MyFirstInstnace" {
  ami           =  var.AMIS
  instance_type = "t2.micro"
  tags = {
    Name="demoinstance"
  }
  security_groups = var.Security_Group
}

