resource "aws_instance" "tf-bastion-ip" {
  instance_type          = "t2.micro"
  ami                    = "ami-0277155c3f0ab2930"
  key_name               = "web-server-keypair"
  subnet_id              = var.bastion_subnet_id
  vpc_security_group_ids = [aws_security_group.tf-bastion-sg.id]

  tags = {
    Name = "tf-bastion"
  }
}

resource "aws_security_group" "tf-bastion-sg" {
  name        = "bastion_allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

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
