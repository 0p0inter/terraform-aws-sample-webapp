[
  {
    "name": "sample-app",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/sample-app",
          "awslogs-region": "${aws_region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "environment": [
      {
        "name": "DB_HOST",
        "value": "${rds_hostname_url}"
      },
      {
        "name": "DB_USER",
        "value": "${rds_username}"
      },
      {
        "name": "DB_NAME",
        "value": "${rds_db_name}"
      },
      {
        "name": "DB_PORT",
        "value": "${rds_db_port}"
      }
    ],
    "secrets": [
      {
        "name": "DB_PASSWORD",
        "valueFrom": "${rds_password}"
      }
    ],
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ]
  }
]



