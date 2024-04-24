resource "aws_lb" "nlb" {
  name                       = var.nlb_name
  internal                   = var.internal
  load_balancer_type         = "network"
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = var.tags
}

# Primeiro Target Group
resource "aws_lb_target_group" "tg1" {
  name     = var.tg1_name
  port     = var.tg1_port
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = var.tags
}

# Segundo Target Group
resource "aws_lb_target_group" "tg2" {
  name     = var.tg2_name
  port     = var.tg2_port
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    interval            = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = var.tags
}

# Listener para o primeiro Target Group
resource "aws_lb_listener" "listener1" {
  load_balancer_arn = aws_lb.nlb.arn
  protocol          = "TCP"
  port              = var.tg1_port

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
}

# Listener para o segundo Target Group
resource "aws_lb_listener" "listener2" {
  load_balancer_arn = aws_lb.nlb.arn
  protocol          = "TCP"
  port              = var.tg2_port

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg2.arn
  }
}
