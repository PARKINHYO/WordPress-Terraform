terraform {
  required_version = ">= 0.12.26"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.49"
    }
  }

  backend "remote" {
    organization = "ihp001"

    workspaces {
      name = "WordPress-Terraform"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}