
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

  cidr = "10.70.0.0/16"

  azs                 = ["${var.region}a", "${var.region}b"]
  private_subnets     = ["10.70.21.0/24", "10.70.22.0/24"]
  public_subnets      = ["10.70.11.0/24", "10.70.12.0/24"]
  intra_subnets    = ["10.70.31.0/24", "10.70.32.0/24"]

  single_nat_gateway = true
  enable_nat_gateway = true
  one_nat_gateway_per_az = false

  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"

  enable_dns_hostnames = true
  enable_dns_support = true

  enable_classiclink = true
  enable_classiclink_dns_support = true

  tags = {
    # Owner       = "user"
    # Environment = "staging"
    Name        = "separate-private-route-tables"
  }
}