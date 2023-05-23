#!/bin/bash

# Parameters
#Make sure that the placeholder bucket name in the json file is set to "placeholder_bucket-name"
PLACEHOLDER_BUCKET_NAME="placeholder_bucket_name"
S3_BUCKET_NAME="bucket-name"
REGION="region"
S3_BUCKET_POLICY="file://bucket-policy.json"
S3_NEW_BUCKET_POLICY="file://new-policy.json"
S3_STATIC_WEBSITE_CONFIG="file://website-config.json"
DIRECTORY_PATH="../dist/portfolio/"

# Define the path to the JSON file
BUCKET_POLICY_JSON_FILE="bucket-policy.json"
NEW_BUCKET_POLICY_JSON_FILE="new-policy.json"

# Read the JSON file and replace the value
BUCKET_POLICY_JSON_FILE_DATA=$(cat "$BUCKET_POLICY_JSON_FILE")
MODIFIED_BUCKET_POLICY_JSON_FILE_DATA="${BUCKET_POLICY_JSON_FILE_DATA//$PLACEHOLDER_BUCKET_NAME/$S3_BUCKET_NAME}"

# Write the modified JSON back to the file
echo $MODIFIED_BUCKET_POLICY_JSON_FILE_DATA > $NEW_BUCKET_POLICY_JSON_FILE

#Create S3 Bucket
aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $REGION

#Enable public access for s3 bucket
aws s3api put-public-access-block --bucket $S3_BUCKET_NAME --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

#Add S3 policy to bucket
aws s3api put-bucket-policy --bucket $S3_BUCKET_NAME --policy $S3_NEW_BUCKET_POLICY

#Enable static website hosting
aws s3api put-bucket-website --bucket $S3_BUCKET_NAME --website-configuration $S3_STATIC_WEBSITE_CONFIG

#Revrsively upload to s3
aws s3 cp  $DIRECTORY_PATH "s3://$S3_BUCKET_NAME" --recursive

#Get bucket end point
bucket_endpoint="s3-website-$REGION.amazonaws.com"
bucket_website_endpoint="http://$S3_BUCKET_NAME.$bucket_endpoint"
echo "Bucket website endpoint: $bucket_website_endpoint"
