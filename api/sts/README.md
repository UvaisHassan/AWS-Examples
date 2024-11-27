## Create a user with no permissions and create access key

```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user
```

## Save credentials to new profile

```sh
aws configure --profile sts
```

## Create a role and a bucket using Cloudformation and upload a dummy file to the bucket

```sh
bin/deploy

aws s3 cp dummy.txt s3://example-sts-uvais-1
```

## Use new user credentials and assume role

```sh
aws sts assume-role \
--role-arn arn:aws:iam::122610487271:role/STSRole \
--role-session-name example-sts-session \
--profile sts
```

## Save temporary credentials for user with assumed role

```sh
aws configure set aws_access_key_id <ACCESS-KEY-ID> --profile assumed
aws configure set aws_secret_access_key <SECRET-ACCESS-KEY> --profile assumed
aws configure set aws_session_token <SESSION-TOKEN> --profile assumed
```

## Check if role assumed user can list the contents of the bucket

```sh
aws s3 ls s3://example-sts-uvais-1 --profile assumed
```

## Cleanup

```sh
aws iam delete-access-key --access-key-id <ACCESS-KEY-ID> --user-name sts-machine-user
aws iam delete-user --user-name sts-machine-user

aws s3 rm s3://example-sts-uvais-1/dummy.txt

aws cloudformation delete-stack --stack-name example-sts-stack
```
