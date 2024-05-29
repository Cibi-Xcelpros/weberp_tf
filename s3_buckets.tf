provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "create_s3_bucket" {
  bucket = "weberp-${var.tenant_name}"

  tags = {
    Name        = "project"
    Environment = "weberp"
  }
}
