resource "aws_eip" "levelup-nat" {
  domain = "true"
}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.levelup-nat.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw1]
}

resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.local-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name = "rt_pri"
  }

}


resource "aws_route_table_association" "rt_assoc_pri1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.rt-private.id
}

resource "aws_route_table_association" "rt_assoc_pri2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.rt-private.id
}
