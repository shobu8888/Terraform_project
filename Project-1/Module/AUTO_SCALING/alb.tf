provider "aws" {
    region = var.AWS_REGION
}

resource "aws_key_pair" "public_key_pair" {
  key_name = "public_key_pair"
  public_key = file(var.public_key_path)
}

resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "launch-config-${var.ENV}"
  image_id      = lookup(var.AMIS,var.AWS_REGION)
  instance_type = var.INS_TYPE
  key_name = aws_key_pair.public_key_pair.key_name
  security_groups = [ aws_security_group.sec_group_ins.id ]
  

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "bar" {
  name                      = "as-${var.ENV}"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.as_conf.id
  vpc_zone_identifier       = [var.PUBLIC_SUBNET_1 ,var.PUBLIC_SUBNET_2]
  target_group_arns = [aws_lb_target_group.test.arn]


  tag {
    key                 = "auto_scal-grp"
    value               = "${var.ENV}"
    propagate_at_launch = true
  }
}


resource "aws_security_group" "sec_group_elb" {
  name        = "sec_group_elb"
  description = "open internet communication to elb"
  vpc_id      =  var.VPC_ID

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sec-grp-elb-${var.ENV}"
  }
}


resource "aws_security_group" "sec_group_ins" {
  name        = "sec_group_ins"
  description = "open internet communication to elb"
  vpc_id      =  var.VPC_ID

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
    security_groups = [aws_security_group.sec_group_elb.id]
  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sec-grp-ins-${var.ENV}"
  }
}