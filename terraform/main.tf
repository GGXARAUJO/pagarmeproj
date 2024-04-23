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

module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
  cluster_nome = var.projeto_nome
}

module "iam_ecs" {
  source    = "./modules/iam-ecs"
  projeto_nome = var.projeto_nome
}

module "ecs_service" {
  source              = "./modules/ecs-service"
  service_name        = var.projeto_nome
  cluster_id          = module.ecs_cluster.cluster_id
  task_definition_arn = module.ecs_task.task_definition_arn
  desired_count       = 1
  subnets             = [module.vpc.public_subnet_id] 
  security_groups     = [module.security_group.security_group_id]
  assign_public_ip    = true
  container_name      = "flask-container"
  container_port      = 8080
  target_group_arn    = module.ecs_nlb.tg1_arn
  launch_type         = "FARGATE"
}

module "ecs_task" {
  source                = "./modules/ecs-task"
  execution_role_arn    = module.iam_ecs.ecs_execution_role_arn
  task_role_arn         = module.iam_ecs.ecs_execution_role_arn
  cpu                   = "2048"
  memory                = "4096"
  container_cpu         = 2048
  container_memory      = 4096
  container_port        = 8080
  image                 = "ggxaraujo/flask-web-escultura:prod"
  projeto_nome          = var.projeto_nome
}

module "cloudwatch_ecs" {
  source              = "./modules/cloudwatch-ecs"  
  projeto_nome        = var.projeto_nome
  cluster_name        = module.ecs_cluster.cluster_name
  cluster_arn         = module.ecs_cluster.cluster_arn
  service_name        = module.ecs_service.service_name
  alert_email_address = "ggxaraujo@gmail.com"
  log_retention_days  = 30
}

module "ecs_nlb" {
  source = "./modules/ecs-nlb"  

  nlb_name                   = "flask-nlb"
  internal                   = false
  subnets                    = [module.vpc.public_subnet_id]
  enable_deletion_protection = false
  tags                       = {
    Environment = "production"
  }

  # Configurações para o primeiro Target Group
  tg1_name   = "flask-tg1"
  tg1_port   = 8443
  # Configurações para o segundo Target Group
  tg2_name   = "flask-tg2"
  tg2_port   = 8080
  vpc_id = module.vpc.vpc_id  
}

module "code_deploy" {
  source                      = "./modules/code-deploy"  
  application_name            = "flask-application"
  deployment_group_name       = "flask-deployment-group"
  deployment_config_name      = "CodeDeployDefault.ECSAllAtOnce"
  cluster_name                = module.ecs_cluster.cluster_name         
  service_name                = module.ecs_service.service_name        
  target_group_name           = module.ecs_nlb.tg1_name
  second_target_group_name = module.ecs_nlb.tg2_name
  prod_listener_arn           = module.ecs_nlb.prod_listener_arn
  test_listener_arn           = module.ecs_nlb.test_listener_arn
  service_role_arn =  module.iam_ecs.ecs_execution_role_arn
}


