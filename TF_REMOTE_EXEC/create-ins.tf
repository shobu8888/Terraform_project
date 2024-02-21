resource "aws_key_pair" "key_pair" {
  key_name = "levelup_key"
  public_key = file(var.PUBLIC_KEY)
}


resource "aws_instance" "MyFirstInstnace" {
  ami           =  lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.key_pair.key_name
  tags = {
    Name="demoinstance"
  }


  provisioner "file" {
    source = "install-niginx.sh"
    destination = "/tmp/install-niginx.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod a+x /tmp/install-niginx.sh",
      "sudo sed -i -e 's/\r$//' /tmp/install-niginx.sh",  
      "sudo /tmp/install-niginx.sh"
     ]
  }

  connection {
    host = coalesce(self.public_ip , self.private_ip)
    type = "ssh"
    user = var.USER_NAME
    private_key = file(var.PRIVATE_KEY)
  }
}

