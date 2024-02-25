resource "aws_key_pair" "public_key_pair" {
  key_name = "public_key_pair"
  public_key = file(var.public-key-path)
}


resource "aws_instance" "MyFirstInstnace" {
  ami           =  lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.public_key_pair.key_name
  iam_instance_profile = aws_iam_instance_profile.s3-profile.name
  tags = {
    Name="ec2-s3"
  }

}






output "ins-public_ip" {
  value=aws_instance.MyFirstInstnace.public_ip
  
}