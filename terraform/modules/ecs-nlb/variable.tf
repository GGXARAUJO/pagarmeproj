variable "nlb_name" {
  description = "The name of the Network Load Balancer"
  type        = string
}

variable "internal" {
  description = "Indicates if the NLB is internal"
  type        = bool
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the NLB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Indicates if deletion protection is enabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "listener_port" {
  description = "The port on which the load balancer will listen for incoming traffic."
  type        = number
  default     = 8443
}

variable "target_group_arn" {
  description = "The port on which the load balancer will listen for incoming traffic."
  type        = string
}

variable "load_balancer_arn" {
  description = "The ARN of the load balancer."
  type        = string
}