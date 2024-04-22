variable "bucket_name" {
  type        = string
  description = "O nome do bucket S3 a ser criado."
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "O nome da role de execução da tarefa ECS que receberá a política de acesso ao S3."
}
