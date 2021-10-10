resource "aws_key_pair" "tf_singa_keypair_app_WP_inhyo" {
  key_name   = "app-key"
  public_key = var.app_keypair
}

################################################################################
# Supporting Resources
################################################################################

module "asg_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.asg_sg_name
  description = "A security group"
  vpc_id      = module.vpc.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.alb_http_sg.security_group_id
    },
    {
      rule                     = "bastion-22-tcp"
      source_security_group_id = module.alb_bastion_sg.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]

  tags = var.asg_sg_tags
}

module "alb_http_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.0"

  name        = var.alb_http_sg_name
  vpc_id      = module.vpc.vpc_id
  description = "Security group for alb"

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = var.alb_http_sg_tags

}

module "alb_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name        = var.alb_bastion_sg_name
  vpc_id      = module.vpc.vpc_id
  description = "Security group for alb"

  ingress_cidr_blocks = ["10.70.11.0/24"]

  tags = var.alb_bastion_sg_tags
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.alb_name

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_http_sg.security_group_id]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name             = var.alb_tg_name
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    },
  ]

  tags = var.alb_tags
}

################################################################################
# Default
################################################################################

# Launch template
module "default_lt" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = var.lt_name

  vpc_zone_identifier       = module.vpc.private_subnets
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0
  enable_monitoring         = true
  # Launch template
  use_lt    = var.use_lt
  create_lt = var.create_lt

  image_id      = var.image_id
  instance_type = var.instance_type

  target_group_arns = module.alb.target_group_arns
  security_groups   = [module.asg_sg.security_group_id]
  key_name          = aws_key_pair.tf_singa_keypair_app_WP_inhyo.key_name

  user_data = <<-EOF
            #!/bin/bash
            echo ${module.db.db_instance_endpoint} > .env
            docker-compose up -d
            EOF

  tags = var.lt_tags
}
