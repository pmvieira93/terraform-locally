locals {
  common_tags = {
	"ResourceOwner"  = "/Pedro/"
  }

  s3_name = "pedro-vieira-backup"
  secret_name = "pedro-vieira-secret"

  # Add your secret key value here
  secret_key_value_definition = {
    githubApiKey = "dummy-api-key"
  }
}

##############################################################################
# Declare Resources here

# Secret Manager
resource "aws_secretsmanager_secret" "my_secrets" {
  name        = local.secret_name
  description = "Private Secrets"
  tags        = local.common_tags
}

resource "aws_secretsmanager_secret_version" "my_secrets_version" {
  secret_id     = aws_secretsmanager_secret.my_secrets.id
  secret_string = jsonencode(merge(local.secret_key_value_definition, var.secret_value_current_version))
}




##############################################################################
# Instantiate Modules here


module "pedro_sqs" {
  source                = "./modules/sqs"
  queue_name            = "pedro-vieira-queue"
  deadletter_queue_name = "pedro-vieira-dlq"
  tags                  = local.common_tags
  aws_region            = var.aws_region
  environment           = var.environment
  account_id            = var.aws_account_id
} 
