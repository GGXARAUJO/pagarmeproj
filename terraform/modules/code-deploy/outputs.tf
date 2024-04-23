output "codedeploy_application_name" {
  value       = aws_codedeploy_app.ecs_app.name
  description = "O nome da aplicação CodeDeploy criada."
}

output "codedeploy_deployment_group_name" {
  value       = aws_codedeploy_deployment_group.deployment_group.deployment_group_name
  description = "O nome do grupo de deployment criado."
}
