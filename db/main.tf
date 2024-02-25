resource "aws_db_instance" "db" {
  allocated_storage      = 10
  db_name                = "terraform_db"
  engine                 = "postgres"
  engine_version         = "11.18"
  instance_class         = "db.t3.micro"
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.postgres11"
  skip_final_snapshot    = true
  multi_az               = false # Need to change it to true for high availability but not free tier eligible
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.tf-db-sg.id]
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "terraform_db_subnet_group"
  subnet_ids = [var.db_subnet_1_id, var.db_subnet_2_id]

  tags = {
    Name = "Terraform DB Subnet group"
  }
}

resource "aws_security_group" "tf-db-sg" {
  name        = "allow_postgres_port"
  description = "Allow Postgres traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "tf-db-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_allow_postgres" {
  security_group_id            = aws_security_group.tf-db-sg.id
  referenced_security_group_id = var.app_server_sg_id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}
