
terraform {
  # 테라폼 버전 설정
  required_version = ">= 0.12.26"

  # AWS 프로바이더 소스 및 버전 설정
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.49"
    }
  }

  # 테라폼 클라우드 계정 및 workspace 설정
  backend "remote" {
    organization = "ihp001"

    workspaces {
      name = "WordPress-Terraform"
    }
  }
}


# AWS 프로바이더를 설정한다. 리전은 ap-southeast-1(싱가포르).
provider "aws" {
  region = "ap-southeast-1"
}