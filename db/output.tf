output "db_sg_id" {
  value       = aws_security_group.tf-db-sg.id
  description = "Security group ID of the Database"
}
