resource "aws_iam_role" "this" {
  name               = "jenkins-role"
  assume_role_policy = <<EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": "sts:AssumeRole",
              "Principal": {
                 "Service": "ec2.amazonaws.com"
              },
              "Effect": "Allow",
              "Sid": ""
          }
      ]
  }
  EOF
}

resource "aws_iam_instance_profile" "this" {
  name = "jenkins-profile"
  role = aws_iam_role.this.name
}

resource "aws_launch_template" "this" {
  name          = var.name
  image_id      = var.ami
  instance_type = var.instance_type
  block_device_mappings {
    device_name = "/dev/sdf"
    ebs {
      volume_size = 20
    }
  }
  ebs_optimized = true
  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }
  # vpc_security_group_ids = var.vpc_sg_id
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.sg
  }
  # key_name  = aws_key_pair.this.key_name
  user_data = filebase64("${path.module}/install.sh")
}

resource "aws_autoscaling_group" "this" {
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  # availability_zones  = var.az
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = [var.public_subnet]
  tag {
    key                 = "Name"
    value               = "jenkins instance"
    propagate_at_launch = true
  }
}
