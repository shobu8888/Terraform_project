resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        "Action": "sts:AssumeRole"
        "Effect": "Allow"
        Sid: ""
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      },
    ]
   }     
  EOF
  }


resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.test_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        "Action": [
          "s3:*",
        ]
        "Effect": "Allow"
        "Resource": [
            "arn:aws:s3:::swap-s3-bucket-1212",
            "arn:aws:s3:::swap-s3-bucket-1212/*"
        ]
      },
    ]
  }
  EOF
}

resource "aws_iam_instance_profile" "s3-profile" {
  name = "s3-profile"
  role = aws_iam_role.test_role.name
}

