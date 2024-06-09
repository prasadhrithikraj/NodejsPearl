resource "aws_ecs_task_definition" "hello-world" {
  family                   = "hello-world-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn

  container_definitions = jsonencode([{
    name      = "hello-world"
    image     = "your-dockerhub-username/hello-world-nodejs"
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
    }]
  }])
}

resource "aws_ecs_cluster" "hello-world-cluster" {
  name = "hello-world-cluster"
}

resource "aws_ecs_service" "hello-world-service" {
  name            = "hello-world-service"
  cluster         = aws_ecs_cluster.hello-world-cluster.id
  task_definition = aws_ecs_task_definition.hello-world.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["subnet-xxxxxxx"]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}
