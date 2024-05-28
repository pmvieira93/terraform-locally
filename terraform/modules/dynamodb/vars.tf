variable "table_name" {
  description = "Name of the Amazon DynamoDB Table"
}

variable "billing_mode" {
  description = "Billing Mode of the Amazon DynamoDB Table"
  default     = "PAY_PER_REQUEST"
  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "Valid values for var: billing_mode are (PROVISIONED, PAY_PER_REQUEST)."
  }
}

variable "hash_key" {
  description = "Hash Key of the Amazon DynamoDB Table"
  type = string
}

variable "range_key" {
  description = "Range Key of the Amazon DynamoDB Table"
  type = string
}

/*
variable "read_capacity" {
  description = "Read Capacity of the Amazon DynamoDB Table"
  type        = number
  nullable    = false
  default     = nullable
  validation {
    condition     = var.billing_mode == "PROVISIONED" && var.read_capacity == nullable
    error_message = "Read Capacity can't be Null when Billing Mode is 'PROVISIONED'."
  }
}

variable "write_capacity" {
  description = "Write Capacity of the Amazon DynamoDB Table"
  type        = number
  nullable    = false
  default     = nullable
  validation {
    condition     = var.billing_mode == "PROVISIONED" && var.read_capacity == nullable
    error_message = "Write Capacity can't be Null when Billing Mode is 'PROVISIONED'."
  }
}
*/

variable "attributes_list" {
  description = "List of Attributes of the Amazon DynamoDB Table"
  default     = []
  type = list(object({
    name = string
    type = string
  }))
}

variable "attr_ttl_list" {
  description = "List of Attributes Declare as TTL of the Amazon DynamoDB Table"
  default     = []
  type = list(object({
    name   = string
    enable = bool
  }))
}

variable "global_sec_idx_list" {
  description = "List of Global Secondary Index of the Amazon DynamoDB Table"
  default     = []
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = string
    read_capacity      = number
    write_capacity     = number
    projection_type    = string
    non_key_attributes = set(string)
  }))
}

variable "local_sec_idx_list" {
  description = "List of Local Secondary Index of the Amazon DynamoDB Table"
  default     = []
  type = list(object({
    name               = string
    range_key          = string
    projection_type    = string
    non_key_attributes = set(string)
  }))
}
