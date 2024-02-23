# TODO: Need to change all this to make it free tier eligible
resource "aws_db_instance" "db" {
  allocated_storage    = 10
  db_name              = "postgres"
  engine               = "postgres"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  multi_az             = false # Need to change it to true for high availability but not free tier eligible
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
