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
  alarm_name                = "HighCPUUtilization-${var.service_name}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = 75
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
  alarm_actions             = [aws_sns_topic.ecs_alerts_topic.arn]
}

# Alarmes CloudWatch para utilização de memória
resource "aws_cloudwatch_metric_alarm" "high_memory_utilization" {
  alarm_name                = "HighMemoryUtilization-${var.service_name}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = 75
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }
  alarm_actions             = [aws_sns_topic.ecs_alerts_topic.arn]
}

# EventBridge Rule para capturar eventos de tarefas ECS que são interrompidas
resource "aws_cloudwatch_event_rule" "ecs_task_stopped" {
  name        = "ecs-task-stopped-${var.projeto_nome}"
  description = "Capturar ECS tasks eventos de Stopped"
  event_pattern = jsonencode({
    source     = ["aws.ecs"],
    "detail-type" = ["ECS Task State Change"],
    detail = {
      lastStatus = ["STOPPED"],
      clusterArn = [var.cluster_arn]  
    }
  })
}

# Target do EventBridge para enviar notificações para o tópico SNS
resource "aws_cloudwatch_event_target" "ecs_task_stopped_target" {
  rule      = aws_cloudwatch_event_rule.ecs_task_stopped.name
  target_id = "sendToSNS"
  arn       = aws_sns_topic.ecs_alerts_topic.arn
}

# Política SNS para permitir que o EventBridge publique no tópico
resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.ecs_alerts_topic.arn
  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "events.amazonaws.com"
      },
      Action    = "sns:Publish",
      Resource  = aws_sns_topic.ecs_alerts_topic.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_cloudwatch_event_rule.ecs_task_stopped.arn
        }
      }
    }]
  })
}