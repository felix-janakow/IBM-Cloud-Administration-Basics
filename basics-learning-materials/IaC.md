
# IBM Cloud Infrastructure as Code (IaC) Basics

**Learning Objectives:**
- Understand Infrastructure as Code concepts and benefits on IBM Cloud
- Master IBM Cloud Schematics for Terraform automation
- Create and deploy Deployable Architectures
- Implement enterprise-grade infrastructure patterns
- Apply best practices for IaC governance and compliance

---

## 1. Understanding Infrastructure as Code on IBM Cloud

### What is Infrastructure as Code?

Infrastructure as Code (IaC) is the practice of managing and provisioning infrastructure through machine-readable definition files rather than manual processes. On IBM Cloud, IaC enables you to:

- **Automate Deployments:** Provision complex infrastructure consistently and repeatedly
- **Version Control:** Track infrastructure changes like application code
- **Collaboration:** Share and review infrastructure configurations across teams
- **Compliance:** Enforce security and governance policies programmatically
- **Cost Management:** Predict and control infrastructure costs before deployment

**Key IBM Cloud IaC Components:**

```
┌─────────────────────────────────────────────────────────────────┐
│                    IBM Cloud IaC Ecosystem                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────┐      ┌──────────────────────────────┐     │
│  │   Terraform      │◄─────┤  IBM Cloud Provider for      │     │
│  │   (Open Source)  │      │  Terraform                   │     │
│  └──────────────────┘      └──────────────────────────────┘     │
│           ▲                                                     │
│           │                                                     │
│  ┌────────┴─────────────────────────────────────────────────┐   │
│  │         IBM Cloud Schematics (Managed Service)           │   │
│  │  - Terraform execution environment                       │   │
│  │  - State management                                      │   │
│  │  - Workspace management                                  │   │
│  └──────────────────────────────────────────────────────────┘   │
│           ▲                                                     │
│           │                                                     │
│  ┌────────┴─────────────────────────────────────────────────┐   │
│  │         Deployable Architectures                         │   │
│  │  - Pre-validated infrastructure patterns                 │   │
│  │  - Compliance-ready templates                            │   │
│  │  - Enterprise governance                                 │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Why Use IaC on IBM Cloud?**

1. **Consistency:** Eliminate configuration drift and manual errors
2. **Speed:** Deploy complex environments in minutes instead of hours
3. **Scalability:** Replicate infrastructure across regions and accounts
4. **Auditability:** Complete history of infrastructure changes
5. **Cost Optimization:** Test and validate before committing resources

---

## 2. IBM Cloud Schematics: Managed Terraform Service

### 2.1 What is IBM Cloud Schematics?

IBM Cloud Schematics is a fully managed service that provides Terraform-as-a-Service capabilities. It eliminates the need to install and maintain Terraform locally while providing enterprise features like state management, access control, and audit logging.

**Schematics Architecture:**

```
┌─────────────────────────────────────────────────────────────────┐
│                        User Interface                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │  IBM Cloud   │  │  CLI/API     │  │  Terraform CLI       │   │
│  │  Console     │  │              │  │  (with Schematics)   │   │
│  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘   │
└─────────┼──────────────────┼──────────────────────┼─────────────┘
          │                  │                      │
          └──────────────────┼──────────────────────┘
                             ▼
          ┌─────────────────────────────────────────────────────┐
          │         IBM Cloud Schematics Service                │
          ├─────────────────────────────────────────────────────┤
          │                                                     │
          │  ┌──────────────────────────────────────────────┐   │
          │  │           Workspace Management               │   │
          │  │  - Configuration storage                     │   │
          │  │  - Variable management                       │   │
          │  │  - Version control integration               │   │
          │  └──────────────────────────────────────────────┘   │
          │                                                     │
          │  ┌──────────────────────────────────────────────┐   │
          │  │           Terraform Engine                   │   │
          │  │  - Plan execution                            │   │
          │  │  - Apply operations                          │   │
          │  │  - Destroy operations                        │   │
          │  └──────────────────────────────────────────────┘   │
          │                                                     │
          │  ┌──────────────────────────────────────────────┐   │
          │  │           State Management                   │   │
          │  │  - Encrypted state storage                   │   │
          │  │  - State locking                             │   │
          │  │  - State versioning                          │   │
          │  └──────────────────────────────────────────────┘   │
          │                                                     │
          │  ┌──────────────────────────────────────────────┐   │
          │  │           IAM Integration                    │   │
          │  │  - Access control                            │   │
          │  │  - Service authorization                     │   │
          │  │  - Audit logging                             │   │
          │  └──────────────────────────────────────────────┘   │
          │                                                     │
          └─────────────────────────────────────────────────────┘
                             ▼
          ┌─────────────────────────────────────────────────────┐
          │              IBM Cloud Resources                    │
          │  VPC | Kubernetes | Databases | Storage | etc.      │
          └─────────────────────────────────────────────────────┘
