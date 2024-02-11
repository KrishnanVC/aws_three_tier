resource "aws_lb" "tf_load_balancer" {
  name               = "tf-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf_lb_sg.id]
  subnets            = [var.subnet_id_1, var.subnet_id_2]

  tags = {
    Name = "tf_lb"
  }
}

resource "aws_lb_listener" "tf_load_balancer_listerner" {
  load_balancer_arn = aws_lb.tf_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_target_group.arn
  }
}

resource "aws_lb_target_group" "tf_target_group" {
  name     = "tf-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_security_group" "tf_lb_sg" {
  name        = "web_allow_http"
  description = "Allow HTTP inbound and outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "tf-lb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_http_ipv4" {
  security_group_id = aws_security_group.tf_lb_sg.id
  cidr_ipv4         = var.myip
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "lb_allow_http_ipv4" {
  security_group_id            = aws_security_group.tf_lb_sg.id
  referenced_security_group_id = aws_security_group.tf-web-server-sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}
