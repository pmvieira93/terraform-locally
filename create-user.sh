#!/bin/bash

_ENDPOINT_URL=http://localhost:4566
_REGION=eu-central-1
_ENV=local
_ACCOUNT=000000000000


# Commands

aws iam --endpoint-url ${_ENDPOINT_URL} --region ${_REGION} create-user --user-name cicd

aws iam --endpoint-url ${_ENDPOINT_URL} --region ${_REGION} create-access-key --user-name cicd


