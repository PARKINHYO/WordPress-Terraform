variable "rds_sg_name" {
    default = "osaka-rds-sg-test-wp-inhyo"
}

variable "rds_sg_tags" {
    default = {
        Name = "osaka-rds-sg-test-wp-inhyo"
    }
  
}

variable "rds_name" {
    default = "osaka-rds-test-wp-inhyo"
  
}

variable "rds_tags" {
    default = "osaka-rds-test-wp-inhyo"
  
}

variable "db_default" {
    default = "osaka-rds-dbdefault-test-wp-inhyo"
  
}

variable "db_default_tag" {
    default = "osaka-rds-dbdefault-test-wp-inhyo"
  
}

variable "db_disabled" {
    default = "osaka-rds-dbdisabled-test-wp-inhyo"
}

variable "engine" {
    default = "mysql"
  
}

variable "engine_version" {
    default = "8.0.23"
}

variable "family" {
  default = "mysql8.0"
}

variable "major_engine_version" {
  default = "8.0"
}

variable "allocated_storage" {
    default = "10"
}

variable "max_allocated_storage" {
    default = "10"
  
}

variable "storage_encrypted" {
  default = false
}

variable "db_name" {
  default = "wordpress"
}

variable "db_username" {
  default = "ihp001"
}

variable "db_password" {
  
}

variable "db_port" {
  default = "3306"
}

variable "multi_az" {
  default = false
}

variable "subnet_ids" {
  
}