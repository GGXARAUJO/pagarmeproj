resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_nome}-cluster"
}
