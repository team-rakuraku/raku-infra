provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "lakulakubucket" # S3 버킷 이름
    key            = "terraform/state.tfstate" # tfstate 저장 경로
    region         = "ap-northeast-2"
    dynamodb_table = "tfstatetable" # dynamodb table 이름
  }
}