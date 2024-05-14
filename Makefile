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
