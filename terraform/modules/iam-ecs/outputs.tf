output "ecs_execution_role_arn" {
  description = "O ARN do ECS task execution role."
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_execution_role_name" {
  description = "O nome do ECS task execution role."
  value       = aws_iam_role.ecs_execution_role.name
}
