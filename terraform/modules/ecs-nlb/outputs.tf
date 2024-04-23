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

output "listener_arn" {
  description = "A ARN do listener."
  value       = aws_lb_listener.nlb_listener.arn
}