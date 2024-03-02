provider "aws" {
  region = var.ENV
}
resource "aws_lb" "test" {
  name               = "elb-${var.ENV}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sec_group_elb.id]
  subnets            = [var.PUBLIC_SUBNET_1 ,var.PUBLIC_SUBNET_2]

  tags = {
    Environment = "${var.ENV}"
    Name = "elb-${var.ENV}"
  }
}


resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg-${var.ENV}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.VPC_ID
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}