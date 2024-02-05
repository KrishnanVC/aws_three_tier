# Web server
resource "aws_instance" "tf-web-server-ip" {
  instance_type          = "t2.micro"
  ami                    = "ami-0277155c3f0ab2930"
  key_name               = "web-server-keypair"
  subnet_id              = aws_subnet.public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.tf-web-server-sg.id]

  tags = {
    Name = "tf-web-server"
  }
}

resource "aws_security_group" "tf-web-server-sg" {
  name        = "web_allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.terraformVpc.id

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
  security_group_id = aws_security_group.tf-web-server-sg.id
  cidr_ipv4         = var.myip
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "web_allow_http_ipv4" {
  security_group_id            = aws_security_group.tf-web-server-sg.id
  referenced_security_group_id = aws_security_group.tf-app-server-sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

# App server
resource "aws_instance" "tf-app-server-ip" {
  instance_type          = "t2.micro"
  ami                    = "ami-0277155c3f0ab2930"
  key_name               = "web-server-keypair"
  subnet_id              = aws_subnet.private_subnet[0].id
  vpc_security_group_ids = [aws_security_group.tf-app-server-sg.id]

  tags = {
    Name = "tf-app-server"
  }
}

resource "aws_security_group" "tf-app-server-sg" {
  name        = "app_allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.terraformVpc.id

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
  referenced_security_group_id = aws_security_group.tf-web-server-sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}


# Bastion host
resource "aws_instance" "tf-bastion-ip" {
  instance_type          = "t2.micro"
  ami                    = "ami-0277155c3f0ab2930"
  key_name               = "web-server-keypair"
  subnet_id              = aws_subnet.public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.tf-bastion-sg.id]

  tags = {
    Name = "tf-bastion"
  }
}

resource "aws_security_group" "tf-bastion-sg" {
  name        = "bastion_allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.terraformVpc.id

  tags = {
    Name = "tf-bastion-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion_allow_ssh_ipv4" {
  security_group_id = aws_security_group.tf-bastion-sg.id
  cidr_ipv4         = var.myip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "bastion_allow_ssh_ipv4" {
  security_group_id            = aws_security_group.tf-bastion-sg.id
  referenced_security_group_id = aws_security_group.tf-app-server-sg.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}
