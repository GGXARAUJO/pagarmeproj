resource "aws_s3_bucket" "ecs_s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = "Bucket para tarefas do ECS"
  }
}

resource "aws_iam_policy" "ecs_s3_access" {
  name        = "ecs-s3-access-${var.bucket_name}"
  path        = "/"
  description = "Permite acesso ao bucket S3 para a tarefa do ECS."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.ecs_s3_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_s3_policy_attachment" {
  role       = var.ecs_task_execution_role_name
  policy_arn = aws_iam_policy.ecs_s3_access.arn
}
