packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {

  ami_name      = "learn-packer-linux-aws-${timestamp}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "file" {
    source =  "./helloworld.txt",
    destination =  "/home/ubuntu/"
  }
  provisioner "shell" {
    inline = [
      "ls -al /home/ubuntu",
       "cat /home/ubuntu/helloworld.txt"
    ]
    script =  "./install_nginx.sh"
  }

}
