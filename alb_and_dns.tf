# ALB for Strapi
resource "aws_lb" "strapi" {
  name               = "strapi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "strapi" {
  name        = "strapi-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "strapi" {
  load_balancer_arn = aws_lb.strapi.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi.arn
  }
}

# ALB for React
resource "aws_lb" "react" {
  name               = "react-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_target_group" "react" {
  name        = "react-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "react" {
  load_balancer_arn = aws_lb.react.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.react.arn
  }
}

resource "aws_route53_record" "strapi" {
  zone_id = var.route53_zone_id
  name    = var.strapi_subdomain
  type    = "A"

  alias {
    name                   = aws_lb.strapi.dns_name
    zone_id                = aws_lb.strapi.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "react" {
  zone_id = var.route53_zone_id
  name    = var.react_subdomain
  type    = "A"

  alias {
    name                   = aws_lb.react.dns_name
    zone_id                = aws_lb.react.zone_id
    evaluate_target_health = false
  }
}
