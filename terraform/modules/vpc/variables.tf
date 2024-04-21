variable "projeto_nome" {
  description = "Nome do projeto para a VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block para a VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block para a subnet pública"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone para a subnet"
  type        = string
}

variable "enable_dns_support" {
  description = "Habilitar DNS supports"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Habilitar DNS hostnames"
  type        = bool
  default     = true
}

variable "resource_version" {
  description = "Versionamento dos recursos"
  default = "1.0"
}
