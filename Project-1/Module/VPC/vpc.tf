provider "aws" {
    region = var.AWS_REGION
  
}
resource "aws_vpc" "main" {
  cidr_block       = "${var.VPC_CIDR}"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "vpc-${var.ENV}"
    Environment = "${var.ENV}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.PUBLIC_SUBNET_CIDR_1}"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet_1-${var.ENV}"
    Environment = "${var.ENV}"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.PUBLIC_SUBNET_CIDR_2}"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "public-subnet_2-${var.ENV}"
    Environment = "${var.ENV}"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.PRIVATE_SUBNET_CIDR_1}"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet-1-${var.ENV}"
    Environment = "${var.ENV}"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.PRIVATE_SUBNET_CIDR_2}"
   availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet-2-${var.ENV}"
    Environment = "${var.ENV}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IG-${var.ENV}"
  }
}

resource "aws_eip" "example" {
  domain = "vpc"
  tags = {
    Name = "EIP-${var.ENV}"
  }
}
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT-${var.ENV}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public-Rt-${var.ENV}"
  }
}


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "Private-Rt-${var.ENV}"
  }
}

resource "aws_route_table_association" "pub-1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "pub-2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public-rt.id
}


resource "aws_route_table_association" "pri-1" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "pri-2" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private-rt.id
}


