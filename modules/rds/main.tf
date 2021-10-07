# locals {
#   name   = "complete-mysql"
#   region = "eu-west-1"
#   tags = {
#     Owner       = "user"
#     Environment = "dev"
#   }
# }

################################################################################
# Supporting Resources
################################################################################

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 2"

#   name = var.rds_sg_name
#   cidr = "10.99.0.0/18"

#   azs              = ["${local.region}a", "${local.region}b", "${local.region}c"]
#   public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
#   private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
#   database_subnets = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]

#   create_database_subnet_group = true

#   tags = local.tags
# }

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = var.rds_sg_name
  description = "MySQL test security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = var.rds_sg_tags
}

################################################################################
# RDS Module
################################################################################

module "db" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = var.rds_name

  engine               = "mysql"
  engine_version       = "8.0.23"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage     = 10
  max_allocated_storage = 10
  storage_encrypted     = false

  name     = "wordpress"
  username = "complete_mysql"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = 3306

  multi_az               = true
  subnet_ids             = module.vpc.intra_subnets
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = var.rds_tags
  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}

module "db_default" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = var.db_default

  create_db_option_group    = false
  create_db_parameter_group = false

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.20"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t3.large"

  allocated_storage = 20

  name                   = "completeMysql"
  username               = "complete_mysql"
  create_random_password = true
  random_password_length = 12
  port                   = 3306

  subnet_ids             = module.vpc.database_subnets
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

  tags = var.db_default_tag
}

module "db_disabled" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = var.db_disabled

  create_db_instance        = false
  create_db_subnet_group    = false
  create_db_parameter_group = false
  create_db_option_group    = false
}