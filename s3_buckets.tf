resource "aws_s3_bucket" "create_s3_bucket" {
  bucket = "weberp-${var.tenant_name}"

  tags = {
    Name        = "project"
    Environment = "weberp"
  }
}
