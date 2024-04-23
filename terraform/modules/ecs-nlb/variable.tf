variable "nlb_name" {
  description = "O nome do Network Load Balancer"
  type        = string
}

variable "internal" {
  description = "Indica se o NLB é interno"
  type        = bool
}

variable "subnets" {
  description = "Lista de IDs de subnets para associar ao NLB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Indica se a proteção contra exclusão está ativada"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Mapeamento de tags para atribuir ao recurso"
  type        = map(string)
  default     = {}
}

variable "listener_port" {
  description = "Porta na qual o load balancer escutará o tráfego de entrada"
  type        = number
  default     = 8443
}

variable "vpc_id" {
  description = "Identificador da VPC na qual criar o target group"
  type        = string
}

variable "tg1_name" {
  description = "Nome do primeiro target group"
  type        = string
}

variable "tg1_port" {
  description = "Porta na qual o primeiro target group receberá tráfego"
  type        = number
}

variable "tg2_name" {
  description = "Nome do segundo target group"
  type        = string
}

variable "tg2_port" {
  description = "Porta na qual o segundo target group receberá tráfego"
  type        = number
}

variable "health_check_interval" {
  description = "Intervalo entre os health checks do target group"
  type        = number
  default     = 30
}

variable "healthy_threshold" {
  description = "Número de sucessos consecutivos nos health checks necessários para considerar um target inicialmente não saudável como saudável"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Número de falhas consecutivas nos health checks necessárias para considerar um target como não saudável"
  type        = number
  default     = 3
}

variable "target_type" {
  description = "Tipo de target que deve ser especificado ao registrar targets com este target group"
  type        = string
  default     = "ip"
}
