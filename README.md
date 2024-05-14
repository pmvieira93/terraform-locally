## SQS Useful

Setup:
```shell
_ENDPOINT_URL=http://localhost:4566 && \
_REGION=eu-central-1 && \
_ENV=local && \
_ACCOUNT=000000000000 && \

# queue | dlq
_SQS_TYPE=queue && \
_SQS_NAME=ins-notification-${_SQS_TYPE}-${_ENV}-${_REGION} && \
SQS_URL=${_ENDPOINT_URL}/${_ACCOUNT}/${_SQS_NAME}
```

### Create Queues

Command:
```shell
# Create DLQ
_SQS_TYPE=dlq && \
_SQS_NAME=ins-notification-${_SQS_TYPE}-${_ENV}-${_REGION} && \
SQS_URL=${_ENDPOINT_URL}/${_ACCOUNT}/${_SQS_NAME} && \
aws sqs create-queue --endpoint-url ${_ENDPOINT_URL} --queue-name ${_SQS_NAME} --region ${_REGION}
# Create Queue
_SQS_TYPE=queue && \
_SQS_NAME=ins-notification-${_SQS_TYPE}-${_ENV}-${_REGION} && \
SQS_URL=${_ENDPOINT_URL}/${_ACCOUNT}/${_SQS_NAME} && \
aws sqs create-queue --endpoint-url ${_ENDPOINT_URL} --queue-name ${_SQS_NAME} --region ${_REGION} --attributes file://queue-attributes.json
```

Example: `queue-attributes.json`
```json
{
  "RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:eu-central-1:000000000000:ins-notification-dlq-local-eu-central-1\",\"maxReceiveCount\":\"3\"}"
}
```

### Send SQS Message

Command:
```shell
aws sqs send-message --endpoint-url ${_ENDPOINT_URL} --queue-url ${SQS_URL} --region ${_REGION} --output json --message-body file://message.json --message-attributes file://message-attributes.json
```
Example: `message.json`
```json
{
  "gcid": "123456789012345678901234567890123456",
  "vin": "WBA12345678912345",
  "customProperties": {
    "current_month": 1
  },
  "pushNotification": {
    "id": null,
    "silent": false,
    "action": "action-url",
    "type": "BASIC",
    "customProperties": null,
    "highPriority": false
  },
  "messageCenter": null,
  "notificationToSend": "ALL",
  "translationId": "MYTRIPS_MONTHLY_REVIEW",
  "batchId": "3ac7dbac-b513-42eb-b93a-1dda17604e8e"
}
```

Example: `message-attributes.json`
```json
{
  "Source": {
    "DataType": "String",
    "StringValue": "JoyDivision"
  },
  "NumberOfMessages": {
    "DataType": "Number",
    "StringValue": "123"
  }
}
```

### Other SQS Commands

```shell
aws sqs list-queues --endpoint-url ${_ENDPOINT_URL}

aws sqs set-queue-attributes --endpoint-url ${_ENDPOINT_URL} --queue-url ${SQS_URL} --attributes file://queue-attributes.json

aws sqs get-queue-attributes --endpoint-url ${_ENDPOINT_URL} --queue-url ${SQS_URL} --region ${_REGION} --attribute-names All

aws sqs receive-message --endpoint-url ${_ENDPOINT_URL} --queue-url ${SQS_URL} --region ${_REGION} --output json --max-number-of-messages 10

aws sqs purge-queue --endpoint-url ${_ENDPOINT_URL} --queue-url ${SQS_URL} --region ${_REGION}
```
