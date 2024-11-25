resource "aws_s3_bucket" "my-example-bucket-uvais-tf" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}