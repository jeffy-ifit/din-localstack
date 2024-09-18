# Minimal Localstack Setup

Setup was made with iFIT monolith SNS/SQS development in mind.  

## Getting Started

- `chmod +x localstack-create-resources.sh` to have it be executable
- start with `docker compose -p din-localstack up -d`
- stop with `docker compose -p din-localstack up -v`

Modify `localstack-create-resources.sh` as desired for the 

## Using With iFIT Monolith

To use with monolith make sure, within the monolith (not here), you put the following in `config/override.json`:

```json
{
  "sqs": {
    "urlPrefix": "http://localhost:4566/000000000000/",
    "region": "us-east-1"
  }
}
```

Any monolith SQS handlers you with to test with will need to have `runOnDev: true` so they poll locally.

For test publishing to an SNS topic from the monolith, you'll need to change `TopicArn` in `lib/sns.js` to `arn:aws:sns:us-east-1:000000000000:din-${config.stage}-${topicName}`.
