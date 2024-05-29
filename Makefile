SHELL := /bin/bash

init:
	pushd ./terraform; terraform init -reconfigure; popd

plan: init
	pushd ./terraform; terraform plan -out tfplan '-lock=false' '-input=false'; popd

apply:
	pushd ./terraform; terraform apply tfplan; popd

destroy:
	pushd ./terraform; terraform plan -destroy -out tfplan.destroy '-lock=false' '-input=false'; popd
	pushd ./terraform; terraform apply -destroy tfplan.destroy; popd

up:
	docker compose --profile dev up --build -d

down:
	docker compose --profile dev down


plan-docker:
	docker run -i -t --name terraform-dev -v ./terraform:/workspace -w /workspace --network=notification-service_notification-network hashicorp/terraform:1.8 plan -var "localstack_url=http://localstack:4566"


build:
	docker build -t terraform-dev .

run:
	docker run -i -t --network=localstack-network terraform-dev:latest
