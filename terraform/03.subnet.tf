resource "aws_subnet" "raku_pub01_2a" {
  vpc_id            = aws_vpc.raku_vpc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "raku-pub01-2a"
  }
}

resource "aws_subnet" "raku_pvt01_2c" {
  vpc_id            = aws_vpc.raku_vpc.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "raku-pvt01-2c"
  }
}

resource "aws_subnet" "raku_pvt02_2a" {
  vpc_id            = aws_vpc.raku_vpc.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "raku-pvt02-2a"
  }
}
