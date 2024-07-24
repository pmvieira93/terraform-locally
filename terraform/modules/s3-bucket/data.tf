# Data source for the bucket module
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowSSLRequestsOnly"
    effect    = "Deny"
    resources = [aws_s3_bucket.s3_bucket.arn]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:*"
    ]
    condition {
      test     = "Bool"
      values   = ["false"]
      variable = "aws:SecureTransport"
    }
  }

  statement {
    sid    = "DenyAccessUnknownRoles"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "ArnNotEquals"
      values   = setunion(var.allowed_principals, [])
      variable = "aws:PrincipalArn"
    }
    actions = [
      "s3:*"
    ]
    resources = [aws_s3_bucket.s3_bucket.arn]
  }
}