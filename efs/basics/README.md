## Launch the instance

```sh
aws cloudformation deploy \
--template-file template.yml \
--stack-name example-ec2-stack
```

## Get the Instance ID and IP from Outputs

```sh
export INSTANCE_ID=$(aws cloudformation describe-stacks \
--stack-name example-ec2-stack \
--query 'Stacks[0].Outputs[?OutputKey==`InstanceId`].OutputValue' \
--output text)

export INSTANCE_PUBLIC_IP=$(aws cloudformation describe-stacks \
--stack-name example-ec2-stack \
--query 'Stacks[0].Outputs[?OutputKey==`InstancePublicIP`].OutputValue' \
--output text)
```

## Generate key and make it read-only

```sh
ssh-keygen -t rsa -f ec2_key

chmod 400 ec2_key
```

## Upload key to the instance

```sh
aws ec2-instance-connect send-ssh-public-key \
--instance-id $INSTANCE_ID \
--instance-os-user ubuntu \
--ssh-public-key file://ec2_key.pub
```

## Connect to the instance (within 60 seconds of uploading the key)

```sh
ssh -o "IdentitiesOnly=yes" -i ec2_key ubuntu@$INSTANCE_PUBLIC_IP
```

## Check if EFS is mounted (inside EC2 instance, after SSHing)

```sh
df -h
```

Can see EFS mounted at `/mnt/efs`

```sh
exit
```

## Cleanup

```sh
rm -rf ec2_key ec2_key.pub

aws cloudformation delete-stack --stack-name example-ec2-stack
```
