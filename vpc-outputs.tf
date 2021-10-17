##########################################################################
# vpc-outputs.tf
# VPC를 생성한 뒤 나오는 리소스 결과들을 확인하기 위해 정의 해놓은 outputs입니다. 
##########################################################################

# vpc id
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# subnet id
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}