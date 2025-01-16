resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.raku_vpc.id
}