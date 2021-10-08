variable "region" {
    default = "ap-southeast-1"
}

variable "vpc_name" {
  default = "osaka-vpc-test-wp-inhyo"
}

variable "vpc_cidr" {
    default = "10.70.0.0/16"
  
}

variable "vpc_tags" {
    default = {
        Name = "osaka-vpc-test-wp-inhyo"
    }
  
}

variable "public_subnets" {
    default = ["10.70.11.0/24", "10.70.12.0/24"]
}

variable "private_subnets" {
    default = ["10.70.21.0/24", "10.70.22.0/24"]
}

variable "intra_subnets" {
    default = ["10.70.31.0/24", "10.70.32.0/24"]
}

variable "igw_tags" {
    default = {
        Name = "osaka-igw-test-wp-inhyo"
    }
  
}

variable "intra_route_table_tags" {
    default = {
        Name = "osaka-rt-intra-test-wp-inhyo"
    }

}

variable "intra_subnet_tags" {
    default = {
        Name = "osaka-snet-intra-test-wp-inhyo"
    }
  
}

variable "nat_eip_tags" {
    default = {
        Name = "osaka-nat-eip-test-wp-inhyo"
    }
  
}

variable "nat_gateway_tags" {
  default = {
      Name = "osaka-nat-test-wp-inhyo"
  }
}
    
variable "private_route_table_tags" {
  default = {
      Name = "osaka-rt-pri-test-wp-inhyo"
  }
}

variable "private_subnet_tags" {
    default = {
        Name = "osaka-snet-pri-test-wp-inhyo"
    }
  
}

variable "public_route_table_tags" {
    default = {
        Name = "osaka-rt-pub-test-wp-inhyo"
    }
  
}

variable "public_subnet_tags" {
    default = {
        Name = "osaka-snet-pub-test-wp-inhyo"
    }
  
}

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

variable "enable_dns_hostnames" {
    default = true
  
}

variable "enable_dns_support" {
    default = true
  
}

variable "public_subnets_suffix" {
    default = "osaka-snet-public-test-wp-inhyo"
  
}

variable "private_subnets_suffix" {
    default = "osaka-snet-private-test-wp-inhyo"
}

variable "intra_subnets_suffix" {
  default = "osaka-snet-intra-test-wp-inhyo"
}