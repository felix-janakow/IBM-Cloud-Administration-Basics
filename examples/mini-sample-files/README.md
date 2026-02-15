# Sample Files for IBM Cloud Object Storage

This directory contains sample files in various formats for testing IBM Cloud Object Storage operations.

## Files Included

| File | Format | Description | Size |
|------|--------|-------------|------|
| `sample-data.json` | JSON | Workshop metadata and configuration | ~600 bytes |
| `notes.txt` | Text | Workshop notes and key takeaways | ~800 bytes |
| `config.yaml` | YAML | Cloud configuration settings | ~500 bytes |
| `data.csv` | CSV | Storage usage metrics over time | ~600 bytes |
| `script.sh` | Shell | Automation script for COS operations | ~400 bytes |
| `app.py` | Python | Sample Python application | ~500 bytes |
| `index.html` | HTML | Simple web page | ~600 bytes |
| `styles.css` | CSS | Stylesheet for web page | ~300 bytes |
| `image.svg` | SVG | Vector graphic logo | ~400 bytes |

## Usage Examples

### Upload to COS using CLI

```bash
# Upload single file
ibmcloud cos object-put --bucket my-bucket --key sample-data.json --body sample-data.json

# Upload all files
for file in *; do
  ibmcloud cos object-put --bucket my-bucket --key "examples/$file" --body "$file"
done
```

### Upload using Python SDK

```python
import ibm_boto3
from ibm_botocore.client import Config

cos = ibm_boto3.client('s3',
    ibm_api_key_id='YOUR_API_KEY',
    ibm_service_instance_id='YOUR_INSTANCE_ID',
    config=Config(signature_version='oauth'),
    endpoint_url='https://s3.us-south.cloud-object-storage.appdomain.cloud'
)

# Upload file
with open('sample-data.json', 'rb') as file:
    cos.upload_fileobj(file, 'my-bucket', 'sample-data.json')
```

## Testing Scenarios

1. **Basic Upload/Download** - Test file transfer operations
2. **Lifecycle Policies** - Configure archive and expiration rules
3. **Versioning** - Enable and test object versioning
4. **Access Control** - Test IAM policies and bucket permissions
5. **Backup & Restore** - Test backup vault functionality

## Notes

- All files are small (<1KB) for quick testing
- Files represent common formats used in cloud applications
- Safe to upload to any test bucket
- Can be used for automation testing