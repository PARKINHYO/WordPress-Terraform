################################################################################
# Default
################################################################################

# Launch template
output "default_lt_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.default_lt.launch_template_id
}

output "default_lt_launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.default_lt.launch_template_arn
}

output "default_lt_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.default_lt.launch_template_latest_version
}

output "default_lt_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.default_lt.autoscaling_group_id
}

output "default_lt_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.default_lt.autoscaling_group_name
}

output "default_lt_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.default_lt.autoscaling_group_arn
}

output "default_lt_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.default_lt.autoscaling_group_min_size
}

output "default_lt_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.default_lt.autoscaling_group_max_size
}

output "default_lt_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.default_lt.autoscaling_group_desired_capacity
}

output "default_lt_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.default_lt.autoscaling_group_default_cooldown
}

output "default_lt_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.default_lt.autoscaling_group_health_check_grace_period
}

output "default_lt_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.default_lt.autoscaling_group_health_check_type
}

output "default_lt_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.default_lt.autoscaling_group_availability_zones
}

output "default_lt_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.default_lt.autoscaling_group_vpc_zone_identifier
}

output "default_lt_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.default_lt.autoscaling_group_load_balancers
}

output "default_lt_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.default_lt.autoscaling_group_target_group_arns
}

# Launch configuration
output "default_lc_launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.default_lc.launch_configuration_id
}

output "default_lc_launch_configuration_arn" {
  description = "The ARN of the launch configuration"
  value       = module.default_lc.launch_configuration_arn
}

output "default_lc_launch_configuration_name" {
  description = "The name of the launch configuration"
  value       = module.default_lc.launch_configuration_name
}

output "default_lc_autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.default_lc.autoscaling_group_id
}

output "default_lc_autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.default_lc.autoscaling_group_name
}

output "default_lc_autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.default_lc.autoscaling_group_arn
}

output "default_lc_autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.default_lc.autoscaling_group_min_size
}

output "default_lc_autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.default_lc.autoscaling_group_max_size
}

output "default_lc_autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.default_lc.autoscaling_group_desired_capacity
}

output "default_lc_autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.default_lc.autoscaling_group_default_cooldown
}

output "default_lc_autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.default_lc.autoscaling_group_health_check_grace_period
}

output "default_lc_autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.default_lc.autoscaling_group_health_check_type
}

output "default_lc_autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.default_lc.autoscaling_group_availability_zones
}

output "default_lc_autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.default_lc.autoscaling_group_vpc_zone_identifier
}

output "default_lc_autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.default_lc.autoscaling_group_load_balancers
}

output "default_lc_autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.default_lc.autoscaling_group_target_group_arns
}