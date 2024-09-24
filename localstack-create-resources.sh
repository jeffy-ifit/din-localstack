#!/bin/bash

# SQS Queue w/ DLQ

echo "Create local SQS DLQ for local SQS Queue din-dev-delete-user-dlq"
aws \
  sqs create-queue \
  --queue-name="din-dev-delete-user-dlq" \
  --endpoint-url="http://localhost:4566"

echo "Create local SQS Queue din-dev-delete-user"
aws \
  sqs create-queue \
  --queue-name="din-dev-delete-user" \
  --attributes='{"DelaySeconds":"0","RedrivePolicy":"{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:000000000000:din-dev-delete-user-dlq\",\"maxReceiveCount\": \"3\"}"}' \
  --endpoint-url="http://localhost:4566"

# SNS Topic w/ SQS Subscription

echo "Create local SNS Topic user-service-local-onUserDelete"
din_sample_sns_topic_arn=$(aws sns create-topic \
  --name "user-service-local-onUserDelete" \
  --endpoint-url "http://localhost:4566" \
  --query "TopicArn" \
  --output text)

if [ -n "$din_sample_sns_topic_arn" ]; then
  echo "Subscribe SQS Queue din-sample-queue to SNS Topic din-sample-sns-topic"
  aws sns subscribe \
    --topic-arn "$din_sample_sns_topic_arn" \
    --protocol sqs \
    --notification-endpoint "arn:aws:sqs:us-east-1:000000000000:din-dev-delete-user" \
    --endpoint-url "http://localhost:4566"
else
  echo "TopicArn is empty. Unable to subscribe SQS to SNS topic. SNS topic creation may have failed."
fi
