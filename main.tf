provider "aws" {
  region = local.region
}

locals {
  region = "eu-west-1"
}

################################################################################
# VPC Module
################################################################################
resource "aws_eip" "nat" {
  count = 1

  vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-separate-private-route-tables"

  cidr = "10.10.0.0/16"

  azs                 = ["${local.region}a", "${local.region}b"]
  private_subnets     = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets      = ["10.10.11.0/24", "10.10.12.0/24"]
  database_subnets    = ["10.10.21.0/24", "10.10.22.0/24"]
  # elasticache_subnets = ["10.10.31.0/24", "10.10.32.0/24", "10.10.33.0/24"]
  # redshift_subnets    = ["10.10.41.0/24", "10.10.42.0/24", "10.10.43.0/24"]

  # create_database_subnet_route_table    = true
  # create_elasticache_subnet_route_table = true
  # create_redshift_subnet_route_table    = true

  single_nat_gateway = true
  enable_nat_gateway = true
  one_nat_gateway_per_az = false
  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"

  tags = {
    # Owner       = "user"
    # Environment = "staging"
    Name        = "separate-private-route-tables"
  }
}