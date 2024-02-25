resource "aws_s3_bucket" "s3-create" {
  bucket = "swap-s3-bucket-1212"
  acl = "private"

  tags = {
    Name        = "swap-s3-bucket-1212"
  }
}