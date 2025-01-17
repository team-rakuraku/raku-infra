resource "aws_eip" "eip_natgw" {
  domain = "vpc"
}

resource "aws_nat_gateway" "raku_natgw" {
  allocation_id = aws_eip.eip_natgw.id
  subnet_id     = aws_subnet.raku_pub01_2a.id

  depends_on = [aws_internet_gateway.raku_igw]
  tags = {
    Name = "raku-natgw"
  }
}