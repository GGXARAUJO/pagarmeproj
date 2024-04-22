output "sns_topic_arn" {
  value       = aws_sns_topic.ecs_alerts_topic.arn
  description = "ARN do tópico SNS para alertas do ECS."
}

output "event_rule_name" {
  value       = aws_cloudwatch_event_rule.ecs_task_stopped.name
  description = "Nome da regra do EventBridge para captura de tarefas ECS interrompidas."
}