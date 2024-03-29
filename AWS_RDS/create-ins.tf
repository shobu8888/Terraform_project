resource "aws_key_pair" "public_key_pair" {
  key_name = "public_key_pair"
  public_key = file(var.public-key-path)
}


resource "aws_instance" "MyFirstInstnace" {
  ami           =  lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.public_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.sg_local.id]
  subnet_id = aws_subnet.public1.id
  #user_data = file("user_data.sh")
  #user_data = data.template_cloudinit_config.install_apc_cfg.rendered
  tags = {
    Name="demoinstance_vpc"
  }

}






output "ins-public_ip" {
  value=aws_instance.MyFirstInstnace.public_ip
  
}