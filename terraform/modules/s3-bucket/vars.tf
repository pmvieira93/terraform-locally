# Variables for the bucket module
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

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}

variable "bucket_expiration_days" {
  description = "The number of days after which the objects in the bucket expires (Removed)"
  type        = number
  default     = 90
}

variable "kms_master_key_id" {
  description = "A kms key to be used for bucket encryption"
  type        = string
}

variable "allowed_principals" {
  description = "Principals to be granted access to the bucket"
  type = set(string)
}

variable "folders" {
  description = "Folders to be created in the bucket. Ex.: ['input/', 'log/success/', 'log/error/]"
  type = list(string)
  default = []
}

variable "versioning_status" {
  description = "The versioning status of the bucket"
  type        = string
  default     = "Disabled"
  validation {
    condition = contains(["Enabled", "Disabled"], var.versioning_status)
    error_message = "Valid values for var: versioning_status are (Enabled, Disabled)."
  }
}