## Create two EC2 instances with different types of UserData

```sh
aws cloudformation deploy \
--template-file template.yml \
--stack-name example-ec2-stack
```

## Get the IPs from the Outputs

```sh
aws cloudformation describe-stacks \
--stack-name example-ec2-stack \
--query Stacks[0].Outputs
```

## Check if the websites are accessible

Visit http://<PUBLIC-IP-1> and http://<PUBLIC-IP-2>

## Cleanup

```sh
aws cloudformation delete-stack --stack-name example-ec2-stack
```