```

### 2.2 Key Schematics Concepts

#### Workspaces

A **workspace** is a Schematics environment that contains your Terraform configuration and manages the lifecycle of your infrastructure.

**Workspace Components:**

| Component | Description | Purpose |
|-----------|-------------|---------|
| **Configuration** | Terraform files (.tf) | Define infrastructure resources |
| **Variables** | Input parameters | Customize deployments |
| **State** | Current infrastructure state | Track resource status |
| **Outputs** | Exported values | Share data between workspaces |
| **Activity Log** | Execution history | Audit and troubleshooting |

**Workspace Lifecycle:**

```
┌─────────────────────────────────────────────────────────────────┐
│                    Workspace Lifecycle                          │
└─────────────────────────────────────────────────────────────────┘

    ┌──────────────┐
    │   CREATE     │  Create workspace with Terraform config
    │  Workspace   │  from Git repo or uploaded files
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │   GENERATE   │  Schematics generates execution plan
    │     Plan     │  Shows what will be created/changed
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │    APPLY     │  Execute plan to provision resources
    │     Plan     │  Creates actual infrastructure
    └──────┬───────┘
           │
           ▼
    ┌──────────────┐
    │   ACTIVE     │  Infrastructure is running
    │  Workspace   │  Can be updated or destroyed
    └──────┬───────┘
           │
           ├──────────────┐
           │              │
           ▼              ▼
    ┌──────────┐   ┌──────────┐
    │  UPDATE  │   │ DESTROY  │  Remove all resources
    │  (Apply) │   │          │  Clean up infrastructure
    └──────────┘   └──────────┘
```

#### State Management

Schematics automatically manages Terraform state with enterprise features:

- **Encrypted Storage:** State files encrypted at rest and in transit
- **State Locking:** Prevents concurrent modifications
- **Version History:** Track state changes over time
- **Backup & Recovery:** Automatic state backups

**State File Security:**

```
┌─────────────────────────────────────────────────────────────────┐
│                    State File Protection                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  User Action                                                    │
│       │                                                         │
│       ▼                                                         │
│  ┌─────────────────┐                                            │
│  │  Terraform      │                                            │
│  │  Operation      │                                            │
│  └────────┬────────┘                                            │
│           │                                                     │
│           ▼                                                     │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │         State Lock Acquisition                          │    │
│  │  - Prevents concurrent modifications                    │    │
│  │  - Ensures consistency                                  │    │
│  └─────────────────┬───────────────────────────────────────┘    │
│                    │                                            │
│                    ▼                                            │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │         Encrypted State Storage                         │    │
│  │  - AES-256 encryption at rest                           │    │
│  │  - TLS 1.2+ in transit                                  │    │
│  │  - IBM Key Protect integration                          │    │
│  └─────────────────┬───────────────────────────────────────┘    │
│                    │                                            │
│                    ▼                                            │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │         State Versioning                                │    │
│  │  - Automatic versioning                                 │    │
│  │  - Rollback capability                                  │    │
│  │  - Audit trail                                          │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 2.3 Schematics vs. Local Terraform

| Feature | IBM Cloud Schematics | Local Terraform |
|---------|---------------------|-----------------|
| **Installation** | No installation required | Must install Terraform CLI |
| **State Management** | Automatic, encrypted, versioned | Manual configuration required |
| **Access Control** | IBM Cloud IAM integration | Manual setup needed |
| **Audit Logging** | Built-in Activity Tracker | Manual logging setup |
| **Collaboration** | Native workspace sharing | Requires external tools |
| **Cost** | Free for execution (pay for resources) | Free CLI (pay for resources) |
| **Execution Environment** | Managed, consistent | Local environment variations |
| **State Locking** | Automatic | Requires backend configuration |

