variable "efs_nome" {
  description = "O nome do EFS"
  type        = string
}

variable "subnet_id" {
  description = "O ID da subnet que será usada na criaçao do EFS"
  type        = string
}

variable "security_group_id" {
  description = "O ID do security group que será usado na criaçao do EFS"
  type        = string
}

variable "resource_version" {
  description = "Versionamento dos recursos"
  default = "1.0"
}