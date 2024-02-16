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

# TODO: create a security group, check is any other security restrictions need to be made