**Recommendation:** Use Schematics for production workloads to benefit from enterprise features and simplified management.

---

## 3. Terraform on IBM Cloud

### 3.1 IBM Cloud Provider for Terraform

The IBM Cloud Provider for Terraform enables you to manage IBM Cloud resources using Terraform configuration language (HCL).

**Provider Configuration:**

```hcl
# Configure the IBM Cloud Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.63.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}
```

### 3.2 Common IBM Cloud Resources

**Key Resource Types:**

| Resource Type | Terraform Resource | Purpose |
|---------------|-------------------|---------|
| VPC | `ibm_is_vpc` | Virtual Private Cloud network |
| Subnet | `ibm_is_subnet` | Network segment within VPC |
| Security Group | `ibm_is_security_group` | Firewall rules |
| Virtual Server | `ibm_is_instance` | Compute instances |
| Kubernetes | `ibm_container_vpc_cluster` | Managed Kubernetes service |
| Object Storage | `ibm_cos_bucket` | Cloud Object Storage |
| Database | `ibm_database` | Managed databases |

**Example: Basic VPC Setup**

```hcl
# Create a VPC with subnet
resource "ibm_is_vpc" "example_vpc" {
  name           = "my-vpc"
  resource_group = ibm_resource_group.example_rg.id
  tags           = ["env:production"]
}

resource "ibm_is_subnet" "example_subnet" {
  name                     = "my-subnet"
  vpc                      = ibm_is_vpc.example_vpc.id
  zone                     = "us-south-1"
  total_ipv4_address_count = 256
  resource_group           = ibm_resource_group.example_rg.id
}
```

### 3.3 Terraform Best Practices

**Key Principles:**

1. **Use Variables for Flexibility** - Define configurable inputs
2. **Use Outputs for Data Sharing** - Export important values
3. **Use Modules for Reusability** - Create reusable components
4. **Implement Validation** - Validate inputs to prevent errors
5. **Tag Resources** - Enable cost tracking and organization

**Example: Variables with Validation**

```hcl
variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}
```

**Example: Outputs**

```hcl
output "vpc_id" {
  description = "ID of the created VPC"
  value       = ibm_is_vpc.example_vpc.id
}
```

**Example: Using Modules**

```hcl
module "vpc" {
  source = "./modules/vpc"
  
  name              = "production-vpc"
  resource_group_id = data.ibm_resource_group.group.id
  region            = var.region
}
```

---

## 4. Deployable Architectures

### 4.1 Understanding Deployable Architectures

Deployable Architectures are pre-built, validated infrastructure patterns that follow IBM Cloud best practices. They provide:

- **Pre-validated Configurations:** Tested and approved by IBM
- **Compliance Controls:** Built-in security and governance
- **Customizable Variations:** Adapt to different requirements
- **Catalog Integration:** Easy discovery and deployment

**Architecture Types:**

1. **Foundation Architectures** - Basic building blocks (VPC, networking)
2. **Solution Architectures** - Complete application stacks
3. **Industry Architectures** - Compliance-ready patterns (HIPAA, PCI-DSS)

### 4.2 Architecture Variations

Deployable Architectures offer different variations for different needs:

| Variation | Use Case | Features |
|-----------|----------|----------|
| **QuickStart** | Development, testing | Single-zone, minimal resources |
| **Standard** | Production workloads | Multi-zone, basic HA |
| **Enterprise** | Mission-critical apps | Multi-region, full DR, compliance |

---

## 5. Step-by-Step Workshop: Getting Started with Schematics

### Step 1: Create Your First Schematics Workspace

**Goal:** Create a Schematics workspace linked to a Git repository.

**Navigation:** IBM Cloud Console → Schematics → Workspaces → Create workspace

**Configuration:**

1. **Workspace Details:**
   - Name: `my-first-workspace`
   - Resource group: `Default`
   - Location: `North America`

2. **Repository:**
   - URL: `https://github.com/IBM-Cloud/terraform-ibm-vpc`
   - Branch: `main`
   - Terraform version: `terraform_v1.5`

