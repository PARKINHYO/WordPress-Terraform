terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.28"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 0.14"

  backend "remote" {
    organization = "ihp001"

    workspaces {
      name = "WordPress-Terraform"
    }
  }
}
