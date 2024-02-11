resource "aws_placement_group" "tf_placement_group" {
  name     = "tf_placement_group"
  strategy = "spread"
}

resource "aws_autoscaling_group" "tf_asg" {
  name                      = "terraform_auto_scaling_group"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  placement_group           = aws_placement_group.tf_placement_group.id
  vpc_zone_identifier       = [var.subnet_id_1, var.subnet_id_2]
  launch_template {
    id      = aws_launch_template.tf_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "tf_instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "tf_autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.tf_asg.id
  lb_target_group_arn    = aws_lb_target_group.tf_target_group.arn
}
