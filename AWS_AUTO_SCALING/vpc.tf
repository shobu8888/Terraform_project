resource "aws_vpc" "local-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
 

  tags = {
    Name = "local-vpc"
  }
}


resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.local-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"


  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.local-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"


  tags = {
    Name = "public2"
  }
}


resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.local-vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"


  tags = {
    Name = "private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.local-vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1b"


  tags = {
    Name = "private2"
  }
}


resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.local-vpc.id

  tags = {
    Name = "gw1"
  }
}


resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.local-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }

  tags = {
    Name = "rt_pub"
  }

}


resource "aws_route_table_association" "rt_assoc_pub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "rt_assoc_pub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.rt-public.id
}
