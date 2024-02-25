output "app_lb_sg_id" {
  value       = aws_security_group.tf_app_lb_sg.id
  description = "Security group ID of the app load balancer"
}

output "app_lb_dns_name" {
  value       = aws_lb.tf_app_load_balancer.dns_name
  description = "DNS name of the app load balancer"
}

output "app_server_sg_id" {
  value       = aws_security_group.tf-app-server-sg.id
  description = "Security group ID of the app server"
}
