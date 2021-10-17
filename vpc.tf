###################################################################################################################
# 테라폼에서 만든 VPC 모듈을 사용해서 VPC, Subnet, Routing table, NAT를 생성합니다. 

# Subnet은 bastion용 public subnet 2개, app을 위한 private subnet 2개, db를 위한 private subnet 2개를
# 가용영역 ap-southeast-1a, ap-southeast-1b에 나눠 생성합니다. 

# Routing table은 bastion, app, db용으로 3개를 만들고, bastion 라우팅 테이블에는 IGW, app의 라우팅 테이블에는 NAT를 등록합니다. 

# vpc-variables.tf에 변수를 선언하고, 리소스 및 모듈의 속성들은 var.xxxx를 통해 변수를 불러와 사용합니다. 
# 완성된 리소스의 결과를 확인하기 위해 vpc-outputs.tf에 확인 할 결과들을 출력합니다. 
###################################################################################################################


# NAT에서 사용할 Elastic IP를 aws 리소스를 통해 1개 만듭니다. 
resource "aws_eip" "nat" {
  count = 1
  vpc   = true
  tags  = var.nat_eip_tags
}

################################################################################
# VPC Module
################################################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.vpc_name                         # 모듈 이름
  cidr            = var.vpc_cidr                         # VPC CIDR
  azs             = ["${var.region}a", "${var.region}b"] # 가용영역 ap-southeast-1a, ap-southeast-1b
  public_subnets  = var.public_subnets                   # bastion용 서브넷
  private_subnets = var.private_subnets                  # app용 서브넷. private subnet에 NAT 게이트웨이를 등록할 수 있습니다. 
  intra_subnets   = var.intra_subnets                    # db용 서브넷. intra subnet은 라우팅 테이블에 vpc 대역만 있고, 내부로만 통신합니다. 

  /*
  NAT 게이트웨이 관련 설정
  NAT를 활성화 하여 가용 영역 당 하나만 생성하도록 설정합니다. 
  NAT용 EIP를 재사용할 수 있게 설정하고, 위에서 만든 Elastic IP의 id를 대입합니다. 
  */
  single_nat_gateway     = var.single_nat_gateway
  enable_nat_gateway     = var.enable_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  reuse_nat_ips       = var.reuse_nat_ips
  external_nat_ip_ids = aws_eip.nat.*.id

  # VPC에서 DNS가 가능하도록 설정합니다. 
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  # subnet의 이름을 설정합니다. 
  public_subnet_suffix  = var.public_subnets_suffix
  private_subnet_suffix = var.private_subnets_suffix
  intra_subnet_suffix   = var.intra_subnets_suffix

  # vpc, igw, routing tables, nat, subnets의 태그들을 설정합니다. 
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
