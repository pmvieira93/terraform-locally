locals {
  common_tags = {
	"ResourceOwner"  = "/Pedro/"
  }

  s3_name = "pedro-vieira-backup"
  secret_name = "pedro-vieira-secret"
  lambda_name_py = "pedro-vieira-lambda-py"

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


resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "lambda_badges_processor" {
  function_name = local.lambda_name_py
  description   = "Lambda function to process trip records."
  role          = aws_iam_role.iam_for_lambda.arn
  filename      = "pedro_py_lambda.zip"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 60

  source_code_hash = data.archive_file.py_lambda.output_base64sha256

  tags = local.common_tags

  environment {
    variables = {
      ENVIRONMENT  = var.environment
      LOGGER_LEVEL = "INFO"
    }
  }
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

module "pedro_dynamodb" {
  source = "./modules/dynamodb"
  table_name = "pedro-dynamodb"
  hash_key = "source"
  range_key = "id"
  attributes_list = [ { name = "id", type = "N" }, {name = "source", type = "S"} ]
  attr_ttl_list = []
  global_sec_idx_list = []
  local_sec_idx_list = []
}
