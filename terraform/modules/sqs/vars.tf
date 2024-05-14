variable "queue_name" {
  description = "The name of the Amazon SQS queue"
}

variable "sqs_message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message"
  # By default SQS defaults to a retention of 14 days
  default     = 14*24*60*60
}

variable "deadletter_queue_name" {
  description = "The name of the Amazon SQS dead letter queue"
}

variable "dead_letter_queue_retention_seconds" {
  description = "The number of seconds the dead letter queue retain a message"
  # By default SQS defaults to a retention of 14 days
  default     = 14*24*60*60
}

variable "account_id" {
  description = "The account id"
  type        = string
  default     = "000000000000"
}

variable "aws_region" {
  description = "The aws region to create the resources on"
  default     = "eu-central-1"
}

variable "environment" {
  description = "The environment to create the resources on"
  default     = "local"
}

variable "tags" {
  description = "The tags to apply to the resources"
}
