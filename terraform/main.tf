provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "./modules/vpc"
  projeto_nome       = var.projeto_nome
  cidr_block         = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "us-east-1a"
}

module "security_group" {
  source       = "./modules/security-group"  
  vpc_id       = module.vpc.vpc_id             
  projeto_nome = var.projeto_nome
}
