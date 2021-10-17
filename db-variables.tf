################################################################################################################
# db-variables.tf
# db 서버에 관련된 변수들을 선언 해놓은 파일 입니다. 대부분 db.tf에서 var.xxxx 형태로 변수를 호출하여 사용 합니다. 
################################################################################################################

# keypair 변수
variable "db_keypair" {
  default = "secret"
}



# db security group(mysql)
variable "db_mysql_sg_name" {
  default = "tf-singa-wp-db-mysql-sg-inhyo"
}

variable "db_mysql_sg_cidr_blocks" {
  default = [
    "10.70.21.0/24", # app subnet az-a
    "10.70.22.0/24"  # app subnet az-b
  ]
}

variable "db_mysql_sg_tags" {
  default = {
    Name = "tf-singa-wp-db-mysql-sg-inhyo"
  }
}



# db security group(ssh)
variable "db_ssh_sg_name" {
  default = "tf-singa-wp-db-ssh-sg-inhyo"
}

variable "db_ssh_sg_cidr_blocks" {
  default = [
    "10.70.11.11/32", # bastion local ip
    "10.70.21.0/24",
    "10.70.22.0/24"
  ]
}

variable "db_ssh_sg_tags" {
  default = {
    Name = "tf-singa-wp-db-ssh-sg-inhyo"
  }
}



# db 인스턴스 관련 변수들
variable "db_name" {
  default = "tf-singa-wp-db-inhyo"
}

variable "db_ami" {
  default = "ami-0dee86061a4063fc4"
}

variable "db_instance_type" {
  default = "t2.micro"
}

variable "db_private_ip" {
  default = "10.70.31.31"
}

variable "db_tags" {
  default = {
    Name = "tf-singa-wp-db-inhyo"
  }
}