resource "aws_key_pair" "pub_key_pair" {
    key_name = "pub_key_pair"
    public_key = file(var.public-key-path)
}


resource "aws_launch_template" "launch_temp" {
    name = "launch_temp"
    instance_type = "t2.micro"
    image_id = lookup(var.AMIS,var.AWS_REGION)
    key_name = aws_key_pair.pub_key_pair.key_name
    vpc_security_group_ids = ["${aws_security_group.levelup-instance.id}"]
    user_data       = filebase64("ud-data.sh")
    lifecycle {
    create_before_destroy = true
    }    

}

resource "aws_autoscaling_group" "auto_grp" {
  name                      = "auto_grp"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 200
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  target_group_arns = [ "${aws_lb_target_group.test.arn}" ]
  launch_template {
    id = aws_launch_template.launch_temp.id
  }
  
  vpc_zone_identifier = [aws_subnet.public1.id, aws_subnet.public2.id]
  


  tag {
    key                 = "name"
    value               = "custom ec2"
    propagate_at_launch = true
  }
}

# resource "aws_autoscaling_policy" "auto_pol_up" {
#   name                   = "auto_pol_up"
#   scaling_adjustment     = 1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 200
#   autoscaling_group_name = aws_autoscaling_group.auto_grp.name
#   policy_type = "SimpleScaling"
# }

# resource "aws_cloudwatch_metric_alarm" "up_alarm" {
#   alarm_name          = "up_alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 2
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = 30
#   statistic           = "Average"
#   threshold           = 40

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.auto_grp.name
#   }

#   alarm_description = "This metric monitors ec2 cpu utilization"
#   actions_enabled = true
#   alarm_actions     = [aws_autoscaling_policy.auto_pol_up.arn]
# }


# resource "aws_autoscaling_policy" "auto_pol_down" {
#   name                   = "auto_pol_down"
#   scaling_adjustment     = -1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 200
#   autoscaling_group_name = aws_autoscaling_group.auto_grp.name
#   policy_type = "SimpleScaling"
# }

# resource "aws_cloudwatch_metric_alarm" "dowm_alarm" {
#   alarm_name          = "down_alarm"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = 2
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = 30
#   statistic           = "Average"
#   threshold           = 20

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.auto_grp.name
#   }

#   alarm_description = "This metric monitors ec2 cpu utilization"
#   actions_enabled = true
#   alarm_actions     = [aws_autoscaling_policy.auto_pol_down.arn]
# }