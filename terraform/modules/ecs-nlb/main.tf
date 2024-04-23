resource "aws_lb" "nlb" {
  name               = var.nlb_name
  internal           = var.internal
  load_balancer_type = "network"
  subnets            = var.subnets

  enable_deletion_protection = var.enable_deletion_protection

  tags = var.tags
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = var.load_balancer_arn
  protocol          = "TCP"
  port              = var.listener_port

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}
