resource "aws_lb" "tf_app_load_balancer" {
  name               = "tf-app-load-balancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf_app_lb_sg.id]
  subnets            = [var.app_server_subnet_id_1, var.app_server_subnet_id_2]

  tags = {
    Name = "tf_lb"
  }
}

resource "aws_lb_listener" "tf_app_load_balancer_listerner" {
  load_balancer_arn = aws_lb.tf_app_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_app_target_group.arn
  }
}

resource "aws_lb_target_group" "tf_app_target_group" {
  name     = "tf-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_security_group" "tf_app_lb_sg" {
  name        = "app_allow_http"
  description = "Allow HTTP inbound and outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "tf-app-lb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_lb_allow_http_ipv4" {
  security_group_id = aws_security_group.tf_app_lb_sg.id
  cidr_ipv4         = var.web_server_sg_id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "app_lb_allow_http_ipv4" {
  security_group_id            = aws_security_group.tf_app_lb_sg.id
  referenced_security_group_id = aws_security_group.tf-app-server-sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}