3. Click **Create**

### Step 2: Configure Workspace Variables

**Required Variables:**

| Variable | Value | Sensitive |
|----------|-------|-----------|
| `ibmcloud_api_key` | Your API key | Yes |
| `region` | `us-south` | No |
| `resource_group` | `Default` | No |

**To add variables:**
1. Go to **Settings** tab
2. Click **Add variable**
3. Enter name, value, and mark sensitive if needed
4. Click **Save**

### Step 3: Generate and Review Terraform Plan

1. Click **Actions** → **Generate plan**
2. Review the plan output in the **Activity** tab
3. Verify resources to be created
4. Check for any errors or warnings

**Expected output:**
```
Plan: 5 to add, 0 to change, 0 to destroy.
```

### Step 4: Apply Terraform Configuration

1. Click **Actions** → **Apply plan**
2. Confirm the action
3. Monitor progress in **Activity** tab
4. Wait for completion (typically 5-10 minutes)

### Step 5: View Outputs and State

1. Go to **Outputs** tab to see created resource IDs
2. Go to **Resources** tab to see state file
3. Verify resources in IBM Cloud Console

### Step 6: Update Infrastructure

To make changes:
1. Update code in Git repository
2. Click **Actions** → **Pull latest**
3. Generate new plan
4. Apply changes

### Step 7: Destroy Infrastructure (Cleanup)

**Warning:** This will delete all resources managed by this workspace.

1. Click **Actions** → **Destroy resources**
2. Type workspace name to confirm
3. Click **Destroy**

---

## 6. Step-by-Step Workshop: Deploying a Deployable Architecture

### Step 1: Browse the Catalog

1. Navigate to **Catalog** in IBM Cloud Console
2. Filter by **Deployable architectures**
3. Select an architecture (e.g., "VPC landing zone")

### Step 2: Review Architecture Details

Review:
- Architecture diagram
- Included resources
- Compliance controls

### Step 3: Configure Deployment

1. Click **Add to project** or **Deploy**
2. Select or create a project
3. Configure required variables:
   - Region
   - Resource group
   - Prefix for resource names

### Step 4: Validate Configuration

1. Click **Validate**
2. Review validation results
3. Fix any errors

### Step 5: Deploy Architecture

1. Click **Deploy**
2. Monitor deployment progress (30-60 minutes typical)
3. Review logs for any issues

### Step 6: Verify Deployment

1. Check deployment status
2. Review outputs
3. Verify resources in IBM Cloud Console
4. Test connectivity if applicable

---

## 7. Creating Custom Deployable Architectures

### 7.1 Architecture Requirements

**Required Components:**
- Terraform modules (infrastructure code)
- `ibm_catalog.json` (catalog metadata)
- README.md (documentation)
- Architecture diagram

**Project Structure:**

```
my-deployable-architecture/
├── README.md
├── ibm_catalog.json
├── version.tf
├── variables.tf
├── main.tf
├── outputs.tf
└── modules/
    ├── vpc/
    ├── security/
    └── compute/
```

### 7.2 Example ibm_catalog.json

```json
{
  "products": [{
    "name": "my-custom-architecture",
    "label": "My Custom Architecture",
    "product_kind": "solution",
    "tags": ["vpc", "security"],
    "short_description": "A secure VPC architecture",
    "flavors": [{
      "label": "Standard",
      "name": "standard",
      "configuration": [{
        "key": "region",
        "type": "string",
        "required": true
      }]
    }]
  }]
}
```

---

## 8. Best Practices and Advanced Topics

### 8.1 Security Best Practices

**API Key Management:**
- Store keys in secure vaults (HashiCorp Vault, IBM Secrets Manager)
- Use service IDs for automation
- Rotate keys every 90 days
- Never commit keys to version control

**State File Security:**
- Always use remote state with encryption
- Enable state locking
- Restrict access to state files
- Use Schematics for managed state

**Resource Security:**
- Use private endpoints
- Enable encryption at rest and in transit
- Implement least privilege access
- Enable audit logging

### 8.2 State Management Strategies

**Remote State Configuration:**

