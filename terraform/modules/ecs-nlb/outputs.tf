output "nlb_arn" {
  description = "A ARN do Network Load Balancer"
  value       = aws_lb.nlb.arn
}

output "nlb_dns_name" {
  value = aws_lb.nlb.dns_name
}

output "nlb_zone_id" {
  value = aws_lb.nlb.zone_id
}

output "tg1_arn" {
  value = aws_lb_target_group.tg1.arn
  description = "ARN do primeiro target group"
}

output "tg2_arn" {
  value = aws_lb_target_group.tg2.arn
  description = "ARN do segundo target group"
}

output "tg1_name" {
  value = aws_lb_target_group.tg1.name
  description = "Name do primerio target group."
}

output "tg2_name" {
  value = aws_lb_target_group.tg2.name
  description = "Name do segundo target group."
}

output "prod_listener_arn" {
  value = aws_lb_listener.listener1.arn
  description = "ARN do listener de prod."
}

output "test_listener_arn" {
  value = aws_lb_listener.listener2.arn
  description = "ARN do test listener."
}


