# Simple IBM Cloud VSI Deployment with Terraform

This Terraform configuration demonstrates a basic Infrastructure as Code (IaC) deployment on IBM Cloud, creating:

- **VPC** (Virtual Private Cloud)
- **Subnet** within the VPC
- **Security Group** with rules for SSH, HTTP, and HTTPS
- **VSI** (Virtual Server Instance) running Ubuntu 22.04
- **Floating IP** for external access
- **SSH Key** for secure access

## Prerequisites

1. **IBM Cloud Account** with appropriate permissions
2. **Terraform** installed (version >= 1.0)
3. **IBM Cloud API Key** - [Create one here](https://cloud.ibm.com/iam/apikeys)
4. **SSH Key Pair** - Generate if needed:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/ibm_cloud_key
   ```

## Quick Start

### 1. Set up your environment

Create a `terraform.tfvars` file with your configuration:

```hcl
ibmcloud_api_key = "your-ibm-cloud-api-key-here"
region           = "eu-de"  # or us-south, eu-gb, etc.
resource_group   = "Default"
prefix           = "demo"
ssh_public_key   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQ... your-public-key-here"
```

**Note:** To get your SSH public key content:
```bash
cat ~/.ssh/ibm_cloud_key.pub
```

### 2. Initialize Terraform

```bash
terraform init
```

This downloads the IBM Cloud provider plugin.

### 3. Review the deployment plan

```bash
terraform plan
```

This shows what resources will be created.

### 4. Deploy the infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm.

### 5. Access your VSI

After deployment completes, Terraform will output the connection details:

```bash
# Get the SSH command from outputs
terraform output ssh_command

# Or manually connect using:
ssh root@<floating-ip-address>
```

## Configuration Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `ibmcloud_api_key` | IBM Cloud API Key | - | Yes |
| `region` | IBM Cloud region | `eu-de` | No |
| `resource_group` | Resource group name | `Default` | No |
| `prefix` | Prefix for resource names | `demo` | No |
| `ssh_public_key` | SSH public key content | - | Yes |

## Available Regions

- `eu-de` - Frankfurt, Germany
- `eu-gb` - London, UK
- `us-south` - Dallas, USA
- `us-east` - Washington DC, USA
- `jp-tok` - Tokyo, Japan
- `au-syd` - Sydney, Australia

## Outputs

After deployment, the following information is available:

```bash
terraform output vpc_id              # VPC identifier
terraform output subnet_id           # Subnet identifier
terraform output security_group_id   # Security group identifier
terraform output vsi_id              # VSI identifier
terraform output vsi_private_ip      # Private IP address
terraform output vsi_public_ip       # Public IP address (Floating IP)
terraform output ssh_command         # Ready-to-use SSH command
terraform output ssh_key_id          # SSH key identifier
```

## Security Group Rules

The security group allows:

- **Inbound:**
  - SSH (port 22) from anywhere
  - HTTP (port 80) from anywhere
  - HTTPS (port 443) from anywhere

- **Outbound:**
  - All traffic to anywhere

**Security Note:** For production use, restrict the SSH rule to specific IP addresses instead of `0.0.0.0/0`.

## VSI Specifications

- **Profile:** `cx2-2x4` (2 vCPUs, 4 GB RAM)
- **Image:** Ubuntu 22.04 LTS (minimal)
- **Boot Volume:** Default size (100 GB)

## Cost Estimation

Approximate monthly costs (as of 2024):
- VSI (cx2-2x4): ~$50-60/month
- Floating IP: ~$5/month
- VPC resources: Minimal/Free tier

Use the [IBM Cloud Cost Estimator](https://cloud.ibm.com/estimator) for accurate pricing.

## Cleanup

To destroy all created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm.

## Troubleshooting

### Issue: "No SSH key found"
**Solution:** Ensure your `ssh_public_key` variable is set correctly in `terraform.tfvars`.

### Issue: "Insufficient permissions"
**Solution:** Verify your API key has the necessary IAM permissions for VPC infrastructure.

### Issue: "Cannot connect via SSH"
**Solution:** 
1. Check the security group rules are applied
2. Verify the floating IP is attached
3. Ensure you're using the correct private key: `ssh -i ~/.ssh/ibm_cloud_key root@<ip>`

### Issue: "Resource quota exceeded"
**Solution:** Check your account's resource quotas in the IBM Cloud console.

## Customization

### Change VSI Profile

Edit the `profile` in the [`ibm_is_instance`](simple-vsi-deployment.tf:157) resource:

```hcl
profile = "bx2-2x8"  # 2 vCPUs, 8 GB RAM
```

Available profiles: `cx2-2x4`, `bx2-2x8`, `mx2-2x16`, etc.

### Change Operating System

Edit the image data source to use a different OS:

```hcl
data "ibm_is_image" "ubuntu" {
  name = "ibm-centos-stream-9-amd64-1"  # CentOS Stream 9
}
```

### Add More Security Group Rules

Add additional rules for other services:

```hcl
resource "ibm_is_security_group_rule" "custom_port" {
  group     = ibm_is_security_group.sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 8080
    port_max = 8080
  }
}
```

## Best Practices

1. **Never commit** `terraform.tfvars` or `.tfstate` files to version control
2. Use **remote state** (e.g., IBM Cloud Object Storage) for team collaboration
3. **Restrict SSH access** to known IP addresses in production
4. Use **resource tagging** for cost tracking and organization
5. Implement **backup strategies** for critical data
6. Review and apply **security patches** regularly

## Additional Resources

- [IBM Cloud Terraform Provider Documentation](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs)
- [IBM Cloud VPC Documentation](https://cloud.ibm.com/docs/vpc)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

## Support

For issues or questions:
- IBM Cloud Support: https://cloud.ibm.com/unifiedsupport/supportcenter
- Terraform IBM Provider Issues: https://github.com/IBM-Cloud/terraform-provider-ibm/issues