```hcl
terraform {
  backend "s3" {
    bucket   = "terraform-state-bucket"
    key      = "production/terraform.tfstate"
    region   = "us-south"
    endpoint = "s3.us-south.cloud-object-storage.appdomain.cloud"
  }
}
```

**Important Commands:**

| Command | Purpose |
|---------|---------|
| `terraform state list` | List all resources |
| `terraform state show <resource>` | Show resource details |
| `terraform import` | Import existing resource |
| `terraform refresh` | Update state from cloud |

### 8.3 Module Development Best Practices

**Module Structure Best Practices:**
- Use semantic versioning
- Provide comprehensive documentation
- Include usage examples
- Implement input validation
- Use consistent naming conventions
- Provide sensible defaults

### 8.4 CI/CD Integration

**Basic GitHub Actions Example:**

```yaml
name: Terraform CI/CD

on:
  pull_request:
    branches: [ main ]
  push:
    branches: [ main ]

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        terraform_version: 1.5.0
    
    - name: Terraform Init
      run: terraform init
      env:
        IBM_CLOUD_API_KEY: ${{ secrets.IBM_CLOUD_API_KEY }}
    
    - name: Terraform Validate
      run: terraform validate
    
    - name: Terraform Plan
      run: terraform plan
      env:
        IBM_CLOUD_API_KEY: ${{ secrets.IBM_CLOUD_API_KEY }}
    
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'
      run: terraform apply -auto-approve
      env:
        IBM_CLOUD_API_KEY: ${{ secrets.IBM_CLOUD_API_KEY }}
```

### 8.5 Resource Optimization

**Strategies:**
- Tag resources for tracking and organization
- Use resource groups for allocation
- Right-size resources based on actual usage
- Implement auto-scaling where appropriate
- Use lifecycle policies for storage

### 8.6 Disaster Recovery

**Multi-Zone Deployment Example:**

```hcl
locals {
  zones = ["${var.region}-1", "${var.region}-2", "${var.region}-3"]
}

resource "ibm_is_subnet" "subnets" {
  for_each = toset(local.zones)
  
  name                     = "${var.prefix}-subnet-${each.key}"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = each.key
  total_ipv4_address_count = 256
}
```

---

## 9. Troubleshooting Common Issues

### Issue: Workspace Creation Fails

**Solutions:**
1. Verify repository is accessible
2. Check repository URL format: `https://github.com/user/repo`
3. For private repos, add personal access token

### Issue: Plan Fails with Authentication Error

**Solutions:**
1. Verify API key is valid
2. Check IAM permissions (need Editor role)
3. Ensure API key is marked as sensitive

### Issue: State Lock Timeout

**Solutions:**
1. Wait for other operations to complete
2. Check workspace activity log
3. Only use `force-unlock` if certain no operations are running

### Issue: Resource Already Exists

**Solutions:**
1. Import existing resource: `terraform import ibm_is_vpc.vpc <vpc-id>`
2. Use different resource name
3. Remove from state if not managed: `terraform state rm ibm_is_vpc.vpc`

### Issue: Drift Detected

**Solutions:**
1. Run `terraform refresh` to update state
2. Review changes with `terraform plan`
3. Apply to restore or update code to match reality
4. Use lifecycle `prevent_destroy` for critical resources

---

## 10. Workshop Summary 

### Key Takeaways

**Infrastructure as Code Fundamentals:**
- IaC enables consistent, repeatable infrastructure deployments
- Version control provides audit trail and rollback capability
- Automation reduces manual errors and deployment time
- Terraform is the industry standard for IaC

**IBM Cloud Schematics:**
- Fully managed Terraform service with no setup required
- Secure state management with encryption and locking
- Integrated with IBM Cloud IAM for access control
- Activity logging for compliance and audit

**Deployable Architectures:**
- Pre-validated infrastructure patterns for rapid deployment
- Built-in compliance and security controls
- Customizable through variations
- Catalog integration for easy discovery

**Best Practices:**
- Use remote state with encryption
- Implement proper secret management
- Modularize code for reusability
- Validate inputs and outputs
- Tag resources for tracking and organization
- Implement CI/CD for automation

---

## 11. Official Documentation and Resources

### Core Documentation

