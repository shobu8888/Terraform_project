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
  user_data = data.template_cloudinit_config.install_apc_cfg.rendered
  tags = {
    Name="demoinstance_vpc"
  }

}


resource "aws_ebs_volume" "ebs_vol" {
  availability_zone = "us-east-1a"
  size              = 10

  tags = {
    Name = "ebs_vol"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_vol.id
  instance_id = aws_instance.MyFirstInstnace.id
}

output "ins-public_ip" {
  value=aws_instance.MyFirstInstnace.public_ip
  
}