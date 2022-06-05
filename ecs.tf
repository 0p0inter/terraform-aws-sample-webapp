resource "aws_ecs_cluster" "main" {
  name = "sample-app-cluster"
}

data "aws_db_instance" "database" {
  db_instance_identifier = var.rds_database_identifier
  depends_on = [
    module.aws-rds
  ]
}

data "template_file" "cb_app" {
  template = file("./templates/app.json.tpl")

  vars = {
    app_image        = var.app_image
    app_port         = var.app_port
    fargate_cpu      = var.fargate_cpu
    fargate_memory   = var.fargate_memory
    aws_region       = var.aws_region
    rds_hostname_url = data.aws_db_instance.database.address
    rds_username     = "${random_string.random.result}"
    rds_password     = aws_secretsmanager_secret.database_password_secret.arn
    rds_db_name      = var.database_name
    rds_db_port      = var.rds_database_port
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "sample-app-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.cb_app.rendered
  depends_on = [
    module.aws-rds,
    aws_secretsmanager_secret_version.database_password_secret_version
  ]
}

resource "aws_ecs_service" "main" {
  name            = "sample-app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    #assign_public_ip = true
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "sample-app"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}