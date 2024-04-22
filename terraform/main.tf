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

module "efs" {
  source            = "./modules/efs"
  efs_nome          = var.projeto_nome
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
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
  container_name      = var.projeto_nome
  container_port      = 8080
  launch_type         = "FARGATE"
}

module "ecs_task" {
  source                = "./modules/ecs-task"
  efs_file_system_id    = module.efs.efs_id
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

