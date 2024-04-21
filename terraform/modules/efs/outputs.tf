output "efs_id" {
  description = "O ID do EFS criado"
  value       = aws_efs_file_system.efs.id
}

output "efs_arn" {
  description = "O arn EFS criado"
  value       = aws_efs_file_system.efs.arn
}

output "mount_target_id" {
  description = "O id do ponto de montagem do EFS"
  value       = aws_efs_mount_target.efs_mt.id
}
