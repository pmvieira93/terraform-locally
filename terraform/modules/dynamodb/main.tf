resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key
  #read_capacity  = var.read_capacity
  #write_capacity = var.write_capacity

  # Attributes Required to be declare here, it's only the attributes that will be use
  # as Range/Hash Keys, Local/Global Secondary Index
  dynamic "attribute" {
    for_each = var.attributes_list
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "ttl" {
    for_each = var.attr_ttl_list
    content {
      attribute_name = ttl.value.name
      enabled        = ttl.value.enable
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_sec_idx_list
    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = global_secondary_index.value.range_key
      read_capacity      = global_secondary_index.value.read_capacity
      write_capacity     = global_secondary_index.value.write_capacity
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = global_secondary_index.value.non_key_attributes
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_sec_idx_list
    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = local_secondary_index.value.non_key_attributes
    }
  }
}
