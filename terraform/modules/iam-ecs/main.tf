resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsExecutionRole-${var.projeto_nome}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole",
      },
    ],
  })
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name = "/ecs/${var.projeto_nome}"

  retention_in_days = 90

  tags = {
    Name = "ECS Logs para ${var.projeto_nome}"
  }
}

resource "aws_iam_policy" "ecs_logs_policy" {
  name        = "ecsLogsPolicy-${var.projeto_nome}"
  path        = "/"
  description = "Permite que as tarefas do ECS enviem logs para o CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "${aws_cloudwatch_log_group.ecs_logs.arn}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_logs_policy_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_logs_policy.arn
}
