resource "aws_key_pair" "tf_singa_keypair_bast_WP_inhyo" {
  key_name   = "deployer-key"
  public_key = var.bastion_keypair

}

module "bastion_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.bastion_sg_name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["118.222.188.115/32"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = var.bastion_sg_tags
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.bastion_name

  ami                         = var.bastion_ami
  instance_type               = var.bastion_instance_type
  key_name                    = aws_key_pair.tf_singa_keypair_bast_WP_inhyo.key_name
  vpc_security_group_ids      = [module.bastion_security_group.security_group_id]
  subnet_id                   = element(module.vpc.public_subnets, 0)
  availability_zone           = element(module.vpc.azs, 0)
  associate_public_ip_address = var.bastion_eip

  tags = var.bastion_tags
}