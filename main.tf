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

module "web_server" {
  source           = "./web-server"
  myip             = var.myip
  subnet_id        = aws_subnet.public_subnet[0].id
  vpc_id           = aws_vpc.terraformVpc.id
  app_server_sg_id = module.app_server.app_server_sg_id
}

module "app_server" {
  source               = "./app-server"
  myip                 = var.myip
  app_server_subnet_id = aws_subnet.private_subnet[0].id
  bastion_subnet_id    = aws_subnet.public_subnet[0].id
  vpc_id               = aws_vpc.terraformVpc.id
  web_server_sg_id     = module.web_server.web_server_sg_id
}
