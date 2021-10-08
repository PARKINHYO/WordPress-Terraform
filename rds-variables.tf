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
    default = {
      Name = "osaka-rds-test-wp-inhyo"
    }
  
}

# variable "db_default" {
#     default = "osaka-rds-dbdefault-test-wp-inhyo"
  
# }

# variable "db_default_tag" {
#     default = "osaka-rds-dbdefault-test-wp-inhyo"
  
# }

# variable "db_disabled" {
#     default = "osaka-rds-dbdisabled-test-wp-inhyo"
# }

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

variable "instance_class" {
  default = "db.t3.micro"
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
  default = "secret"
}

variable "db_password" {
  default = "secret"
}

variable "db_port" {
  default = "3306"
}

variable "multi_az" {
  default = false
}

variable "skip_final_snapshot" {
  default = true
}

variable "deletion_protection" {
  default = false
}

variable "performance_insights_enabled" {
  default = false
}

variable "create_monitoring_role" {
  default = false
}

variable "db_parameter" {
  default = [
        {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}