# Create Launch Configuration
	
resource "aws_launch_configuration" "project-9" {
  name_prefix   = "project-9"
  image_id      = "ami-04902260ca3d33422"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.SG-HTTP.id]
  lifecycle {
    create_before_destroy = true
  }
}

# Create DFSC FrontEnd ASG

resource "aws_autoscaling_group" "My-ASG" {
  name                      = "My-ASG"
  launch_configuration      = aws_launch_configuration.project-9.name
  health_check_type         = "ELB"
  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 3
  health_check_grace_period = 300
  vpc_zone_identifier = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]
  target_group_arns = [aws_lb_target_group.project-9-TG.arn]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "projet-9_ASG"
    propagate_at_launch = true  
  }
}
