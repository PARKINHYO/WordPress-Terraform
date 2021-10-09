variable "bastion_keypair" {
  default = "secret"
}

variable "bastion_sg_name" {
  default = "tf-singa-wp-bastion-sg-inhyo"
}

variable "bastion_sg_tags" {
  default = {
    Name = "tf-singa-wp-bastion-sg-inhyo"
  }
}

variable "bastion_name" {
  default = "tf-singa-wp-bastion-inhyo"
}

variable "bastion_ami" {
  default = "ami-0c07cd0ceb5369def"
}

variable "bastion_instance_type" {
  default = "t2.nano"
}

variable "bastion_eip" {
  default = true
}

variable "bastion_tags" {
  default = {
    Name = "tf-singa-wp-bastion-inhyo"
  }
}