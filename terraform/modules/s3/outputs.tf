output "s3_bucket_name" {
  value       = aws_s3_bucket.ecs_s3_bucket.bucket
  description = "O nome do bucket S3 criado."
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.ecs_s3_bucket.arn
  description = "O ARN do bucket S3 criado."
}

output "iam_policy_arn" {
  value       = aws_iam_policy.ecs_s3_access.arn
  description = "O ARN da política IAM que permite acesso ao S3."
}
