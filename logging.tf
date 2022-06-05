resource "aws_cloudwatch_log_group" "sample_app_log_group" {
  name              = "/ecs/sample-app"
  retention_in_days = 30

  tags = {
    Name = "sample-app-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "sample_app_log_stream" {
  name           = "sample-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.sample_app_log_group.name
}