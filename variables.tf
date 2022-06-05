# AWS account
variable "aws_access_key" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

# Preferences
variable "aws_region" {
  type        = string
  description = "The desired AWS region"
  default     = "us-west-1"
}

variable "az_count" {
  type        = number
  description = "Number of AZs to cover in a given region"
  default     = 2
}

# ALB
variable "health_check_path" {
  type        = string
  description = "ALB health check path"
  default     = "/"
}

# AWS ECS
variable "ecs_task_execution_role_name" {
  type        = string
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
  type        = string
  description = "ECS auto scaling role Name"
  default     = "myEcsAutoScaleRole"
}

variable "app_image" {
  type        = string
  description = "Docker image to run in the ECS cluster"
  default     = "0p0inter/expressjs-sequelize-sample:latest"
}

variable "app_port" {
  type        = number
  description = "Exposed port of the docker image to redirect traffic to"
  default     =  8080
}

variable "app_count" {
  type        = number
  description = "Desired number of docker containers to run"
  default     = 2
}

# ECS Fargate
variable "fargate_cpu" {
  type        = number
  description = "Number of CPU units to provision for Fargate instance (1 vCPU = 1024 CPU units)"
  default     = 1024
}

variable "fargate_memory" {
  type        = number
  description = "RAM to provision for Fargate instance (in Mbs)"
  default     =  2048
}

# RDS
variable "rds_database_identifier" {
  type        = string
  description = "Database identifier for the RDS instance"
  default     = "my-sample-app-database"
}

variable "rds_allocated_storage" {
  type        = number
  description = "Allocated storage for the RDS instance (in Gbs)"
  default     = 10
}

variable "rds_engine_version" {
  type = string
  description = "MySQL version number"
  default = "5.7"
}

variable "rds_instance_class" {
  type = string
  description = "RDS instance class"
  default = "db.t3.micro"
}

variable "rds_instance_parameter_group_name" {
  type = string
  description = "Parameter group name of the RDS instance"
  default = "default.mysql5.7"
}

variable "rds_database_port" {
  type = number
  description = "Port number of the RDS instance (default to 3306 - mysql)"
  default = 3306
}

variable "database_name" {
  type        = string
  description = "The name of the database to be created"
  default     = "sampleappdb"
}