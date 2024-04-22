resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsExecutionRole-${projeto_nome}"

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

resource "aws_iam_policy" "ecs_efs_access_policy" {
  name        = "ecsEFSAccessPolicy-${projeto_nome}"
  description = "Permite acesso ao EFS para ECS Tasks"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:DescribeFileSystems",
        ],
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ecs_efs_access" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_efs_access_policy.arn
}

resource "aws_iam_policy" "ecs_logs_policy" {
  name        = "ecsLogsPolicy-${projeto_nome}"
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
        Resource = [
          "arn:aws:logs:us-east-1:084268841007:log-group:/ecs/nifi:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_logs_policy_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = aws_iam_policy.ecs_logs_policy.arn
}

