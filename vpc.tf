################################################################################
# VPC Module
################################################################################
resource "aws_eip" "nat" {
  count = 1
  vpc   = true
  tags  = var.nat_eip_tags
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.vpc_name
  cidr            = var.vpc_cidr
  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  intra_subnets   = var.intra_subnets

  single_nat_gateway     = var.single_nat_gateway
  enable_nat_gateway     = var.enable_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  reuse_nat_ips       = var.reuse_nat_ips
  external_nat_ip_ids = aws_eip.nat.*.id

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  public_subnet_suffix  = var.public_subnets_suffix
  private_subnet_suffix = var.private_subnets_suffix
  intra_subnet_suffix   = var.intra_subnets_suffix

  vpc_tags                 = var.vpc_tags
  igw_tags                 = var.igw_tags
  intra_route_table_tags   = var.intra_route_table_tags
  intra_subnet_tags        = var.intra_subnet_tags
  nat_eip_tags             = var.nat_eip_tags
  nat_gateway_tags         = var.nat_gateway_tags
  private_route_table_tags = var.private_route_table_tags
  private_subnet_tags      = var.private_subnet_tags
  public_route_table_tags  = var.public_route_table_tags
  public_subnet_tags       = var.public_subnet_tags

}
