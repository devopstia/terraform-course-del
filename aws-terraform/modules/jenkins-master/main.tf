resource "aws_launch_template" "jenkins_launch_template" {
  depends_on             = [aws_iam_role.example_role]
  name                   = format("%s-%s-jenkins-launch-template", var.common_tags["project"], var.common_tags["environment"])
  image_id               = var.use_custom_ami ? var.image_id : data.aws_ami.ubuntu.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  # This is not working with the launch template
  # user_data = var.enable_user_data ? file("${path.module}/install_jenkins.sh") : null
  user_data = var.enable_user_data ? base64encode(file("${path.module}/install_jenkins.sh")) : null

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = var.volume_size
      volume_type = "gp3"
    }
  }
  iam_instance_profile {
    name = var.jenkins-role-name
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = format("%s-%s-jenkins-master", var.common_tags["project"], var.common_tags["environment"])
    }
  }
  tags = merge(var.common_tags, {
    Name = format("%s-%s-jenkins-launch-template", var.common_tags["project"], var.common_tags["environment"])
    },
  )
}

resource "aws_lb_target_group" "jenkins_lb_target_group" {
  name     = format("%s-%s-jenkins-target-group", var.common_tags["project"], var.common_tags["environment"])
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-jenkins-lb-target-group", var.common_tags["project"], var.common_tags["environment"])
    },
  )
}

resource "aws_autoscaling_group" "jenkins_autoscaling_group" {
  depends_on = [
    aws_launch_template.jenkins_launch_template,
    aws_iam_role.example_role
  ]
  name     = format("%s-%s-jenkins-autoscaling-group", var.common_tags["project"], var.common_tags["environment"])
  min_size = var.min_size
  max_size = var.max_size

  health_check_type = "EC2"

  vpc_zone_identifier = values(var.private_subnets)

  target_group_arns = [aws_lb_target_group.jenkins_lb_target_group.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.jenkins_launch_template.id
      }
      override {
        instance_type = var.instance_type
      }
    }
  }
}

resource "aws_autoscaling_policy" "jenkins_autoscaling_policy" {
  name                   = format("%s-%s-jenkins-autoscaling-policy", var.common_tags["project"], var.common_tags["environment"])
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.jenkins_autoscaling_group.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 25.0
  }
}

resource "aws_lb" "jenkins_aws_lb" {
  name               = format("%s-%s-jenkins-aws-lb", var.common_tags["project"], var.common_tags["environment"])
  internal           = var.internal-elb
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.alb_sg.id]

  subnets = values(var.public_subnets)
  tags = merge(var.common_tags, {
    Name = format("%s-%s-jenkins-aws-lb", var.common_tags["project"], var.common_tags["environment"])
    },
  )
}

# Create a record set for the subdomain jenkins.
resource "aws_route53_record" "subdomain" {
  zone_id = data.aws_route53_zone.example_zone.id
  name    = var.subdomain_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.jenkins_aws_lb.dns_name]
}

resource "aws_lb_listener" "jenkins_launch_template_tls" {
  load_balancer_arn = aws_lb.jenkins_aws_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.devopseasylearning.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_lb_target_group.arn
  }
}

resource "aws_lb_listener" "jenkins_launch_template" {
  load_balancer_arn = aws_lb.jenkins_aws_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
