data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts.AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_role" {
  name               = "eks_role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  role       = aws_iam_role.eks_role
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
