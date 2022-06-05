aws_access_key  = ""
aws_secret_key  = ""


// Optional variables

#aws_region      = "us-west-1"
#az_count        = 2

#health_check_path = "/"

#ecs_task_execution_role_name = "myEcsTaskExecutionRole"
#ecs_auto_scale_role_name = "myEcsAutoScaleRole"
#app_image = "0p0inter/expressjs-sequelize-sample:latest"
#app_port = 8080
#app_count = 2

#fargate_cpu = 1024
#fargate_memory = 2048

#rds_database_identifier = "my-sample-app-database"
#rds_allocated_storage = 10
#rds_engine_version = "5.7"
#rds_instance_class = "db.t3.micro"
#rds_instance_parameter_group_name = "default.mysql5.7"
#rds_database_port = 3306
#database_name   = "sampleappdb"