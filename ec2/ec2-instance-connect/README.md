## Launch the instance

```sh
aws cloudformation deploy \
--template-file template.yml \
--stack-name example-ec2-stack
```

## Get the Instance ID and IP from Outputs

```sh
aws cloudformation describe-stacks \
--stack-name example-ec2-stack \
--query Stacks[0].Outputs
```

## Generate key and make it read-only

```sh
ssh-keygen -t rsa -f ec2_key

chmod 400 ec2_key
```

## Upload key to the instance

```sh
aws ec2-instance-connect send-ssh-public-key \
--instance-id <INSTANCE-ID> \
--instance-os-user ubuntu \
--ssh-public-key file://ec2_key.pub
```

## Connect to the instance (within 60 seconds of uploading the key)

```sh
ssh -o "IdentitiesOnly=yes" -i ec2_key ubuntu@<PUBLIC-IP>
```

## Cleanup

```sh
rm -rf ec2_key ec2_key.pub

aws cloudformation delete-stack --stack-name example-ec2-stack
```
