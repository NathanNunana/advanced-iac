data "aws_ami" "icon_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210813.0-x86_64-gp2"]
  }
}

resource "aws_instance" "icon" {
  ami                    = data.aws_ami.icon_ami.id
  instance_type          = var.instance-type
  subnet_id              = var.subnet
  vpc_security_group_ids = var.vpc-sg-id
  tags                   = var.tag
}
