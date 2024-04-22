output "task_definition_arn" {
  description = "O ARN completo da definição da tarefa (incluindo tanto a família quanto a revisão)."
  value       = aws_ecs_task_definition.task.arn
}

output "task_role_arn" {
  description = "O ARN da função IAM que a tarefa pode assumir."
  value       = var.task_role_arn
}
