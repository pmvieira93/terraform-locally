# Purpose: Create an S3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_object" "s3_bucket_folders" {
  bucket = var.bucket_name
  for_each = {for folder in var.folders : folder => folder}
  # Folder name
  key = each.value
  # When: folder Object type
  source   = "/dev/null"

  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  # Expire objects after a certain number of days
  rule {
    id = "expire-after-days"
    expiration {
      days = var.bucket_expiration_days
    }
    status = "Enabled"
  }

  # Transition objects to Glacier after a certain number of days
  rule {
    id     = "glacier-move-expiration"
    status = "Enabled"
    filter {
      prefix = "resources/"
    }

    transition {
      days          = 15
      storage_class = "GLACIER"
    }

    expiration {
      days = var.bucket_expiration_days
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_master_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = var.versioning_status
  }
}