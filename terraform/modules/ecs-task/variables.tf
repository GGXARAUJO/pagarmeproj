variable "projeto_nome" {
  description = "Nome do projeto ecs"
  type        = string
}

variable "execution_role_arn" {
  description = "O ARN da função IAM que a função de execução da tarefa assume."
  type        = string
}

variable "efs_file_system_id" {
  description = "O ID do sistema de arquivos EFS."
  type        = string
}

variable "cpu" {
  description = "A quantidade de CPU a ser atribuída à tarefa."
  type        = string
}

variable "memory" {
  description = "A quantidade de memória (em MiB) a ser atribuída à tarefa."
  type        = string
}

variable "container_cpu" {
  description = "A quantidade de CPU a ser atribuída ao contêiner."
  type        = number
}

variable "container_memory" {
  description = "A quantidade de memória (em MiB) a ser atribuída ao contêiner."
  type        = number
}

variable "container_port" {
  description = "A porta do contêiner"
  type        = number
}

variable "image" {
  description = "A imagem Docker a ser usada para o contêiner."
  type        = string
}

variable "environment_variables" {
  description = "Uma lista de variáveis de ambiente para passar ao contêiner."
  type        = list(object({ name = string, value = string }))
  default     = []
}

variable "mount_points" {
  description = "Os pontos de montagem de volume para o contêiner."
  type        = list(object({
    sourceVolume  = string
    containerPath = string
    readOnly      = bool
  }))
  default     = []
}

variable "task_role_arn" {
  description = "O ARN da função IAM que a tarefa pode assumir."
  type        = string
  default     = ""
}
