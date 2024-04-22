variable "service_name" {
  description = "O nome do serviço ECS"
  type        = string
}

variable "cluster_id" {
  description = "O ID do cluster ECS onde o serviço será implantado"
  type        = string
}

variable "task_definition_arn" {
  description = "O ARN da definição de tarefa a ser usada com o serviço"
  type        = string
}

variable "desired_count" {
  description = "O número de instâncias da definição de tarefa para posicionar e manter em execução"
  type        = number
}

variable "subnets" {
  description = "As subnets associadas à tarefa ou serviço"
  type        = list(string)
}

variable "security_groups" {
  description = "Os grupos de segurança associados à tarefa ou serviço"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Atribuir um IP público à ENI (somente Fargate)"
  type        = bool
  default     = false
}

variable "container_name" {
  description = "O nome do contêiner a ser usado com o balanceador de carga"
  type        = string
}

variable "launch_type" {
  description = "O tipo de lançamento do serviço ECS (EC2 ou Fargate)"
  type        = string
}

variable "container_port" {
  description = "A porta no contêiner a ser associada ao balanceador de carga"
  type        = number
}
