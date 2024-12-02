## Create a user, a bucket and multiple policies

```sh
aws cloudformation deploy \
--template-file template.yml \
--stack-name example-iam-stack \
--capabilities CAPABILITY_NAMED_IAM
```

## Create an access key for the new user and set credentials for new profile

```sh
aws iam create-access-key --user-name ExampleUser

aws configure set aws_access_key_id <ACCESS-KEY-ID> --profile example-user
aws configure set aws_secret_access_key <SECRET-ACCESS-KEY> --profile example-user
```

## Test if the new user has access to the new bucket and can list all EC2 instances

```sh
aws s3 ls s3://example-iam-bucket-uvais --profile example-user
aws ec2 describe-instances --profile example-user
```

## Cleanup

```sh
aws cloudformation delete-stack --stack-name example-iam-stack
```
