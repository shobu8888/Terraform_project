
resource "aws_instance" "MyFirstInstnace" {
  ami           = "ami-0b0ea68c435eb488d"
  instance_type = "t2.micro"
  tags = {
    Name="demoinstance"
  }
}

