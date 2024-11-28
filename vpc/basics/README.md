## Create a VPC

```sh
VPC_ID=(aws ec2 create-vpc \
--cidr-block "10.0.0.0/16" \
--tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=example-vpc-uvais-1}]" \
--query Vpc.VpcId \
--output text)
echo "VPC_ID=$VPC_ID"
```

## Enable DNS Hostnames for the VPC

```sh
aws ec2 modify-vpc-attribute \
--vpc-id "$VPC_ID" \
--enable-dns-hostnames
```

## Create an IGW

```sh
IGW_ID=(aws ec2 create-internet-gateway \
--tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=example-igw-uvais-1}]" \
--query InternetGateway.InternetGatewayId \
--output text)
echo "IGW_ID=$IGW_ID"
```

## Attach the IGW

```sh
aws ec2 attach-internet-gateway \
--internet-gateway-id "$IGW_ID" \
--vpc-id "$VPC_ID"
```

## Create a subnet

```sh
SUBNET_ID=(aws ec2 create-subnet \
--vpc-id "$VPC_ID" \
--cidr-block "10.0.0.0/24" \
--tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=example-subnet-uvais-1}]" \
--query Subnet.SubnetId \
--output text)
echo "SUBNET_ID=$SUBNET_ID"
```

## Enable DNS Hostnames for the VPC

```sh
aws ec2 modify-subnet-attribute \
--subnet-id "$SUBNET_ID" \
--map-public-ip-on-launch
```

## Get the default route table for the VPC

```sh
ROUTE_TABLE_ID=(aws ec2 describe-route-tables \
--filters "Name=vpc-id,Values=$VPC_ID" "Name=association.main,Values=true" \
--query RouteTables[].RouteTableId \
--output text)
echo "ROUTE_TABLE_ID=$ROUTE_TABLE_ID"
```

## Associate the subnet with a route table

```sh
aws ec2 create-route \
--route-table-id "$ROUTE_TABLE_ID" \
--destination-cidr-block "0.0.0.0/0" \
--gateway-id "$IGW_ID"
```

## Cleanup

```sh
aws ec2 delete-route \
--route-table-id "$ROUTE_TABLE_ID" \
--destination-cidr-block "0.0.0.0/0"

aws ec2 detach-internet-gateway \
--internet-gateway-id "$IGW_ID" \
--vpc-id "$VPC_ID"

aws ec2 delete-internet-gateway \
--internet-gateway-id "$IGW_ID"

aws ec2 delete-subnet \
--subnet-id "$SUBNET_ID"

aws ec2 delete-vpc \
--vpc-id "$VPC_ID"
```
