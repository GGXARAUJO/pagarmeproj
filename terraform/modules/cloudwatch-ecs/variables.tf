variable "projeto_nome" {
  type        = string
  description = "Nome do projeto usado nos recursos."
}

variable "cluster_name" {
  type        = string
  description = "Nome do cluster ECS para monitoramento."
}

variable "alert_email_address" {
  type        = string
  description = "Endereço de email para receber alertas."
}

variable "log_retention_days" {
  type        = number
  default     = 14
  description = "Número de dias para retenção dos logs."
}
