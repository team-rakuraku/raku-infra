#Region
provider "aws" {
  region = "ap-northeast-2"
}

#VPC
data "aws_vpc" "raku_vpc" { 
  tags = {
    Name = "raku-vpc" 
  }
}

#Subnet
data "aws_subnet" "raku_pub01_2a" {
  tags = {
    Name = "raku-pub01-2a"
  }
}
data "aws_subnet" "raku_pvt01_2c" {
  tags = {
    Name = "raku-pvt01-2c"
  }
}
data "aws_subnet" "raku_pvt02_2a" {
  tags = {
    Name = "raku-pvt02-2a"
  }
}


#Security Group
data "aws_security_group" "cluster_sg" {
  name   = "cluster-sg"
}
data "aws_security_group" "node_grp_sg" {
  name   = "node-grp-sg"
}