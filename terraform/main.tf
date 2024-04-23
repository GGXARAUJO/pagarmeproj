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
  target_group_arn    = module.ecs-nlb-target_group.tg_arn
  launch_type         = "FARGATE"
}

module "ecs_task" {
  source                = "./modules/ecs-task"
  execution_role_arn    = module.iam_ecs.ecs_execution_role_arn
  task_role_arn         = module.iam_ecs.ecs_execution_role_arn
  cpu                   = "4096"
  memory                = "8192"
  container_cpu         = 4096
  container_memory      = 8192
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

module "ecs-nlb" {
  source = "./modules/ecs-nlb"
  nlb_name                   = "flask-nlb"
  internal                   = false
  subnets                    = [module.vpc.public_subnet_id]
  enable_deletion_protection = false
  target_group_arn           = module.ecs-nlb-target_group.tg_arn
  load_balancer_arn          = module.ecs-nlb.nlb_arn
}

module "ecs-nlb-target_group" {
  source = "./modules/ecs-nlb-target-group"
  tg_name               = "flask-tg"
  port                  = 8080
  protocol              = "TCP"
  vpc_id                = module.vpc.vpc_id
  health_check_interval = 30
  healthy_threshold     = 3
  unhealthy_threshold   = 3
  target_type = "ip"
}


