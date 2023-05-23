# S3 Bucket Setup Script and Deployment

This script sets up an S3 bucket for hosting a static website using AWS CLI. It performs the following actions:

- Creates an S3 bucket
- Enables public access for the bucket
- Adds a bucket policy
- Enables static website hosting
- Uploads files to the bucket
- Displays the bucket website endpoint

## Prerequisites

- AWS CLI installed and configured with appropriate credentials.

## Usage

1. Update the following variables in the script to match your configuration:

   - `PLACEHOLDER_BUCKET_NAME`: Placeholder value for the bucket name in the JSON file.
   - `S3_BUCKET_NAME`: The desired name for your S3 bucket.
   - `REGION`: The AWS region where you want to create the bucket.
   - `S3_BUCKET_POLICY`: Path to the bucket policy JSON file.
   - `S3_NEW_BUCKET_POLICY`: Path to store the modified bucket policy JSON file.
   - `S3_STATIC_WEBSITE_CONFIG`: Path to the static website configuration JSON file.
   - `DIRECTORY_PATH`: Path to the directory containing the files you want to upload.

2. Run the script using the following command:

   ```bash
   ./s3-setup-deployment.sh
