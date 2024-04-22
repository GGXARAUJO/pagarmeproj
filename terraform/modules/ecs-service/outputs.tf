output "service_id" {
  description = "O ID do serviço ECS"
  value       = aws_ecs_service.flask_service.id
}

output "service_name" {
  description = "O nome do serviço ECS"
  value       = aws_ecs_service.flask_service.name
}
