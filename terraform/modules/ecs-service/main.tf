resource "aws_ecs_service" "nifi_service" {
  name            = "${var.service_name}-service"
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  depends_on = [var.task_definition_arn]

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition
    ]
  }


}
