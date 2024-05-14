resource "aws_sqs_queue" "queue" {
  name                      = var.queue_name
  message_retention_seconds = var.sqs_message_retention_seconds
  sqs_managed_sse_enabled   = true
  redrive_policy            = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter_queue.arn
    maxReceiveCount     = 3
  })

  tags = var.tags
}

resource "aws_sqs_queue" "deadletter_queue" {
  name                      = var.deadletter_queue_name
  message_retention_seconds = var.dead_letter_queue_retention_seconds
  sqs_managed_sse_enabled   = true
  tags                      = var.tags
}

resource "aws_sqs_queue_redrive_allow_policy" "deadletter_queue_redrive_policy" {
  queue_url = aws_sqs_queue.deadletter_queue.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue.arn]
  })
}


#resource "aws_sqs_queue_policy" "sqs_dlq_policy" {
#  queue_url = aws_sqs_queue.deadletter_queue.id
#  policy    = data.aws_iam_policy_document.block_unknown_roles_policy_dql.json
#}

#resource "aws_sqs_queue_policy" "sqs_policy" {
#  queue_url = aws_sqs_queue.queue.id
#  policy    = data.aws_iam_policy_document.block_unknown_roles_policy.json
#}

#data "aws_iam_policy_document" "block_unknown_roles_policy_dql" {
#  statement {
#    sid    = "DenyAccessUnknownRoles"
#    effect = "Deny"
#    principals {
#      type        = "*"
#      identifiers = ["*"]
#    }
#    condition {
#      test   = "ArnNotEquals"
#      values = [
#        "arn:aws:iam::${var.account_id}:role/cicd",
#        "arn:aws:iam::${var.account_id}:role/TeamA"
#      ]
#      variable = "aws:PrincipalArn"
#    }
#    actions = [
#      "sqs:*"
#    ]
#    resources = [aws_sqs_queue.deadletter_queue.arn]
#  }
#}

#data "aws_iam_policy_document" "block_unknown_roles_policy" {
#  statement {
#    sid    = "DenyAccessUnknownRoles"
#    effect = "Deny"
#    principals {
#      type        = "*"
#      identifiers = ["*"]
#    }
#    condition {
#      test   = "ArnNotEquals"
#      values = [
#        "arn:aws:iam::${var.account_id}:role/cicd"
#        ,"arn:aws:iam::${var.account_id}:role/TeamA"
#        ,"arn:aws:iam::${var.account_id}:role/TeamB"
#        ,"arn:aws:iam::${var.account_id}:user/service.aws_user_cicd_service"
#      ]
#      variable = "aws:PrincipalArn"
#    }
#    actions = [
#      "sqs:*"
#    ]
#    resources = [aws_sqs_queue.queue.arn]
#  }
#}
