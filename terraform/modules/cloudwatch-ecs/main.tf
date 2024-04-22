# Recurso para criar um tópico SNS para alertas de email
resource "aws_sns_topic" "ecs_alerts_topic" {
  name = "ecs-alerts-topic-${var.projeto_nome}"
}

# Subscrição SNS para enviar os alertas para um endereço de email
resource "aws_sns_topic_subscription" "ecs_alerts_email" {
  topic_arn = aws_sns_topic.ecs_alerts_topic.arn
  protocol  = "email"
  endpoint  = var.alert_email_address
}

# Alarmes CloudWatch para utilização de CPU
resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  alarm_name                = "HighCPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = 75
  alarm_description         = "Alarm when CPU exceeds 75%"
  alarm_actions             = [aws_sns_topic.ecs_alerts_topic.arn]
  dimensions = {
    ClusterName = var.cluster_name
  }
}

# Alarmes CloudWatch para utilização de memória
resource "aws_cloudwatch_metric_alarm" "high_memory_utilization" {
  alarm_name                = "HighMemoryUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = 75
  alarm_description         = "Alarm when memory exceeds 75%"
  alarm_actions             = [aws_sns_topic.ecs_alerts_topic.arn]
  dimensions = {
    ClusterName = var.cluster_name
  }
}
