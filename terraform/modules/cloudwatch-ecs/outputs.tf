output "sns_topic_arn" {
  value       = aws_sns_topic.ecs_alerts_topic.arn
  description = "ARN do tópico SNS para alertas do ECS."
}
