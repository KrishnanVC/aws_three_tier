terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-aws-three-tier-state"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  default_tags {
    tags = {
      Environment = "Dev"
      Project     = "aws_three_tier"
    }
  }
}

module "web_server" {
  source          = "./web-server"
  myip            = var.myip
  subnet_id_1     = aws_subnet.public_subnet[0].id
  subnet_id_2     = aws_subnet.public_subnet[1].id
  vpc_id          = aws_vpc.terraformVpc.id
  app_lb_sg_id    = module.app_server.app_lb_sg_id
  app_lb_dns_name = module.app_server.app_lb_dns_name
}

module "app_server" {
  source                 = "./app-server"
  myip                   = var.myip
  app_server_subnet_id_1 = aws_subnet.private_subnet[0].id
  app_server_subnet_id_2 = aws_subnet.private_subnet[1].id
  bastion_subnet_id      = aws_subnet.public_subnet[0].id
  vpc_id                 = aws_vpc.terraformVpc.id
  web_server_sg_id       = module.web_server.web_server_sg_id
  db_sg_id               = module.db.db_sg_id
}

module "db" {
  source   = "./db"
  username = var.username
  password = var.password
}
