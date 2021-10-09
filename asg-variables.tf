variable "asg_sg_name" {
  default = "tf-singa-test-wp-asg-sg-inhyo"
}

variable "asg_sg_tags" {
  default = {
    Name = "tf-singa-wp-asg-sg-inhyo"
  }

}

variable "alb_http_sg_name" {
  default = "tf-singa-wp-alb-http-sg-inhyo"
}

variable "alb_http_sg_tags" {
  default = {
    Name = "tf-singa-wp-alb-http-sg-inhyo"
  }
}

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
  default = "ami-012d415ce72511b81"
}

variable "instance_type" {
  default = "t3.nano"
}

variable "lt_tags" {
  default = [{
    Name = "tf-singa-wp-lt-inhyo"
  }]
}

variable "alb_bastion_sg_name" {
  default = "tf-singa-wp-alb-bastion-sg-inhyo"
}

variable "alb_bastion_sg_tags" {
  default = {
    Name = "tf-singa-wp-alb-bastion-sg-inhyo"
  }
}