data "archive_file" "py_lambda" {
  type        = "zip"
  source_dir  = "../src/python"
  output_path = "${path.module}/pedro_py_lambda.zip"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}