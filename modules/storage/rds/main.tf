data "aws_iam_policy_document" "rds_assume_policy" {
  statement {
    actions = ["sts.AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rds_role" {
  name               = "rds_role"
  assume_role_policy = data.aws_iam_policy_document.rds_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "name" {
  role       = aws_iam_role.rds_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_db_instance" "orto_db_instance" {
  allocated_storage    = 20
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  skip_final_snapshot  = true
  username             = var.db_instance_username
  password             = var.db_instance_password
  parameter_group_name = "default.mysql8.0"
}
