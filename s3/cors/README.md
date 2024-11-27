## Create a bucket

```sh
aws s3 mb s3://example-cors-uvais-1
```

## Change Block Public Access

```sh
aws s3api put-public-access-block \
--bucket example-cors-uvais-1 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy \
--bucket example-cors-uvais-1 \
--policy file://policy-1.json
```

## Turn on Static Website Hosting

```sh
aws s3api put-bucket-website \
--bucket example-cors-uvais-1 \
--website-configuration file://website.json
```

## Upload index.html file

```sh
aws s3 cp website-1/index.html s3://example-cors-uvais-1
```

## Get the website endpoint URL

http://<BUCKET_NAME>.s3-website.<REGION>.amazonaws.com
http://example-cors-uvais-1.s3-website.us-east-1.amazonaws.com

## Create Website 2 to test CORS

```sh
aws s3 mb s3://example-cors-uvais-2

aws s3api put-public-access-block \
--bucket example-cors-uvais-2 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"

aws s3api put-bucket-policy \
--bucket example-cors-uvais-2 \
--policy file://policy-2.json

aws s3api put-bucket-website \
--bucket example-cors-uvais-2 \
--website-configuration file://website.json

aws s3 cp website-2/index.html s3://example-cors-uvais-2

aws s3 cp website-2/data.json s3://example-cors-uvais-2
```

http://example-cors-uvais-2.s3-website.us-east-1.amazonaws.com

## Fix CORS issue by applying a CORS policy to Bucket 2

```sh
aws s3api put-bucket-cors \
--bucket example-cors-uvais-2 \
--cors-configuration file://cors-policy.json
```

## Cleanup

```sh
aws s3 rm s3://example-cors-uvais-1 --recursive

aws s3 rb s3://example-cors-uvais-1

aws s3 rm s3://example-cors-uvais-2 --recursive

aws s3 rb s3://example-cors-uvais-2
```
