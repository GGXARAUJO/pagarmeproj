output "cluster_id" {
  description = "O id do ECS Cluster"
  value       = aws_ecs_cluster.cluster.id
}

output "cluster_arn" {
  description = "A arn do ECS Cluster"
  value       = aws_ecs_cluster.cluster.arn
}
