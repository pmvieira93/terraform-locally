#!/bin/sh

# Backup State
cp terraform.tfstate terraform.tfstate.original

# Change endpoint
#sed -i 's#localhost:4566#localstack:4566#g' terraform.tfstate


# Start Terraform
terraform init -reconfigure

terraform plan -var "localstack_url=http://localstack:4566" -out tfplan '-lock=false' '-input=false'

terraform apply tfplan


