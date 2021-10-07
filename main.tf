terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.49"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.0.1"
    # }
  }
  required_version = ">= 0.14"

  backend "remote" {
    organization = "ihp001"

    workspaces {
      name = "WordPress-Terraform"
    }
  }
}

provider "aws" {
  region = "ap-northeast-3"
}
