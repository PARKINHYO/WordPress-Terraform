####################################################################################################
# asg-variables.tf
# asg에 관련된 변수들을 선언 해놓은 파일 입니다. 대부분 asg.tf에서 var.xxxx 형태로 변수를 호출하여 사용 합니다. 
####################################################################################################



# keypair
variable "app_keypair" {
  default = "secret"
}



# ALB Security Group(HTTP)
variable "alb_http_sg_name" {
  default = "tf-singa-wp-alb-http-sg-inhyo"
}

variable "alb_http_sg_tags" {
  default = {
    Name = "tf-singa-wp-alb-http-sg-inhyo"
  }
}



# ALB Security Group(SSH)
variable "asg_bastion_sg_name" {
  default = "tf-singa-wp-alb-bastion-sg-inhyo"
}

variable "asg_bastion_sg_tags" {
  default = {
    Name = "tf-singa-wp-alb-bastion-sg-inhyo"
  }
}

variable "asg_bastion_sg_ingress_cidr_blocks" {
  default = [
    "10.70.11.11/32"
  ]
}



# ASG Security Group
variable "asg_sg_name" {
  default = "tf-singa-test-wp-asg-sg-inhyo"
}

variable "asg_sg_tags" {
  default = {
    Name = "tf-singa-wp-asg-sg-inhyo"
  }
}



# ALB 관련 변수
variable "alb_name" {
  default = "tf-singa-wp-alb-inhyo"
}

variable "alb_tg_name" {
  default = "tf-singa-wp-alb-tg-inhyo"
}

variable "alb_tags" {
  default = {
    Name = "tf-singa-wp-alb-inhyo"
  }
}



# ASG 관련 변수 
variable "lt_name" {
  default = "tf-singa-wp-lt-inhyo"
}

variable "min_size" {
  default = 0
}

variable "max_size" {
  default = 1
}

variable "desired_capacity" {
  default = 1
}

variable "use_lt" {
  default = true
}

variable "create_lt" {
  default = true
}

variable "image_id" {
  default = "ami-09f36c6434f043b29"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "lt_tags" {
  default = [{
    Name = "tf-singa-wp-lt-inhyo"
  }]
}
