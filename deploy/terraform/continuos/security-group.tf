resource "aws_security_group" "ecs_sg" {
  name        = "ecs_sg"
  description = "Allow HTTP traffic to ECS tasks"
  vpc_id      = "vpc-xxxxxxx"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
