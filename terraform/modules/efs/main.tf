resource "aws_efs_file_system" "efs" {
  creation_token = "efs-ecs-flask"

  tags = {
    Name = "${var.efs_nome}-efs"
    Version = var.resource_version
  }

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

resource "aws_efs_mount_target" "efs_mt" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]

  
}
