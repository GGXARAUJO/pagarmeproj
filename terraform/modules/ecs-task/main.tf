resource "aws_ecs_task_definition" "task" {
  family                   = "flask"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.execution_role_arn
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name             = "flask-container",
      image            = "ggxaraujo/flask-web-escultura:prod",
      cpu              = var.container_cpu,
      memory           = var.container_memory,
      essential        = true,
      portMappings = [
        {
          containerPort = 8080,
          hostPort      = 8080,
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name  = "FLASK_RUN_PORT",
          value = "8080"
        },
        {
          name  = "FLASK_RUN_HOST",
          value = "0.0.0.0"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options   = {
          awslogs-group         = "/ecs/${var.projeto_nome}",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
