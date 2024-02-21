terraform {
  backend "s3" {
    bucket = "tf-sachin"
    key = "dev/tf-state"
    region = "us-east-1"
  }
}