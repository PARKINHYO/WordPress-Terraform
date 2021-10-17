####################################################################################################
# vpc-variables.tf
# VPC에 관련된 변수들을 선언 해놓은 파일 입니다. 대부분 vpc.tf에서 var.xxxx 형태로 변수를 호출하여 사용 합니다. 
####################################################################################################

# aws 리전
variable "region" {
  default = "ap-southeast-1"
}

# vpc name
variable "vpc_name" {
  default = "singa-vpc-test-wp-inhyo"
}

# vpc cidr
variable "vpc_cidr" {
  default = "10.70.0.0/16"

}

# vpc 태그
variable "vpc_tags" {
  default = {
    Name = "singa-vpc-test-wp-inhyo"
  }

}

# public 서브넷 
variable "public_subnets" {
  default = ["10.70.11.0/24", "10.70.12.0/24"]
}

# app 서브넷
variable "private_subnets" {
  default = ["10.70.21.0/24", "10.70.22.0/24"]
}

# db 서브넷
variable "intra_subnets" {
  default = ["10.70.31.0/24", "10.70.32.0/24"]
}

# igw 태그
variable "igw_tags" {
  default = {
    Name = "singa-igw-test-wp-inhyo"
  }

}

# db routing table 태그
variable "intra_route_table_tags" {
  default = {
    Name = "singa-rt-intra-test-wp-inhyo"
  }

}

# db sunbet 태그
variable "intra_subnet_tags" {
  default = {
    Name = "singa-snet-intra-test-wp-inhyo"
  }

}

# NAT Elastic 태그
variable "nat_eip_tags" {
  default = {
    Name = "singa-nat-eip-test-wp-inhyo"
  }

}

# NAT 게이트웨이 태그
variable "nat_gateway_tags" {
  default = {
    Name = "singa-nat-test-wp-inhyo"
  }
}

# app routing table 태그
variable "private_route_table_tags" {
  default = {
    Name = "singa-rt-pri-test-wp-inhyo"
  }
}

# app subnet 태그
variable "private_subnet_tags" {
  default = {
    Name = "singa-snet-pri-test-wp-inhyo"
  }

}

# bastion routing table 태그
variable "public_route_table_tags" {
  default = {
    Name = "singa-rt-pub-test-wp-inhyo"
  }

}

# public subnet 태그
variable "public_subnet_tags" {
  default = {
    Name = "singa-snet-pub-test-wp-inhyo"
  }

}

# NAT 게이트웨이 관련 설정
variable "single_nat_gateway" {
  default = true

}

variable "enable_nat_gateway" {
  default = true
}

variable "one_nat_gateway_per_az" {
  default = false
}

variable "reuse_nat_ips" {
  default = true

}

# DNS 관련 설정
variable "enable_dns_hostnames" {
  default = true

}

variable "enable_dns_support" {
  default = true

}

# Subnet names 설정
variable "public_subnets_suffix" {
  default = "singa-snet-public-test-wp-inhyo"

}

variable "private_subnets_suffix" {
  default = "singa-snet-private-test-wp-inhyo"
}

variable "intra_subnets_suffix" {
  default = "singa-snet-intra-test-wp-inhyo"
}