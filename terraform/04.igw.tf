resource "aws_internet_gateway" "raku_igw" {
  vpc_id = aws_vpc.raku_vpc.id
  tags = {
    Name = "raku-igw"
  }
}