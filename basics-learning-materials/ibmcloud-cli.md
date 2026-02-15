# IBM Cloud CLI Basics

**Learning Objectives:**
- Install and configure the IBM Cloud CLI
- Understand essential CLI commands and plugins
- Perform common cloud operations via command line

---

## 1. Installation

### macOS

**Using Homebrew (Recommended):**
```bash
brew install ibmcloud-cli
```

**Using Installer:**
```bash
curl -fsSL https://clis.cloud.ibm.com/install/osx | sh
```

### Linux

**Using Installer:**
```bash
curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
```

**Manual Download:**
- Download from: https://github.com/IBM-Cloud/ibm-cloud-cli-release/releases
- Extract and run: `./install`

### Windows

**Using Installer:**
- Download from: https://clis.cloud.ibm.com/download/bluemix-cli/latest/win64
- Run the installer and follow prompts

**Using PowerShell:**
```powershell
iex(New-Object Net.WebClient).DownloadString('https://clis.cloud.ibm.com/install/powershell')
```

### Verify Installation

```bash
ibmcloud --version
```

Expected output: `ibmcloud version 2.x.x`

---

## 2. Initial Setup

### Login to IBM Cloud

**Interactive Login:**
```bash
ibmcloud login
```

**Using API Key:**
```bash
ibmcloud login --apikey @~/path/to/apikey.json
```

**SSO Login:**
```bash
ibmcloud login --sso
```

**Specify Region:**
```bash
ibmcloud login -r us-south
```

### Target Resource Group

```bash
# List resource groups
ibmcloud resource groups

# Target specific resource group
ibmcloud target -g Default
```

### Check Current Configuration

```bash
ibmcloud target
```

---

## 3. Plugin Management

### Essential Plugins

**Install Core Plugins:**
```bash
# VPC Infrastructure
ibmcloud plugin install vpc-infrastructure

# Container Service (Kubernetes/OpenShift)
ibmcloud plugin install container-service

# Container Registry
ibmcloud plugin install container-registry

# Cloud Object Storage
ibmcloud plugin install cloud-object-storage

# Schematics (Terraform)
ibmcloud plugin install schematics
```

### Plugin Commands

```bash
# List available plugins
ibmcloud plugin repo-plugins

# List installed plugins
ibmcloud plugin list

# Update all plugins
ibmcloud plugin update --all

# Uninstall plugin
ibmcloud plugin uninstall <plugin-name>
```

---

## 4. Common CLI Operations

### Example 1: Managing VPC Resources

**Create a VPC:**
```bash
# List available zones
ibmcloud is zones

# Create VPC
ibmcloud is vpc-create my-vpc --resource-group-name Default

# List VPCs
ibmcloud is vpcs

# Create subnet
ibmcloud is subnet-create my-subnet <vpc-id> \
  --zone us-south-1 \
  --ipv4-cidr-block 10.240.0.0/24
```

**Create Virtual Server Instance:**
```bash
# List available images
ibmcloud is images

# List available profiles
ibmcloud is instance-profiles

# Create SSH key
ibmcloud is key-create my-key @~/.ssh/id_rsa.pub

# Create instance
ibmcloud is instance-create my-vsi <vpc-id> us-south-1 \
  cx2-2x4 <subnet-id> \
  --image <image-id> \
  --keys <key-id>
```

### Example 2: Managing Kubernetes Clusters

**Create and Manage Cluster:**
```bash
# List available Kubernetes versions
ibmcloud ks versions

# Create cluster
ibmcloud ks cluster create vpc-gen2 \
  --name my-cluster \
  --zone us-south-1 \
  --vpc-id <vpc-id> \
  --subnet-id <subnet-id> \
  --flavor bx2.4x16 \
  --workers 3

# List clusters
ibmcloud ks clusters

# Get cluster configuration
ibmcloud ks cluster config --cluster my-cluster

# List worker nodes
ibmcloud ks workers --cluster my-cluster
```

### Example 3: Managing Cloud Object Storage

**Create and Use COS:**
```bash
# Create COS instance
ibmcloud resource service-instance-create my-cos \
  cloud-object-storage standard global

# Create bucket
ibmcloud cos bucket-create --bucket my-bucket \
  --ibm-service-instance-id <instance-id> \
  --region us-south

# Upload file
ibmcloud cos object-put --bucket my-bucket \
  --key myfile.txt \
  --body ./local-file.txt

# List objects
ibmcloud cos objects --bucket my-bucket

# Download file
ibmcloud cos object-get --bucket my-bucket \
  --key myfile.txt \
  --output ./downloaded-file.txt
```

