terraform {
  required_version = ">= 1.0.0"

  #backend "s3" {
  #  encrypt = true
  #}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  access_key                  = "testkey"
  secret_key                  = "test"
  region                      = "eu-central-1"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = var.localstack_url
    apigatewayv2   = var.localstack_url
    cloudformation = var.localstack_url
    cloudwatch     = var.localstack_url
    dynamodb       = var.localstack_url
    ec2            = var.localstack_url
    es             = var.localstack_url
    elasticache    = var.localstack_url
    firehose       = var.localstack_url
    iam            = var.localstack_url
    kinesis        = var.localstack_url
    kms            = var.localstack_url
    lambda         = var.localstack_url
    rds            = var.localstack_url
    redshift       = var.localstack_url
    route53        = var.localstack_url
    #s3             = "http://s3.localhost.localstack.cloud:4566"
    # S3: In order to use the default endpoint, you need to set 's3_use_path_style' to true
    s3             = var.localstack_url
    secretsmanager = var.localstack_url
    ses            = var.localstack_url
    sns            = var.localstack_url
    sqs            = var.localstack_url
    ssm            = var.localstack_url
    stepfunctions  = var.localstack_url
    sts            = var.localstack_url
  }
}
