variable "application_name" {
  type        = string
  description = "O nome da aplicação CodeDeploy."
}

variable "deployment_group_name" {
  type        = string
  description = "O nome do grupo de deployment do CodeDeploy."
}

variable "service_role_arn" {
  type        = string
  description = "O ARN da função IAM que o CodeDeploy usa para realizar ações."
}

variable "deployment_config_name" {
  type        = string
  description = "O nome da configuração de deployment."
  default     = "CodeDeployDefault.ECSAllAtOnce"
}

variable "cluster_name" {
  type        = string
  description = "O nome do cluster ECS."
}

variable "service_name" {
  type        = string
  description = "O nome do serviço ECS."
}

variable "target_group_name" {
  type        = string
  description = "O nome do Target Group."
}

variable "prod_listener_arn" {
  description = "The ARN of the production listener in the load balancer"
  type        = string
}

variable "test_listener_arn" {
  description = "The ARN of the test listener in the load balancer"
  type        = string
}

variable "second_target_group_name" {
  description = "The name of the second target group associated with the load balancer"
  type        = string
}

