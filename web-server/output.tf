output "web_server_sg_id" {
  value       = aws_security_group.tf-web-server-sg.id
  description = "Security group ID of the web server"
}
