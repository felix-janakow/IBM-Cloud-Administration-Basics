#!/bin/bash

# IBM Cloud Object Storage Upload Script
# This script uploads files to a COS bucket

BUCKET_NAME="workshop-demo-bucket"
REGION="us-south"

echo "Starting COS upload process..."

# Check if ibmcloud CLI is installed
if ! command -v ibmcloud &> /dev/null; then
    echo "Error: IBM Cloud CLI not found"
    exit 1
fi

# Upload files
echo "Uploading files to bucket: $BUCKET_NAME"

for file in *.json *.txt *.csv *.yaml; do
    if [ -f "$file" ]; then
        echo "Uploading: $file"
        ibmcloud cos object-put \
            --bucket "$BUCKET_NAME" \
            --key "examples/$file" \
            --body "$file" \
            --region "$REGION"
    fi
done

echo "Upload complete!"
