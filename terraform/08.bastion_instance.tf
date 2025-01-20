#Key Pair
resource "aws_key_pair" "raku_key" {
  key_name   = "raku-key"
  public_key = file("~/.ssh/id_rsa.pub")
}



data "aws_ami" "bastion_nat" {
  most_recent = true

  filter {
    name   = "owner-id"
    values = ["340752825860"] # 나중에 수정 예정 
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["340752825860"]
}


resource "aws_instance" "raku_bastion_nat" {
  ami           = data.aws_ami.bastion_nat.id
  instance_type = "t3.small" # 나중에 규모 커지면 t3.medium까지 확장 가능 
  subnet_id                   = aws_subnet.raku_pub01_2a.id
  associate_public_ip_address = "true"
  key_name                    = "raku-key"
  security_groups = [aws_security_group.bastion_sg.id]
  source_dest_check      = false

  root_block_device {
    volume_size = 15
  }
  tags = {
    Name = "raku-bastion-nat"
  }
}
