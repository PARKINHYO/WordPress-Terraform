provider "aws" {
  region = "ap-northeast-3"
}

module "vpc"{
  source = "./modules/vpc"
}

module "rds" {
  source = "./modules/rds"
}