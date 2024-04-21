variable "projeto_nome" {
  description = "Nome do projeto para a VPC"
  type        = string
}

variable "vpc_id" {
  type        = string
  description = "O ID da VPC onde o Security Group será criado"
}

variable "resource_version" {
  description = "Versionamento dos recursos"
  default = "1.0"
}