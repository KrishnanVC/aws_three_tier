resource "aws_launch_template" "tf_launch_template" {
  name_prefix            = "tf_launch_template"
  vpc_security_group_ids = [aws_security_group.tf-web-server-sg.id]
  key_name               = "web-server-keypair"
  image_id               = "ami-0277155c3f0ab2930"
  instance_type          = "t2.micro"
  user_data              = <<EOF
    #!/bin/bash
    cd ~
    curl -o index.html http://${aws_lb.tf_app_load_balancer.dns_name}
    python3 -m http.server 80
  EOF
}

resource "aws_security_group" "tf-web-server-sg" {
  name        = "web_allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "tf-web-server-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_allow_ssh_ipv4" {
  security_group_id = aws_security_group.tf-web-server-sg.id
  cidr_ipv4         = var.myip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "web_allow_http_ipv4" {
  security_group_id            = aws_security_group.tf-web-server-sg.id
  referenced_security_group_id = aws_security_group.tf_lb_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "web_allow_http_ipv4" {
  security_group_id            = aws_security_group.tf-web-server-sg.id
  referenced_security_group_id = var.app_server_sg_id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}
