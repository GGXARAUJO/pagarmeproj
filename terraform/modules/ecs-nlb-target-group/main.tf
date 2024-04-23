resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = var.port
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip"
  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    interval            = var.health_check_interval
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

  tags = var.tags
}
