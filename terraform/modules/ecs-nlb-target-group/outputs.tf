output "tg_arn" {
  description = "The ARN of the Target Group"
  value       = aws_lb_target_group.tg.arn
}
