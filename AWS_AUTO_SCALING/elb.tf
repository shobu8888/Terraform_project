resource "aws_lb" "app_elb" {
  name               = "app_elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.levelup-elb-securitygroup.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app_elb.arn
  port              = "80"
  protocol          = "HTTP"

   default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.local-vpc.id

    health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    port                = "80"
    protocol = "HTTP"
    interval            = 30
  }

  load_balancing_cross_zone_enabled   = true
  target_health_state {
    enable_unhealthy_connection_termination = true
  }


}


#Security group for AWS ELB
resource "aws_security_group" "levelup-elb-securitygroup" {
  vpc_id      = aws_vpc.local-vpc.id
  name        = "levelup-elb-sg"
  description = "security group for Elastic Load Balancer"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "levelup-elb-sg"
  }
}

#Security group for the Instances
resource "aws_security_group" "levelup-instance" {
  vpc_id      = aws_vpc.local-vpc.id
  name        = "levelup-instance"
  description = "security group for instances"
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.levelup-elb-securitygroup.id]
  }

  tags = {
    Name = "levelup-instance"
  }
}