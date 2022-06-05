# TerraForm AWS Sample Webapp

This repository contains Terraform code to deploy a complete environment that is intended to run [expressjs-sequelize-sample application](https://github.com/0p0inter/expressjs-sequelize-sample) in ECS containers with Fargate compatibility.  Uses the [rds-mysql](https://registry.terraform.io/modules/0p0inter/rds-mysql/aws/1.0.0) module to provision the database instance required by the app.  

The setup creates the following resources:

 - VPC in the chosen region
 - Public and Private subnets per AZ (az_count)
 - Routing tables for subnets
 - Internet Gateway for public subnets
 - NAT gateways with attached Elastic IPs for the private subnet
 - Three Security Groups
	 - SG for the ALB to restrict access to the application
	 - SG to limit incoming traffic to the ECS cluster - only from the ALB
	 - SG to limit incoming traffic to the RDS database - only from the ECS cluster
 - ALB and target group with a listener for port 8080
 - AWS Secrets database to store the MySQL master password including IAM role policy for ECS task to read the stored secret.
 - RDS instance (mysql) in the private subnet of the VPC
 - ECS cluster with 'app_count' services (incl. auto scaling policies for CPU & memory usage) and task definition to run docker containers from Docker Hub including the appropriate IAM execution role
 - CloudWatch log group and stream for the application

## Prerequisites

 1.  Install Terraform v1.1.6 or above.
 2.  Change AWS access key and secret variables in terraform.tfvars

## Usage

```
terraform init
terraform plan
terraform apply
```

## Requirements
  
<!-- BEGIN_TF_DOCS -->

| Name | Version |

|------|---------|

| <a  name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.7.0 |

  

## Providers

  

| Name | Version |

|------|---------|

| <a  name="provider_aws"></a> [aws](#provider\_aws) | 4.17.1 |

| <a  name="provider_random"></a> [random](#provider\_random) | 3.2.0 |

| <a  name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

  

## Modules

  

| Name | Source | Version |

|------|--------|---------|

| <a  name="module_aws-rds"></a> [aws-rds](#module\_aws-rds) | 0p0inter/rds-mysql/aws | 1.0.0 |

  

## Resources

  

| Name | Type |

|------|------|

| [aws_alb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |

| [aws_alb_listener.front_end](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |

| [aws_alb_target_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |

| [aws_appautoscaling_policy.down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |

| [aws_appautoscaling_policy.up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |

| [aws_appautoscaling_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |

| [aws_cloudwatch_log_group.cb_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |

| [aws_cloudwatch_log_stream.cb_log_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |

| [aws_cloudwatch_metric_alarm.service_cpu_high](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

| [aws_cloudwatch_metric_alarm.service_cpu_low](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

| [aws_ecs_cluster.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |

| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |

| [aws_ecs_task_definition.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

| [aws_eip.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

| [aws_iam_role_policy.password_policy_secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

| [aws_iam_role_policy_attachment.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |

| [aws_nat_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |

| [aws_route.internet_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |

| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |

| [aws_secretsmanager_secret.database_password_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |

| [aws_secretsmanager_secret_version.database_password_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

| [aws_security_group.ecs_tasks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

| [aws_security_group.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

| [aws_security_group.rds_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

| [random_string.random_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

| [aws_db_instance.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance) | data source |

| [aws_iam_policy_document.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

| [template_file.cb_app](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

  

## Inputs

  

| Name | Description | Type | Default | Required |

|------|-------------|------|---------|:--------:|

| <a  name="input_app_count"></a> [app\_count](#input\_app\_count) | Desired number of docker containers to run | `number` | `2` | no |

| <a  name="input_app_image"></a> [app\_image](#input\_app\_image) | Docker image to run in the ECS cluster | `string` | `"0p0inter/expressjs-sequelize-sample:latest"` | no |

| <a  name="input_app_port"></a> [app\_port](#input\_app\_port) | Exposed port of the docker image to redirect traffic to | `number` | `8080` | no |

| <a  name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS Access Key | `string` | n/a | yes |

| <a  name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The desired AWS region | `string` | `"us-west-1"` | no |

| <a  name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS Secret Key | `string` | n/a | yes |

| <a  name="input_az_count"></a> [az\_count](#input\_az\_count) | Number of AZs to cover in a given region | `number` | `2` | no |

| <a  name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the database to be created | `string` | `"sampleappdb"` | no |

| <a  name="input_ecs_auto_scale_role_name"></a> [ecs\_auto\_scale\_role\_name](#input\_ecs\_auto\_scale\_role\_name) | ECS auto scaling role Name | `string` | `"myEcsAutoScaleRole"` | no |

| <a  name="input_ecs_task_execution_role_name"></a> [ecs\_task\_execution\_role\_name](#input\_ecs\_task\_execution\_role\_name) | ECS task execution role name | `string` | `"myEcsTaskExecutionRole"` | no |

| <a  name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | Number of CPU units to provision for Fargate instance (1 vCPU = 1024 CPU units) | `number` | `1024` | no |

| <a  name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | RAM to provision for Fargate instance (in Mbs) | `number` | `2048` | no |

| <a  name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | ALB health check path | `string` | `"/"` | no |

| <a  name="input_rds_allocated_storage"></a> [rds\_allocated\_storage](#input\_rds\_allocated\_storage) | Allocated storage for the RDS instance (in Gbs) | `number` | `10` | no |

| <a  name="input_rds_database_identifier"></a> [rds\_database\_identifier](#input\_rds\_database\_identifier) | Database identifier for the RDS instance | `string` | `"my-sample-app-database"` | no |

| <a  name="input_rds_database_port"></a> [rds\_database\_port](#input\_rds\_database\_port) | Port number of the RDS instance (default to 3306 - mysql) | `number` | `3306` | no |

| <a  name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | MySQL version number | `string` | `"5.7"` | no |

| <a  name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | RDS instance class | `string` | `"db.t3.micro"` | no |

| <a  name="input_rds_instance_parameter_group_name"></a> [rds\_instance\_parameter\_group\_name](#input\_rds\_instance\_parameter\_group\_name) | Parameter group name of the RDS instance | `string` | `"default.mysql5.7"` | no |

  

## Outputs

  

| Name | Description |

|------|-------------|

| <a  name="output_alb_url"></a> [alb\_url](#output\_alb\_url) | The URL of the running application |

<!-- END_TF_DOCS -->