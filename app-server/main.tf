resource "aws_launch_template" "tf_app_launch_template" {
  name_prefix            = "tf_app_launch_template"
  vpc_security_group_ids = [aws_security_group.tf-app-server-sg.id]
  image_id               = "ami-0277155c3f0ab2930"
  instance_type          = "t2.micro"
}

resource "aws_security_group" "tf-app-server-sg" {
  name        = "app_allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "tf-app-server-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_allow_ssh_ipv4" {
  security_group_id            = aws_security_group.tf-app-server-sg.id
  referenced_security_group_id = aws_security_group.tf-bastion-sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "app_allow_http_ipv4" {
  security_group_id            = aws_security_group.tf-app-server-sg.id
  referenced_security_group_id = aws_security_group.tf_app_lb_sg
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}
