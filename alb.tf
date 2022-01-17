resource "aws_lb" "project-9-lb" {
  name               = "project-9-lb"
  load_balancer_type = "application"
  subnets = [
    aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-3.id
  ]

  security_groups = [aws_security_group.SG-HTTP.id]
}

resource "aws_lb_target_group" "project-9-TG" {
  name        = "project-9-TG"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.project-9-vpc.id
  target_type = "instance" 
  port        = 80

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "project-9" {
  load_balancer_arn = aws_lb.project-9-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project-9-TG.arn
  }
}

resource "aws_security_group" "SG-LB" {
  description = "Allow access to Application Load Balancer"
  name        = "local.prefix"
  vpc_id      = aws_vpc.project-9-vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}
