#!/usr/bin/env python3
"""
Simple IBM Cloud Object Storage Example Application
"""

import ibm_boto3
from ibm_botocore.client import Config
import os

# Configuration
COS_ENDPOINT = "https://s3.us-south.cloud-object-storage.appdomain.cloud"
COS_API_KEY = os.environ.get('IBM_CLOUD_API_KEY')
COS_INSTANCE_ID = os.environ.get('COS_INSTANCE_ID')
BUCKET_NAME = "workshop-demo-bucket"

def create_cos_client():
    """Create and return COS client"""
    return ibm_boto3.client(
        's3',
        ibm_api_key_id=COS_API_KEY,
        ibm_service_instance_id=COS_INSTANCE_ID,
        config=Config(signature_version='oauth'),
        endpoint_url=COS_ENDPOINT
    )

def list_objects(cos_client, bucket):
    """List all objects in bucket"""
    try:
        response = cos_client.list_objects_v2(Bucket=bucket)
        if 'Contents' in response:
            for obj in response['Contents']:
                print(f"- {obj['Key']} ({obj['Size']} bytes)")
        else:
            print("Bucket is empty")
    except Exception as e:
        print(f"Error: {e}")

def main():
    print("IBM Cloud Object Storage Demo")
    print("=" * 40)
    
    cos = create_cos_client()
    list_objects(cos, BUCKET_NAME)

if __name__ == "__main__":
    main()
