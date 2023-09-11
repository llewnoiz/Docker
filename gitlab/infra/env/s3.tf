# S3 bucket for backend
resource "aws_s3_bucket" "tfstate" {
  bucket = local.tfstate

  versioning {
    enabled = true # Prevent from deleting tfstate file
  }

  tags = local.tags
}
