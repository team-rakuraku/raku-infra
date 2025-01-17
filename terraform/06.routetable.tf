resource "aws_route_table" "raku_pub_rt" {
  vpc_id = aws_vpc.raku_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.raku_igw.id
  }

  tags = {
    Name = "raku-pub-rt"
  }
}

resource "aws_route_table" "raku_pvt_rt" {
  vpc_id = aws_vpc.raku_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.raku_natgw.id
  }
  tags = {
    Name = "raku-pvt-rt"
  }
}

resource "aws_route_table_association" "rt_pub01" {
  subnet_id      = aws_subnet.raku_pub01_2a.id
  route_table_id = aws_route_table.raku_pub_rt.id
}

resource "aws_route_table_association" "rt_pvt01" {
  subnet_id      = aws_subnet.raku_pvt01_2c.id
  route_table_id = aws_route_table.raku_pvt_rt.id
}

resource "aws_route_table_association" "rt_pvt02" {
  subnet_id      = aws_subnet.raku_pvt02_2a.id
  route_table_id = aws_route_table.raku_pvt_rt.id
}
