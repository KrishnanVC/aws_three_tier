output "app_server_sg_id" {
  value       = aws_security_group.tf-app-server-sg.id
  description = "Security group ID of the app server"
}
