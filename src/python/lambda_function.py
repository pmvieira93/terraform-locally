import json
import os
import boto3
import uuid
from botocore.exceptions import ClientError

# Environment
REGION = os.environ['AWS_REGION']
ENVIRONMENT = os.environ['ENVIRONMENT']
LOGGER_LEVEL = os.environ['LOGGER_LEVEL']

def lambda_handler(event, context):

    print(f"Event:\n{event}")

    return "Hello World"