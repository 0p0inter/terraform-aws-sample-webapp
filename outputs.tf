output "alb_url" {
  value = "http://${aws_alb.main.dns_name}:${var.app_port}"
  description = "The URL of the running application"
}