- [Getting Started with IBM Cloud Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-getting-started)
- [IBM Cloud Provider for Terraform](https://cloud.ibm.com/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-getting-started)
- [Schematics Workspaces](https://cloud.ibm.com/docs/schematics?topic=schematics-workspace-setup)

### Deployable Architectures

- [Understanding Deployable Architectures](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-understand-module-da)
- [Creating Deployable Architectures](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-create-da)
- [Creating Architecture Variations](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-create-variation-da)
- [Deployable Architecture Catalog](https://cloud.ibm.com/catalog?category=da)

### Terraform Resources

- [Terraform Registry - IBM Cloud Provider](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs)
- [IBM Cloud Terraform Modules](https://github.com/terraform-ibm-modules)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

### Security and Compliance

- [IAM for Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-access)
- [Securing Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-secure-data)
- [Activity Tracker Events](https://cloud.ibm.com/docs/schematics?topic=schematics-at_events)

### API and CLI References

- [Schematics API](https://cloud.ibm.com/apidocs/schematics)
- [IBM Cloud CLI - Schematics Plugin](https://cloud.ibm.com/docs/schematics?topic=schematics-schematics-cli-reference)
- [Terraform CLI](https://www.terraform.io/docs/cli/index.html)

### Community and Support

- [IBM Cloud Community](https://community.ibm.com/community/user/cloud/home)
- [Stack Overflow - IBM Cloud](https://stackoverflow.com/questions/tagged/ibm-cloud)
- [GitHub - IBM Cloud Terraform Provider](https://github.com/IBM-Cloud/terraform-provider-ibm)
- [IBM Cloud Support](https://cloud.ibm.com/unifiedsupport/supportcenter)

---

## Appendix A: Quick Reference Guide

### Terraform Command Cheat Sheet

| Command | Description |
|---------|-------------|
| `terraform init` | Initialize working directory |
| `terraform validate` | Validate configuration |
| `terraform plan` | Preview changes |
| `terraform apply` | Apply changes |
| `terraform destroy` | Destroy all resources |
| `terraform fmt` | Format code |
| `terraform state list` | List resources |
| `terraform output` | Show outputs |

### Common IBM Cloud Resources

| Resource Type | Terraform Resource | Use Case |
|---------------|-------------------|----------|
| VPC | `ibm_is_vpc` | Virtual network |
| Subnet | `ibm_is_subnet` | Network segment |
| Security Group | `ibm_is_security_group` | Firewall rules |
| Virtual Server | `ibm_is_instance` | Compute instance |
| Kubernetes | `ibm_container_vpc_cluster` | Container orchestration |
| Object Storage | `ibm_cos_bucket` | Object storage |
| Database | `ibm_database` | Managed database |

### Schematics Workspace States

| State | Description | Actions Available |
|-------|-------------|-------------------|
| `INACTIVE` | Workspace created, not initialized | Generate Plan |
| `DRAFT` | Plan generated | Apply, Destroy |
| `ACTIVE` | Resources deployed | Plan, Apply, Destroy |
| `FAILED` | Operation failed | Retry, Destroy |
| `LOCKED` | Operation in progress | Wait |

---

## Appendix B: Common Use Cases

### Use Case 1: Multi-Tier Web Application

**Scenario:** Deploy a production web application with load balancer, application servers, and database.

**Components:**
- Public subnet with load balancer
- Private subnet with application servers
- Database subnet with managed database

**Implementation:** Use a Deployable Architecture from the catalog or create custom modules for each tier.

### Use Case 2: Data Analytics Platform

**Scenario:** Build a data analytics platform with object storage and processing.

**Components:**
- Cloud Object Storage for data lake
- IBM Analytics Engine for processing
- Db2 Warehouse for analytics

### Use Case 3: Disaster Recovery Setup

**Scenario:** Implement cross-region disaster recovery.

**Strategy:**
- Primary region: us-south
- DR region: us-east
- Cross-region replication for data
- Automated DNS failover

### Use Case 4: Compliance-Ready Environment

**Scenario:** Deploy infrastructure meeting regulatory requirements (HIPAA, PCI-DSS).

**Requirements:**
- Encryption at rest and in transit
- Audit logging enabled
- Network isolation
- Access controls

**Implementation:** Use compliance-ready Deployable Architectures from the catalog.

---
