resource "aws_ecs_cluster" "main" {
  name = "main-cluster"
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi.arn
    container_name   = "strapi"
    container_port   = 1337
  }

  depends_on = [aws_lb_listener.strapi]
}

resource "aws_ecs_service" "react" {
  name            = "react"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.react.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.react.arn
    container_name   = "react"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.react]
}