---

## 5. Essential Commands Reference

### Account & Authentication

```bash
# Login
ibmcloud login

# Logout
ibmcloud logout

# Show current account
ibmcloud account show

# List API keys
ibmcloud iam api-keys

# Create API key
ibmcloud iam api-key-create my-key -d "Description"
```

### Resource Management

```bash
# List all resources
ibmcloud resource service-instances

# List resource groups
ibmcloud resource groups

# Create resource group
ibmcloud resource group-create my-group

# Target resource group
ibmcloud target -g my-group
```

### IAM (Identity & Access Management)

```bash
# List users
ibmcloud account users

# List service IDs
ibmcloud iam service-ids

# Create service ID
ibmcloud iam service-id-create my-service-id

# Assign access policy
ibmcloud iam user-policy-create user@example.com \
  --roles Editor \
  --service-name is
```

### Billing & Usage

```bash
# View account usage
ibmcloud billing account-usage

# View resource usage
ibmcloud billing resource-instances-usage
```

---

## 6. Advanced Features

### Using JSON Output

```bash
# Get JSON output for scripting
ibmcloud is vpcs --output json

# Parse with jq
ibmcloud is vpcs --output json | jq '.[] | {name, id}'
```

### Configuration Files

**Config Location:**
- macOS/Linux: `~/.bluemix/config.json`
- Windows: `%USERPROFILE%\.bluemix\config.json`

**View Configuration:**
```bash
ibmcloud config --list
```

### Shell Completion

**Enable Bash Completion:**
```bash
# Add to ~/.bashrc or ~/.bash_profile
source /usr/local/ibmcloud/autocomplete/bash_autocomplete
```

**Enable Zsh Completion:**
```bash
# Add to ~/.zshrc
source /usr/local/ibmcloud/autocomplete/zsh_autocomplete
```

---

## 7. Troubleshooting

### Common Issues

**Issue: Command not found**
```bash
# Verify installation
which ibmcloud

# Add to PATH (if needed)
export PATH=$PATH:/usr/local/bin
```

**Issue: Authentication failed**
```bash
# Clear cached credentials
rm -rf ~/.bluemix

# Login again
ibmcloud login
```

**Issue: Plugin conflicts**
```bash
# Update all plugins
ibmcloud plugin update --all

# Reinstall specific plugin
ibmcloud plugin uninstall vpc-infrastructure
ibmcloud plugin install vpc-infrastructure
```

### Debug Mode

```bash
# Enable verbose output
ibmcloud -v <command>

# Enable debug mode
ibmcloud --trace <command>
```

---

## 8. Best Practices

1. **Use API Keys for Automation**
   - Never hardcode credentials in scripts
   - Store API keys securely (environment variables, secrets manager)
   - Rotate keys regularly

2. **Target Resource Groups**
   - Always specify resource group to avoid confusion
   - Use consistent naming conventions

3. **Use JSON Output for Scripts**
   - Parse JSON with `jq` for reliable scripting
   - Handle errors properly in automation

4. **Keep CLI Updated**
   - Update CLI and plugins regularly
   - Check release notes for breaking changes

5. **Use Shell Completion**
   - Enable autocomplete for faster command entry
   - Reduces typos and errors

---

## 9. Quick Reference

### Most Used Commands

| Command | Description |
|---------|-------------|
| `ibmcloud login` | Login to IBM Cloud |
| `ibmcloud target` | Show/set target region and resource group |
| `ibmcloud resource service-instances` | List all service instances |
| `ibmcloud is vpcs` | List VPCs |
| `ibmcloud ks clusters` | List Kubernetes clusters |
| `ibmcloud cos buckets` | List COS buckets |
| `ibmcloud plugin list` | List installed plugins |
| `ibmcloud --help` | Show help |

### Getting Help

```bash
# General help
ibmcloud --help

# Command-specific help
ibmcloud is --help
ibmcloud is vpc-create --help

# Plugin help
ibmcloud plugin --help
```

---

## 10. Additional Resources

**Official Documentation:**
- [IBM Cloud CLI Reference](https://cloud.ibm.com/docs/cli)
- [CLI Plugin Repository](https://cloud.ibm.com/docs/cli?topic=cli-plug-ins)
- [CLI GitHub Repository](https://github.com/IBM-Cloud/ibm-cloud-cli-release)

**Community:**
- [IBM Cloud Community](https://community.ibm.com/community/user/cloud/home)
- [Stack Overflow - IBM Cloud](https://stackoverflow.com/questions/tagged/ibm-cloud)

