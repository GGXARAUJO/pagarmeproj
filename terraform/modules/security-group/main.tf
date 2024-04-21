resource "aws_security_group" "flask-web-sg" {
  name        = "${var.projeto_nome}-sg"
  description = "Security Group para acesso HTTP, NFS e TCP personalizado"
  vpc_id      = var.vpc_id

  # Acesso HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite acesso HTTP"
  }

  # TCP personalizado na porta 8443
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite TCP personalizado na porta 8443"
  }

  # Acesso NFS
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite NFS"
  }

  # Regra de saída padrão: permite todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.projeto_nome}-sg"
    Version = var.resource_version
  }
}
