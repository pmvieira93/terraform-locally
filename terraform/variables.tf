variable "aws_region" {
  description = "The aws region to create the resources on"
  default = "eu-central-1"
}

variable "environment" {
  description = "The environment to create the resources on"
  default = "local"
}

variable "aws_account_id" {
  description = "The account_id to create the resources on"
  default = "000000000000"
}

variable "secret_value_current_version" {
  description = "The current version of the secret"
  default = {}
}
