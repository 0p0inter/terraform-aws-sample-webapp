resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_secretsmanager_secret" "database_password_secret" {
  name = "/sample-expressjs-app/rds-mysql-instance-${random_string.random_suffix.result}"
}

resource "aws_secretsmanager_secret_version" "database_password_secret_version" {
  secret_id     = aws_secretsmanager_secret.database_password_secret.id
  secret_string = random_password.password.result
}

