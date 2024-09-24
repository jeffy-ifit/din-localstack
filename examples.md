# Some AWS CLI Commands

```sh
# aws sqs send-message --endpoint-url http://localhost:4566 --region=us-east-1 --queue-url http://localhost:4566/000000000000/din-dev-delete-user --message-body "YO MOMMA"

aws --endpoint-url=http://localhost:4566 --region=us-east-1 sqs list-queues

aws --endpoint-url=http://localhost:4566 --region=us-east-1 sns list-subscriptions

aws --endpoint-url=http://localhost:4566 --region=us-east-1 sns list-topics

aws sns publish --endpoint-url=http://localhost:4566 --region=us-east-1 --topic-arn=arn:aws:sns:us-east-1:000000000000:user-service-local-onUserDelete --message '{"_id": "abc"}'
```
