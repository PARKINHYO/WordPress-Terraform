################################################################################################################
# bastion-variables.tf
# bastion 서버에 관련된 변수들을 선언 해놓은 파일 입니다. 대부분 bastion.tf에서 var.xxxx 형태로 변수를 호출하여 사용 합니다. 
################################################################################################################

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

variable "bastion_private_ip" {
  default = "10.70.11.11"
}

variable "bastion_tags" {
  default = {
    Name = "tf-singa-wp-bastion-inhyo"
  }
}