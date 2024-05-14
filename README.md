## AWS Cli with Localstack

Setup:
```shell
_ENDPOINT_URL=http://localhost:4566 && \
_REGION=eu-central-1 && \
_ENV=local && \
_ACCOUNT=000000000000 && \

```

### Usage

```shell
# SQS Example
SQS_URL=${_ENDPOINT_URL}/${_ACCOUNT}/${_SQS_NAME} && \
aws sqs create-queue --endpoint-url ${_ENDPOINT_URL} --queue-name ${_SQS_NAME} --region ${_REGION} --attributes file://queue-attributes.json
```

Example: `queue-attributes.json`
```json
{
  "RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-central-1:000000000000:pedro-vieira-dlq-local-eu-central-1\",\"maxReceiveCount\":\"1\"}"
}
```

## References

- AWS Command Builder: https://awsclibuilder.com/home/
