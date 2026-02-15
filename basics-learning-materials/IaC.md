
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
│  ┌──────────────────┐      ┌──────────────────────────────┐   │
│  │   Terraform      │◄─────┤  IBM Cloud Provider for      │   │
│  │   (Open Source)  │      │  Terraform                   │   │
│  └──────────────────┘      └──────────────────────────────┘   │
│           ▲                                                     │
│           │                                                     │
│  ┌────────┴─────────────────────────────────────────────────┐ │
│  │         IBM Cloud Schematics (Managed Service)           │ │
│  │  - Terraform execution environment                       │ │
│  │  - State management                                      │ │
│  │  - Workspace management                                  │ │
│  └──────────────────────────────────────────────────────────┘ │
│           ▲                                                     │
│           │                                                     │
│  ┌────────┴─────────────────────────────────────────────────┐ │
│  │         Deployable Architectures                         │ │
│  │  - Pre-validated infrastructure patterns                 │ │
│  │  - Compliance-ready templates                            │ │
│  │  - Enterprise governance                                 │ │
│  └──────────────────────────────────────────────────────────┘ │
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
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐ │
│  │  IBM Cloud   │  │  CLI/API     │  │  Terraform CLI       │ │
│  │  Console     │  │              │  │  (with Schematics)   │ │
│  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────┘ │
└─────────┼──────────────────┼──────────────────────┼─────────────┘
          │                  │                      │
          └──────────────────┼──────────────────────┘
                             ▼
          ┌─────────────────────────────────────────────────────┐
          │         IBM Cloud Schematics Service                │
          ├─────────────────────────────────────────────────────┤
          │                                                     │
          │  ┌──────────────────────────────────────────────┐ │
          │  │           Workspace Management               │ │
          │  │  - Configuration storage                     │ │
          │  │  - Variable management                       │ │
          │  │  - Version control integration               │ │
          │  └──────────────────────────────────────────────┘ │
          │                                                     │
          │  ┌──────────────────────────────────────────────┐ │
          │  │           Terraform Engine                   │ │
          │  │  - Plan execution                            │ │
          │  │  - Apply operations                          │ │
          │  │  - Destroy operations                        │ │
          │  └──────────────────────────────────────────────┘ │
          │                                                     │
          │  ┌──────────────────────────────────────────────┐ │
          │  │           State Management                   │ │
          │  │  - Encrypted state storage                   │ │
          │  │  - State locking                             │ │
          │  │  - State versioning                          │ │
          │  └──────────────────────────────────────────────┘ │
          │                                                     │
          │  ┌──────────────────────────────────────────────┐ │
          │  │           IAM Integration                    │ │
          │  │  - Access control                            │ │
          │  │  - Service authorization                     │ │
          │  │  - Audit logging                             │ │
          │  └──────────────────────────────────────────────┘ │
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
│  ┌─────────────────┐                                           │
│  │  Terraform      │                                           │
│  │  Operation      │                                           │
│  └────────┬────────┘                                           │
│           │                                                     │
│           ▼                                                     │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │         State Lock Acquisition                          │  │
│  │  - Prevents concurrent modifications                    │  │
│  │  - Ensures consistency                                  │  │
│  └─────────────────┬───────────────────────────────────────┘  │
│                    │                                           │
│                    ▼                                           │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │         Encrypted State Storage                         │  │
│  │  - AES-256 encryption at rest                           │  │
│  │  - TLS 1.2+ in transit                                  │  │
│  │  - IBM Key Protect integration                          │  │
│  └─────────────────┬───────────────────────────────────────┘  │
│                    │                                           │
│                    ▼                                           │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │         State Versioning                                │  │
│  │  - Automatic versioning                                 │  │
│  │  - Rollback capability                                  │  │
│  │  - Audit trail                                          │  │
│  └─────────────────────────────────────────────────────────┘  │
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

## 10. Workshop Summary and Next Steps

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

### Next Steps

**Beginner Level:**
1. Create your first Schematics workspace
2. Deploy a simple VPC with subnets
3. Practice the plan-apply-destroy workflow
4. Explore IBM Cloud Provider documentation

**Intermediate Level:**
1. Create reusable Terraform modules
2. Deploy a Deployable Architecture
3. Implement multi-environment strategy (dev/staging/prod)
4. Set up CI/CD pipeline for Terraform

**Advanced Level:**
1. Create custom Deployable Architecture
2. Implement advanced state management
3. Build compliance-ready architectures
4. Contribute to IBM Cloud Provider

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

**Document Version:** 1.0
**Last Updated:** 2026-02-15
**Maintained By:** IBM Cloud Technical Advocacy Team

---

*This document is part of the IBM Cloud Technical Training Advantage workshop series. For questions or feedback, please contact your workshop facilitator or visit the IBM Cloud Community.*
  name           = var.vpc_name
  resource_group = var.resource_group_id
  tags           = var.tags
}

# Root module usage
module "production_vpc" {
  source = "./modules/vpc"
  
  vpc_name          = "production-vpc"
  resource_group_id = ibm_resource_group.prod_rg.id
  tags              = ["env:production"]
}
```

---

## 4. Deployable Architectures

### 4.1 Understanding Deployable Architectures

**Deployable Architectures** are pre-validated, enterprise-ready infrastructure patterns that combine Terraform modules with governance controls, compliance policies, and best practices.

**Key Characteristics:**

- **Pre-validated:** Tested and verified by IBM
- **Compliance-ready:** Built-in security and governance controls
- **Customizable:** Configurable through input variables
- **Versioned:** Semantic versioning for stability
- **Documented:** Comprehensive documentation and examples

**Deployable Architecture vs. Terraform Module:**

```
┌─────────────────────────────────────────────────────────────────┐
│              Terraform Module vs Deployable Architecture        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Terraform Module                  Deployable Architecture      │
│  ┌──────────────────┐             ┌──────────────────────────┐ │
│  │ - Terraform code │             │ - Terraform modules      │ │
│  │ - Variables      │             │ - Compliance policies    │ │
│  │ - Outputs        │             │ - Security controls      │ │
│  │                  │             │ - Cost estimates         │ │
│  │                  │             │ - Architecture diagrams  │ │
│  │                  │             │ - Deployment validation  │ │
│  │                  │             │ - Version management     │ │
│  │                  │             │ - IBM support            │ │
│  └──────────────────┘             └──────────────────────────┘ │
│                                                                 │
│  Use Case:                         Use Case:                   │
│  - Custom infrastructure           - Enterprise deployments    │
│  - Flexible requirements           - Compliance requirements   │
│  - Learning/experimentation        - Production workloads      │
│                                    - Multi-account governance  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 Deployable Architecture Components

#### Architecture Layers

```
┌─────────────────────────────────────────────────────────────────┐
│            Deployable Architecture Structure                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Layer 1: Base Infrastructure                            │  │
│  │  - VPC, Subnets, Security Groups                         │  │
│  │  - Network ACLs, Public Gateways                         │  │
│  │  - Transit Gateway (multi-VPC)                           │  │
│  └──────────────────────────────────────────────────────────┘  │
│                          ▲                                      │
│                          │                                      │
│  ┌──────────────────────┴───────────────────────────────────┐  │
│  │  Layer 2: Platform Services                              │  │
│  │  - Kubernetes/OpenShift clusters                         │  │
│  │  - Databases (PostgreSQL, MongoDB, etc.)                 │  │
│  │  - Message queues, Event Streams                         │  │
│  └──────────────────────────────────────────────────────────┘  │
│                          ▲                                      │
│                          │                                      │
│  ┌──────────────────────┴───────────────────────────────────┐  │
│  │  Layer 3: Security & Observability                       │  │
│  │  - Key Protect, Secrets Manager                          │  │
│  │  - Activity Tracker, Log Analysis                        │  │
│  │  - Security and Compliance Center                        │  │
│  └──────────────────────────────────────────────────────────┘  │
│                          ▲                                      │
│                          │                                      │
│  ┌──────────────────────┴───────────────────────────────────┐  │
│  │  Layer 4: Application Layer                              │  │
│  │  - Application workloads                                 │  │
│  │  - CI/CD pipelines                                       │  │
│  │  - Custom configurations                                 │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 4.3 Types of Deployable Architectures

IBM Cloud provides several categories of Deployable Architectures:

#### 1. Foundation Architectures

Basic infrastructure patterns for common scenarios:

- **VPC Landing Zone:** Secure, compliant VPC infrastructure
- **Red Hat OpenShift on VPC:** Container platform deployment
- **VSI on VPC:** Virtual server infrastructure

#### 2. Solution Architectures

Complete application stacks:

- **Three-tier Web Application:** Web, app, and database tiers
- **Data Analytics Platform:** Big data processing infrastructure
- **DevOps Platform:** CI/CD and development tools

#### 3. Industry Architectures

Compliance-focused patterns:

- **Financial Services Cloud:** FFIEC-compliant infrastructure
- **Healthcare Workloads:** HIPAA-ready environments
- **Government Cloud:** FedRAMP-aligned deployments

### 4.4 Deployable Architecture Variations

**Variations** allow you to customize a Deployable Architecture for different use cases while maintaining compliance and best practices.

**Variation Hierarchy:**

```
┌─────────────────────────────────────────────────────────────────┐
│              Deployable Architecture Variations                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Base Architecture: VPC Landing Zone                            │
│  └─────────────────────────────────────────────────────────┐   │
│                                                             │   │
│      Variation 1: Standard                                  │   │
│      ├─ 3 zones                                             │   │
│      ├─ Standard security                                   │   │
│      └─ Basic monitoring                                    │   │
│                                                             │   │
│      Variation 2: QuickStart                                │   │
│      ├─ 1 zone                                              │   │
│      ├─ Minimal security                                    │   │
│      └─ Development use                                     │   │
│                                                             │   │
│      Variation 3: Financial Services                        │   │
│      ├─ 3 zones with HA                                     │   │
│      ├─ Enhanced security controls                          │   │
│      ├─ Compliance monitoring                               │   │
│      └─ Audit logging                                       │   │
│                                                             │   │
└─────────────────────────────────────────────────────────────────┘
```

**When to Create a Variation:**

- Different compliance requirements (e.g., HIPAA vs. PCI-DSS)
- Different scale requirements (dev vs. production)
- Different regional deployments
- Different cost optimization strategies

---

## 5. Step-by-Step Workshop: Getting Started with Schematics

### Step 1: Create Your First Schematics Workspace

**Prerequisites:**
- IBM Cloud account with appropriate permissions
- GitHub repository with Terraform configuration (or use IBM samples)

**1.1 Navigate to Schematics:**

1. Log in to [IBM Cloud Console](https://cloud.ibm.com)
2. Click the **Navigation Menu** (☰) in the top-left
3. Select **Schematics** under "DevOps"
4. Click **Workspaces** in the left navigation

**1.2 Create Workspace:**

1. Click **Create workspace** button
2. Fill in workspace details:

| Field | Value | Description |
|-------|-------|-------------|
| **Workspace name** | `my-first-workspace` | Unique identifier for your workspace |
| **Tags** | `tutorial`, `vpc` | Optional tags for organization |
| **Resource group** | Select your resource group | Where workspace metadata is stored |
| **Location** | Select region | Where Schematics executes Terraform |

3. Click **Next**

**1.3 Configure Repository:**

You can use IBM's sample VPC repository for this tutorial:

| Field | Value |
|-------|-------|
| **Repository URL** | `https://github.com/IBM-Cloud/terraform-ibm-vpc` |
| **Personal access token** | Leave empty for public repos |
| **Terraform version** | `terraform_v1.5` (or latest) |

4. Click **Next**

**1.4 Review and Create:**

1. Review your workspace configuration
2. Click **Create** to create the workspace

**Expected Result:**
```
Workspace created successfully
Repository cloned
Terraform configuration loaded
```

### Step 2: Configure Workspace Variables

**2.1 Navigate to Variables:**

1. In your workspace, click the **Settings** tab
2. Scroll to the **Variables** section

**2.2 Add Required Variables:**

For the VPC example, add these variables:

| Variable Name | Type | Value | Sensitive |
|--------------|------|-------|-----------|
| `ibmcloud_api_key` | string | Your API key | Yes |
| `region` | string | `us-south` | No |
| `resource_group` | string | `Default` | No |
| `vpc_name` | string | `tutorial-vpc` | No |

**To add a variable:**
1. Click **Add variable**
2. Enter variable name
3. Enter value
4. Check **Sensitive** if needed (for API keys, passwords)
5. Click **Save**

**2.3 Verify Configuration:**

Ensure all required variables are set before proceeding.

### Step 3: Generate and Review Terraform Plan

**3.1 Generate Plan:**

1. Click the **Actions** dropdown in the top-right
2. Select **Generate plan**
3. Click **Generate plan** in the confirmation dialog

**3.2 Monitor Execution:**

The **Activity** tab shows real-time logs:

```
Initializing Terraform...
Terraform has been successfully initialized!

Refreshing Terraform state...

Terraform will perform the following actions:

  # ibm_is_vpc.example_vpc will be created
  + resource "ibm_is_vpc" "example_vpc" {
      + name                      = "tutorial-vpc"
      + resource_group            = "abc123..."
      + status                    = (known after apply)
      ...
    }

Plan: 5 to add, 0 to change, 0 to destroy.
```

**3.3 Review Plan Output:**

Key things to check:
- **Resources to be created:** Verify the list matches expectations
- **No unexpected deletions:** Ensure no resources will be destroyed
- **Cost estimate:** Review estimated monthly cost (if available)
- **Errors or warnings:** Address any issues before applying

**Expected Duration:** 1-3 minutes

### Step 4: Apply Terraform Configuration

**4.1 Apply Plan:**

1. After reviewing the plan, click **Actions** → **Apply plan**
2. Review the confirmation dialog
3. Click **Apply plan** to provision resources

**4.2 Monitor Provisioning:**

Watch the Activity log for progress:

```
Applying Terraform configuration...

ibm_resource_group.example_rg: Creating...
ibm_resource_group.example_rg: Creation complete after 2s

ibm_is_vpc.example_vpc: Creating...
ibm_is_vpc.example_vpc: Still creating... [10s elapsed]
ibm_is_vpc.example_vpc: Creation complete after 15s

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:
vpc_id = "r006-abc123..."
vpc_crn = "crn:v1:bluemix:public:is:us-south:..."
```

**Expected Duration:** 5-15 minutes (depending on resources)

**4.3 Verify Resources:**

1. Navigate to **VPC Infrastructure** → **VPCs** in IBM Cloud Console
2. Verify your VPC was created: `tutorial-vpc`
3. Check associated resources (subnets, security groups, etc.)

### Step 5: View Outputs and State

**5.1 View Outputs:**

1. In your workspace, click the **Outputs** tab
2. Review exported values:

```json
{
  "vpc_id": "r006-abc123...",
  "vpc_crn": "crn:v1:bluemix:public:is:us-south:...",
  "default_security_group_id": "r006-def456..."
}
```

**5.2 Inspect State:**

1. Click the **Resources** tab
2. View all managed resources and their current state
3. Click on individual resources to see detailed attributes

**State Information Includes:**
- Resource type and name
- Current status
- All attributes and values
- Dependencies between resources

### Step 6: Update Infrastructure

**6.1 Modify Variables:**

Let's add tags to our VPC:

1. Go to **Settings** → **Variables**
2. Add new variable:
   - Name: `tags`
   - Type: `list(string)`
   - Value: `["environment:tutorial", "managed-by:schematics"]`
3. Click **Save**

**6.2 Generate New Plan:**

1. Click **Actions** → **Generate plan**
2. Review the changes:

```
Terraform will perform the following actions:

  # ibm_is_vpc.example_vpc will be updated in-place
  ~ resource "ibm_is_vpc" "example_vpc" {
      ~ tags = [] -> ["environment:tutorial", "managed-by:schematics"]
        ...
    }

Plan: 0 to add, 1 to change, 0 to destroy.
```

**6.3 Apply Changes:**

1. Click **Actions** → **Apply plan**
2. Confirm the update
3. Monitor the activity log

**Result:** VPC tags updated without recreating the resource.

### Step 7: Destroy Infrastructure (Cleanup)

**Warning:** This will delete all resources managed by this workspace.

**7.1 Destroy Resources:**

1. Click **Actions** → **Destroy resources**
2. Type the workspace name to confirm: `my-first-workspace`
3. Click **Destroy**

**7.2 Monitor Destruction:**

```
Destroying resources...

ibm_is_subnet.example_subnet: Destroying...
ibm_is_subnet.example_subnet: Destruction complete after 30s

ibm_is_vpc.example_vpc: Destroying...
ibm_is_vpc.example_vpc: Destruction complete after 45s

Destroy complete! Resources: 5 destroyed.
```

**7.3 Delete Workspace (Optional):**

1. Click **Actions** → **Delete workspace**
2. Confirm deletion
3. Workspace and its state are permanently removed

---

## 6. Step-by-Step Workshop: Deploying a Deployable Architecture

### Step 1: Browse the Catalog

**1.1 Access Deployable Architectures:**

1. Log in to [IBM Cloud Console](https://cloud.ibm.com)
2. Click **Catalog** in the top navigation
3. In the left sidebar, under **Type**, select **Deployable architectures**

**1.2 Explore Available Architectures:**

You'll see categories like:
- **Compute:** VPC, VSI, Kubernetes
- **Networking:** VPC Landing Zone, Transit Gateway
- **Security:** Key Protect, Secrets Manager
- **Data:** Databases, Analytics platforms

**1.3 Select an Architecture:**

For this tutorial, select **VPC landing zone - Standard variation**

### Step 2: Review Architecture Details

**2.1 Architecture Overview:**

Review the architecture page:

| Section | Information |
|---------|-------------|
| **Overview** | Architecture description and use cases |
| **Architecture diagram** | Visual representation of components |
| **Deployment values** | Required and optional input variables |
| **Outputs** | Values exported after deployment |
| **Dependencies** | Required services and permissions |
| **Compliance** | Security and compliance controls |

**2.2 Review Architecture Diagram:**

```
┌─────────────────────────────────────────────────────────────────┐
│              VPC Landing Zone Architecture                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Region: us-south                                               │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Management VPC                                          │  │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐        │  │
│  │  │  Zone 1    │  │  Zone 2    │  │  Zone 3    │        │  │
│  │  │  Subnet    │  │  Subnet    │  │  Subnet    │        │  │
│  │  └────────────┘  └────────────┘  └────────────┘        │  │
│  │  - Bastion host                                         │  │
│  │  - VPN gateway                                          │  │
│  │  - Activity Tracker                                     │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Workload VPC                                            │  │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐        │  │
│  │  │  Zone 1    │  │  Zone 2    │  │  Zone 3    │        │  │
│  │  │  Subnet    │  │  Subnet    │  │  Subnet    │        │  │
│  │  └────────────┘  └────────────┘  └────────────┘        │  │
│  │  - Application workloads                                │  │
│  │  - Load balancers                                       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
│  Security Services:                                             │
│  - Key Protect (encryption keys)                                │
│  - Secrets Manager (credentials)                                │
│  - Security and Compliance Center                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**2.3 Review Compliance Controls:**

The architecture includes:
- Network isolation and segmentation
- Encryption at rest and in transit
- Activity logging and monitoring
- Access control policies
- Security group rules

### Step 3: Configure Deployment

**3.1 Start Configuration:**

1. Click **Review deployment options**
2. Select **Add to project** (recommended for governance)
   - Or select **Deploy** for direct deployment

**3.2 Create or Select Project:**

If using projects (recommended):

1. Click **Create project**
2. Enter project details:
   - **Name:** `landing-zone-project`
   - **Description:** `VPC landing zone for production workloads`
   - **Region:** `us-south`
3. Click **Create**

**3.3 Configure Architecture:**

Fill in required deployment values:

| Parameter | Value | Description |
|-----------|-------|-------------|
| **prefix** | `prod` | Prefix for all resource names |
| **region** | `us-south` | Deployment region |
| **resource_group** | Select existing | Resource group for resources |
| **ssh_public_key** | Your SSH key | For bastion host access |

**Optional Parameters:**

| Parameter | Default | Description |
|-----------|---------|-------------|
| **enable_transit_gateway** | `true` | Connect VPCs |
| **create_f5_network_on_management_vpc** | `false` | F5 BIG-IP integration |
| **provision_teleport_in_f5** | `false` | Teleport bastion |

**3.4 Configure Security:**

1. Scroll to **Security** section
2. Configure:
   - **Key management:** Select Key Protect instance
   - **Secrets management:** Select Secrets Manager instance
   - **Activity tracking:** Select Activity Tracker instance

### Step 4: Validate Configuration

**4.1 Run Validation:**

1. Click **Validate** button
2. Schematics performs pre-deployment checks:
   - Terraform syntax validation
   - Required permissions check
   - Resource quota verification
   - Compliance policy evaluation

**4.2 Review Validation Results:**

```
Terraform configuration is valid
Required IAM permissions are present
Resource quotas are sufficient
Compliance policies passed
No conflicts with existing resources

Validation successful! Ready to deploy.
```

**4.3 Address Any Issues:**

If validation fails:
- Review error messages
- Update configuration as needed
- Re-run validation

### Step 5: Deploy Architecture

**5.1 Approve and Deploy:**

1. Review the deployment summary
2. Click **Deploy**
3. Confirm deployment in the dialog

**5.2 Monitor Deployment:**

The deployment progresses through stages:

```
Stage 1: Base Infrastructure (10-15 min)
├─ Creating resource groups
├─ Creating VPCs
├─ Creating subnets
└─ Configuring security groups

Stage 2: Security Services (5-10 min)
├─ Provisioning Key Protect
├─ Creating encryption keys
├─ Configuring Secrets Manager
└─ Setting up Activity Tracker

Stage 3: Network Services (10-15 min)
├─ Creating VPN gateway
├─ Configuring transit gateway
├─ Setting up public gateways
└─ Configuring routing tables

Stage 4: Compute Resources (5-10 min)
├─ Provisioning bastion host
├─ Configuring SSH access
└─ Installing monitoring agents

Stage 5: Validation (2-5 min)
├─ Running compliance checks
├─ Verifying connectivity
└─ Testing security controls

Total Estimated Time: 30-55 minutes
```

**5.3 View Real-Time Logs:**

Click **View logs** to see detailed Terraform output:

```
[2024-01-15 10:30:15] Initializing Terraform...
[2024-01-15 10:30:20] Creating ibm_resource_group.management_rg...
[2024-01-15 10:30:25] Creating ibm_is_vpc.management_vpc...
[2024-01-15 10:30:40] Creating ibm_is_subnet.management_subnet_zone_1...
...
```

### Step 6: Verify Deployment

**6.1 Check Deployment Status:**

Once complete, you'll see:

```
Deployment successful!
All resources created
Compliance checks passed
Architecture is ready for use

Resources Created: 47
Time Elapsed: 42 minutes
```

**6.2 Review Outputs:**

Navigate to the **Outputs** tab:

```json
{
  "management_vpc_id": "r006-abc123...",
  "workload_vpc_id": "r006-def456...",
  "bastion_host_ip": "169.xx.xx.xx",
  "vpn_gateway_ip": "169.yy.yy.yy",
  "key_protect_instance_id": "abc-123-def-456",
  "transit_gateway_id": "tg-abc123..."
}
```

**6.3 Verify Resources:**

1. Navigate to **VPC Infrastructure** in IBM Cloud Console
2. Verify VPCs were created:
   - `prod-management-vpc`
   - `prod-workload-vpc`
3. Check subnets in each zone
4. Verify security groups and ACLs

**6.4 Test Connectivity:**

1. SSH to bastion host using the output IP:
   ```bash
   ssh -i ~/.ssh/id_rsa root@169.xx.xx.xx
   ```

2. Verify VPN connectivity (if configured)

3. Check Activity Tracker for deployment events

### Step 7: Manage and Update

**7.1 View Architecture in Project:**

1. Navigate to **Projects** in IBM Cloud Console
2. Select your project: `landing-zone-project`
3. View deployed architectures and their status

**7.2 Update Configuration:**

To modify the deployment:

1. Click **Edit configuration**
2. Update variables (e.g., add more subnets)
3. Click **Validate**
4. Click **Apply changes**

**7.3 Monitor Compliance:**

1. Navigate to **Security and Compliance Center**
2. View compliance posture for your architecture
3. Review any security findings
4. Remediate issues as needed

---

## 7. Creating Custom Deployable Architectures

### 7.1 Architecture Requirements

To create a Deployable Architecture, you need:

**Required Components:**

1. **Terraform Modules:** Infrastructure code
2. **ibm_catalog.json:** Catalog metadata
3. **README.md:** Documentation
4. **Architecture Diagram:** Visual representation
5. **Compliance Controls:** Security policies

**Optional Components:**

- **Variations:** Different deployment options
- **Examples:** Sample configurations
- **Tests:** Automated validation
- **Cost Estimates:** Pricing information

### 7.2 Project Structure

```
my-deployable-architecture/
├── README.md                          # Main documentation
├── ibm_catalog.json                   # Catalog metadata
├── version.tf                         # Terraform version constraints
├── variables.tf                       # Input variables
├── main.tf                            # Main Terraform configuration
├── outputs.tf                         # Output values
├── modules/                           # Reusable modules
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── examples/                          # Example configurations
│   ├── basic/
│   │   └── main.tf
│   └── advanced/
│       └── main.tf
├── tests/                             # Automated tests
│   └── pr_test.go
└── diagrams/                          # Architecture diagrams
    └── architecture.png
```

### 7.3 Creating ibm_catalog.json

The `ibm_catalog.json` file defines how your architecture appears in the IBM Cloud catalog:

```json
{
  "products": [
    {
      "name": "my-custom-architecture",
      "label": "My Custom Architecture",
      "product_kind": "solution",
      "tags": ["vpc", "security", "terraform"],
      "keywords": ["infrastructure", "automation"],
      "short_description": "A secure, compliant VPC architecture",
      "long_description": "This architecture provides a production-ready VPC with security controls...",
      "offering_docs_url": "https://github.com/myorg/my-architecture/blob/main/README.md",
      "offering_icon_url": "https://raw.githubusercontent.com/myorg/my-architecture/main/icon.svg",
      "provider_name": "IBM",
      "features": [
        {
          "title": "Secure by Default",
          "description": "Built-in security controls and compliance policies"
        },
        {
          "title": "High Availability",
          "description": "Multi-zone deployment for resilience"
        }
      ],
      "flavors": [
        {
          "label": "Standard",
          "name": "standard",
          "working_directory": "solutions/standard",
          "architecture": {
            "descriptions": "Standard deployment with 3 zones",
            "features": [
              {
                "title": "VPC Infrastructure",
                "description": "Multi-zone VPC with subnets"
              }
            ],
            "diagrams": [
              {
                "diagram": {
                  "url": "https://raw.githubusercontent.com/myorg/my-architecture/main/diagrams/standard.svg",
                  "caption": "Standard Architecture Diagram"
                }
              }
            ]
          },
          "configuration": [
            {
              "key": "region",
              "type": "string",
              "required": true,
              "description": "IBM Cloud region for deployment"
            },
            {
              "key": "prefix",
              "type": "string",
              "required": true,
              "description": "Prefix for resource names"
            }
          ],
          "iam_permissions": [
            {
              "service_name": "is",
              "role_crns": [
                "crn:v1:bluemix:public:iam::::role:Editor"
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

### 7.4 Defining Variables with Validation

```hcl
# variables.tf
variable "region" {
  description = "IBM Cloud region where resources will be created"
  type        = string
  validation {
    condition     = can(regex("^(us-south|us-east|eu-gb|eu-de|jp-tok|au-syd)$", var.region))

    error_message = "Region must be a valid IBM Cloud region."
  }
}

variable "resource_group" {
  description = "Resource group name for all resources"
  type        = string
  default     = "Default"
}

variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z][-a-z0-9]*$", var.prefix))
    error_message = "Prefix must start with a lowercase letter and contain only lowercase letters, numbers, and hyphens."
  }
  
  validation {
    condition     = length(var.prefix) <= 20
    error_message = "Prefix must be 20 characters or less."
  }
}

variable "tags" {
  description = "List of tags to apply to all resources"
  type        = list(string)
  default     = []
  
  validation {
    condition     = alltrue([for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag))])
    error_message = "Tags must contain only letters, numbers, colons, underscores, and hyphens."
  }
}
```

---

## 8. Best Practices and Advanced Topics

### 8.1 Security Best Practices

**API Key Management:**
- Store API keys in secure vaults (HashiCorp Vault, IBM Secrets Manager)
- Use service IDs for automation instead of personal API keys
- Rotate keys regularly (every 90 days minimum)
- Never commit keys to version control
- Use separate keys for different environments

**State File Security:**
- Always use remote state with encryption
- Enable state locking to prevent concurrent modifications
- Restrict access to state files (contains sensitive data)
- Use Schematics or Terraform Cloud for managed state
- Regularly backup state files

**Resource Security:**
- Use private endpoints for sensitive services
- Enable encryption at rest and in transit
- Implement least privilege access with IAM
- Use Context-Based Restrictions (CBR) for network isolation
- Enable audit logging with Activity Tracker

**Example: Secure Provider Configuration**
```hcl
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key  # From secure vault
  region           = var.region
  
  # Use private endpoints for enhanced security
  visibility = "private"
}

# Enable encryption for resources
resource "ibm_cos_bucket" "secure_bucket" {
  bucket_name          = "${var.prefix}-secure-bucket"
  resource_instance_id = ibm_resource_instance.cos.id
  region_location      = var.region
  storage_class        = "standard"
  
  # Enable encryption with Key Protect
  key_protect = ibm_kms_key.bucket_key.id
  
  # Enable activity tracking
  activity_tracking {
    read_data_events     = true
    write_data_events    = true
    activity_tracker_crn = ibm_resource_instance.activity_tracker.id
  }
}
```

### 8.2 State Management Strategies

**Remote State Configuration:**

```hcl
# backend.tf - Using IBM Cloud Object Storage for state
terraform {
  backend "s3" {
    bucket                      = "terraform-state-bucket"
    key                         = "production/terraform.tfstate"
    region                      = "us-south"
    endpoint                    = "s3.us-south.cloud-object-storage.appdomain.cloud"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}
```

**State Locking:**
- Schematics provides automatic state locking
- For local Terraform, use DynamoDB or similar for locking
- Always enable locking in team environments
- Handle lock timeouts gracefully

**State Management Commands:**

| Command | Purpose | Use Case |
|---------|---------|----------|
| `terraform state list` | List all resources in state | Inventory check |
| `terraform state show <resource>` | Show resource details | Debugging |
| `terraform state mv` | Move resource in state | Refactoring |
| `terraform state rm` | Remove resource from state | Manual cleanup |
| `terraform import` | Import existing resource | Adopt existing infrastructure |
| `terraform refresh` | Update state from real infrastructure | Detect drift |

### 8.3 Module Development Best Practices

**Module Structure:**

```
terraform-ibm-vpc-module/
├── README.md                 # Comprehensive documentation
├── versions.tf               # Provider version constraints
├── variables.tf              # Input variables with validation
├── main.tf                   # Core resource definitions
├── outputs.tf                # Output values
├── examples/                 # Usage examples
│   ├── basic/
│   │   ├── main.tf
│   │   └── README.md
│   └── advanced/
│       ├── main.tf
│       └── README.md
├── modules/                  # Sub-modules
│   ├── subnets/
│   └── security-groups/
└── tests/                    # Automated tests
    └── integration/
```

**Module Best Practices:**
- Use semantic versioning (v1.0.0, v1.1.0, etc.)
- Provide comprehensive documentation
- Include usage examples
- Implement input validation
- Use consistent naming conventions
- Minimize required variables
- Provide sensible defaults
- Document all outputs
- Include automated tests

**Example: Well-Structured Module**

```hcl
# modules/vpc/variables.tf
variable "name" {
  description = "Name of the VPC. Must be unique within the account."
  type        = string
  
  validation {
    condition     = can(regex("^[a-z][-a-z0-9]*$", var.name))
    error_message = "Name must start with a lowercase letter and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "resource_group_id" {
  description = "ID of the resource group where the VPC will be created."
  type        = string
}

variable "address_prefixes" {
  description = "Map of address prefixes by zone. Keys are zone names, values are CIDR blocks."
  type        = map(string)
  default     = {}
  
  validation {
    condition     = alltrue([for cidr in values(var.address_prefixes) : can(cidrhost(cidr, 0))])
    error_message = "All address prefixes must be valid CIDR blocks."
  }
}

variable "tags" {
  description = "List of tags to apply to the VPC."
  type        = list(string)
  default     = []
}

# modules/vpc/main.tf
resource "ibm_is_vpc" "vpc" {
  name                      = var.name
  resource_group            = var.resource_group_id
  address_prefix_management = length(var.address_prefixes) > 0 ? "manual" : "auto"
  tags                      = var.tags
}

resource "ibm_is_vpc_address_prefix" "prefix" {
  for_each = var.address_prefixes
  
  name = "${var.name}-${each.key}-prefix"
  zone = each.key
  vpc  = ibm_is_vpc.vpc.id
  cidr = each.value
}

# modules/vpc/outputs.tf
output "vpc_id" {
  description = "ID of the created VPC"
  value       = ibm_is_vpc.vpc.id
}

output "vpc_crn" {
  description = "CRN of the created VPC"
  value       = ibm_is_vpc.vpc.crn
}

output "default_security_group_id" {
  description = "ID of the default security group"
  value       = ibm_is_vpc.vpc.default_security_group
}

output "address_prefixes" {
  description = "Map of created address prefixes"
  value       = { for k, v in ibm_is_vpc_address_prefix.prefix : k => v.cidr }
}
```

### 8.4 CI/CD Integration

**GitLab CI/CD Example:**

```yaml
# .gitlab-ci.yml
stages:
  - validate
  - plan
  - apply

variables:
  TF_VERSION: "1.5.0"
  SCHEMATICS_WORKSPACE_ID: "your-workspace-id"

validate:
  stage: validate
  image: hashicorp/terraform:$TF_VERSION
  script:
    - terraform init -backend=false
    - terraform validate
    - terraform fmt -check
  only:
    - merge_requests
    - main

plan:
  stage: plan
  script:
    - |
      curl -X POST \
        "https://schematics.cloud.ibm.com/v1/workspaces/${SCHEMATICS_WORKSPACE_ID}/plan" \
        -H "Authorization: Bearer ${IBM_CLOUD_API_KEY}" \
        -H "Content-Type: application/json"
  only:
    - merge_requests
    - main

apply:
  stage: apply
  script:
    - |
      curl -X PUT \
        "https://schematics.cloud.ibm.com/v1/workspaces/${SCHEMATICS_WORKSPACE_ID}/apply" \
        -H "Authorization: Bearer ${IBM_CLOUD_API_KEY}" \
        -H "Content-Type: application/json"
  only:
    - main
  when: manual
```

**GitHub Actions Example:**

```yaml
# .github/workflows/terraform.yml
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
    
    - name: Terraform Format Check
      run: terraform fmt -check
    
    - name: Terraform Plan
      run: terraform plan -no-color
      env:
        IBM_CLOUD_API_KEY: ${{ secrets.IBM_CLOUD_API_KEY }}
    
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main' && github.event_name == 'push'
      run: terraform apply -auto-approve
      env:
        IBM_CLOUD_API_KEY: ${{ secrets.IBM_CLOUD_API_KEY }}
```

### 8.5 Resource Optimization

**Optimization Strategies:**

1. **Right-Sizing Resources:**
   - Use appropriate instance profiles based on workload requirements
   - Monitor resource utilization and adjust as needed
   - Use variables for flexibility

2. **Lifecycle Policies:**
   - Implement automatic data archival for infrequently accessed data
   - Set expiration policies for temporary data
   - Use appropriate storage classes

3. **Auto-Scaling:**
   - Enable auto-scaling for variable workloads
   - Set appropriate minimum and maximum thresholds
   - Monitor scaling metrics

### 8.6 Disaster Recovery and High Availability

**Multi-Zone Deployment:**

```hcl
# Deploy across multiple zones for HA
locals {
  zones = ["${var.region}-1", "${var.region}-2", "${var.region}-3"]
}

resource "ibm_is_subnet" "subnets" {
  for_each = toset(local.zones)
  
  name            = "${var.prefix}-subnet-${each.key}"
  vpc             = ibm_is_vpc.vpc.id
  zone            = each.key
  ipv4_cidr_block = cidrsubnet("10.240.0.0/16", 8, index(local.zones, each.key))
  resource_group  = data.ibm_resource_group.group.id
}

resource "ibm_is_lb" "load_balancer" {
  name            = "${var.prefix}-lb"
  subnets         = [for subnet in ibm_is_subnet.subnets : subnet.id]
  resource_group  = data.ibm_resource_group.group.id
  type            = "public"
}
```

**Cross-Region Replication:**

```hcl
# Primary region bucket
resource "ibm_cos_bucket" "primary" {
  bucket_name          = "${var.prefix}-primary"
  resource_instance_id = ibm_resource_instance.cos.id
  region_location      = "us-south"
  storage_class        = "standard"
}

# DR region bucket
resource "ibm_cos_bucket" "dr" {
  bucket_name          = "${var.prefix}-dr"
  resource_instance_id = ibm_resource_instance.cos.id
  region_location      = "us-east"
  storage_class        = "standard"
}

# Replication rule
resource "ibm_cos_bucket_replication_rule" "replication" {
  bucket_crn      = ibm_cos_bucket.primary.crn
  bucket_location = "us-south"
  
  replication_rule {
    rule_id  = "dr-replication"
    enable   = true
    priority = 1
    
    destination_bucket_crn = ibm_cos_bucket.dr.crn
  }
}
```

---

## 9. Troubleshooting Common Issues

### Issue: Workspace Creation Fails

**Symptoms:**
- Error: "Failed to clone repository"
- Error: "Invalid repository URL"

**Solutions:**
1. **Verify Repository Access:**
   - Ensure repository is accessible (public or with valid token)
   - Check branch name is correct
   - Verify folder path if specified

2. **Check Repository Format:**
   ```
   Correct: https://github.com/user/repo
   Wrong: git@github.com:user/repo.git
   ```

3. **Personal Access Token:**
   - For private repos, generate token with `repo` scope
   - Add token in workspace settings
   - Ensure token hasn't expired

### Issue: Plan Fails with Authentication Error

**Symptoms:**
- Error: "Error: authentication failed"
- Error: "Invalid API key"

**Solutions:**
1. **Verify API Key:**
   - Check API key is valid and not expired
   - Ensure API key has sufficient permissions
   - Verify key is marked as sensitive in variables

2. **Check IAM Permissions:**
   ```
   Required permissions:
   - Viewer on resource group
   - Editor on target services (VPC, COS, etc.)
   - Operator on Schematics service
   ```

3. **Test API Key:**
   ```bash
   ibmcloud login --apikey <your-api-key>
   ibmcloud resource groups
   ```

### Issue: State Lock Timeout

**Symptoms:**
- Error: "Error acquiring the state lock"
- Error: "Lock Info: ID: ..."

**Solutions:**
1. **Wait for Lock Release:**
   - Another operation may be in progress
   - Wait 5-10 minutes and retry

2. **Force Unlock (Caution):**
   ```bash
   # Only if you're certain no other operation is running
   terraform force-unlock <lock-id>
   ```

3. **Check Workspace Activity:**
   - Review activity log for stuck operations
   - Cancel any hung operations in Schematics UI

### Issue: Resource Already Exists

**Symptoms:**
- Error: "Resource already exists"
- Error: "Name already in use"

**Solutions:**
1. **Import Existing Resource:**
   ```bash
   terraform import ibm_is_vpc.vpc <vpc-id>
   ```

2. **Use Different Name:**
   ```hcl
   variable "vpc_name" {
     default = "my-vpc-v2"  # Use unique name
   }
   ```

3. **Remove from State:**
   ```bash
   # If resource should not be managed
   terraform state rm ibm_is_vpc.vpc
   ```

### Issue: Drift Detected

**Symptoms:**
- Plan shows unexpected changes
- Resources modified outside Terraform

**Solutions:**
1. **Refresh State:**
   ```bash
   terraform refresh
   ```

2. **Review Changes:**
   ```bash
   terraform plan
   # Review what changed and why
   ```

3. **Reconcile Drift:**
   - Option A: Apply to restore Terraform state
   - Option B: Update Terraform code to match reality
   - Option C: Import changes into state

4. **Prevent Future Drift:**
   - Use lifecycle `prevent_destroy` for critical resources
   - Implement change management policies
   - Use Schematics for all infrastructure changes

### Issue: Module Version Conflicts

**Symptoms:**
- Error: "Module version constraint not satisfied"
- Error: "No matching version found"

**Solutions:**
1. **Update Version Constraints:**
   ```hcl
   module "vpc" {
     source  = "terraform-ibm-modules/vpc/ibm"
     version = "~> 1.0"  # Allow minor updates
   }
   ```

2. **Lock Versions:**
   ```bash
   terraform init -upgrade
   # Creates .terraform.lock.hcl
   ```

3. **Check Module Registry:**
   - Verify module exists at specified version
   - Check for breaking changes in release notes

---

## 10. Workshop Summary and Next Steps

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

### Next Steps

**Beginner Level:**
1. Create your first Schematics workspace
2. Deploy a simple VPC with subnets
3. Practice the plan-apply-destroy workflow
4. Explore IBM Cloud Provider documentation

**Intermediate Level:**
1. Create reusable Terraform modules
2. Deploy a Deployable Architecture
3. Implement multi-environment strategy (dev/staging/prod)
4. Set up CI/CD pipeline for Terraform

**Advanced Level:**
1. Create custom Deployable Architecture
2. Implement advanced state management
3. Build compliance-ready architectures
4. Contribute to IBM Cloud Provider

### Recommended Learning Path

**Week 1-2: Foundations**
- Complete Terraform basics tutorial
- Understand HCL syntax
- Learn IBM Cloud Provider resources
- Practice with simple deployments

**Week 3-4: Schematics Mastery**
- Create multiple workspaces
- Manage state effectively
- Implement variable strategies
- Practice drift detection and remediation

**Week 5-6: Deployable Architectures**
- Deploy pre-built architectures
- Customize variations
- Understand compliance controls
- Create simple custom architecture

**Week 7-8: Production Readiness**
- Implement security best practices
- Set up CI/CD pipelines
- Create disaster recovery strategy
- Establish resource optimization practices

---

## 11. Official Documentation and Resources

### Core Documentation

- [Getting Started with IBM Cloud Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-getting-started)
- [IBM Cloud Provider for Terraform](https://cloud.ibm.com/docs/ibm-cloud-provider-for-terraform?topic=ibm-cloud-provider-for-terraform-getting-started)
- [Schematics Workspaces](https://cloud.ibm.com/docs/schematics?topic=schematics-workspace-setup)
- [Schematics Actions](https://cloud.ibm.com/docs/schematics?topic=schematics-action-setup)

### Deployable Architectures

- [Understanding Deployable Architectures](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-understand-module-da)
- [Creating Deployable Architectures](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-create-da)
- [Creating Architecture Variations](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-create-variation-da)
- [Deployable Architecture Catalog](https://cloud.ibm.com/catalog?category=da)

### Terraform Resources

- [Terraform Registry - IBM Cloud Provider](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs)
- [IBM Cloud Terraform Modules](https://github.com/terraform-ibm-modules)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [HCL Configuration Language](https://www.terraform.io/docs/language/index.html)

### Security and Compliance

- [IAM for Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-access)
- [Securing Schematics](https://cloud.ibm.com/docs/schematics?topic=schematics-secure-data)
- [Activity Tracker Events](https://cloud.ibm.com/docs/schematics?topic=schematics-at_events)
- [Compliance Controls](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-custom-controls)

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

| Command | Description | Example |
|---------|-------------|---------|
| `terraform init` | Initialize working directory | `terraform init` |
| `terraform validate` | Validate configuration | `terraform validate` |
| `terraform plan` | Preview changes | `terraform plan -out=plan.tfplan` |
| `terraform apply` | Apply changes | `terraform apply plan.tfplan` |
| `terraform destroy` | Destroy all resources | `terraform destroy` |
| `terraform fmt` | Format code | `terraform fmt -recursive` |
| `terraform state list` | List resources | `terraform state list` |
| `terraform state show` | Show resource | `terraform state show ibm_is_vpc.vpc` |
| `terraform import` | Import resource | `terraform import ibm_is_vpc.vpc <id>` |
| `terraform output` | Show outputs | `terraform output vpc_id` |

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
| Key Protect | `ibm_kms_key` | Encryption keys |

### Variable Types and Validation

```hcl
# String with validation
variable "region" {
  type = string
  validation {
    condition     = contains(["us-south", "us-east"], var.region)
    error_message = "Invalid region."
  }
}

# Number with range
variable "worker_count" {
  type = number
  validation {
    condition     = var.worker_count >= 1 && var.worker_count <= 10
    error_message = "Worker count must be between 1 and 10."
  }
}

# List with validation
variable "zones" {
  type = list(string)
  validation {
    condition     = length(var.zones) >= 2
    error_message = "At least 2 zones required for HA."
  }
}

# Map with validation
variable "tags" {
  type = map(string)
  validation {
    condition     = alltrue([for k, v in var.tags : can(regex("^[a-z]+$", k))])
    error_message = "Tag keys must be lowercase letters only."
  }
}
```

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

**Scenario:**  
Deploy a production-ready web application with load balancer, application servers, and database.

**Architecture:**
```
┌─────────────────────────────────────────────────────────────────┐
│                         VPC (10.240.0.0/16)                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Public Subnet (10.240.1.0/24)                           │  │
│  │  ┌────────────────┐                                      │  │
│  │  │ Load Balancer  │                                      │  │
│  │  └────────────────┘                                      │  │
│  └──────────────────────────────────────────────────────────┘  │
│                          ↓                                      │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Private Subnet (10.240.2.0/24)                          │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐               │  │
│  │  │  App VM  │  │  App VM  │  │  App VM  │               │  │
│  │  └──────────┘  └──────────┘  └──────────┘               │  │
│  └──────────────────────────────────────────────────────────┘  │
│                          ↓                                      │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Database Subnet (10.240.3.0/24)                         │  │
│  │  ┌────────────────────────────────┐                      │  │
│  │  │  PostgreSQL Database (HA)      │                      │  │
│  │  └────────────────────────────────┘                      │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

**Implementation:**
```hcl
# Deploy using Deployable Architecture
module "web_app" {
  source = "terraform-ibm-modules/web-app-mzr/ibm"
  version = "1.0.0"
  
  prefix             = "prod-webapp"
  region             = "us-south"
  resource_group_id  = data.ibm_resource_group.group.id
  
  # Load balancer configuration
  lb_type = "public"
  
  # Application tier
  app_instance_count   = 3
  app_instance_profile = "cx2-4x8"
  
  # Database tier
  database_plan = "standard"
  database_version = "14"
  
  tags = ["production", "web-app"]
}
```

### Use Case 2: Data Analytics Platform

**Scenario:**  
Build a data analytics platform with object storage, data processing, and visualization.

**Components:**
- Cloud Object Storage for data lake
- IBM Analytics Engine for Spark processing
- IBM Db2 Warehouse for analytics
- Kubernetes cluster for visualization tools

**Implementation:**
```hcl
# Data lake
resource "ibm_cos_bucket" "data_lake" {
  bucket_name          = "${var.prefix}-data-lake"
  resource_instance_id = ibm_resource_instance.cos.id
  region_location      = var.region
  storage_class        = "smart"
}

# Analytics engine
resource "ibm_resource_instance" "analytics_engine" {
  name              = "${var.prefix}-analytics"
  service           = "ibmanalyticsengine"
  plan              = "standard-hourly"
  location          = var.region
  resource_group_id = data.ibm_resource_group.group.id
}

# Data warehouse
resource "ibm_database" "warehouse" {
  name              = "${var.prefix}-warehouse"
  plan              = "standard"
  location          = var.region
  service           = "databases-for-postgresql"
  resource_group_id = data.ibm_resource_group.group.id
  
  configuration = jsonencode({
    max_connections = 200
    shared_buffers  = "256MB"
  })
}
```

### Use Case 3: Disaster Recovery Setup

**Scenario:**  
Implement cross-region disaster recovery with automated failover.

**Strategy:**
- Primary region: us-south
- DR region: us-east
- Cross-region replication for data
- Automated DNS failover

**Implementation:**
```hcl
# Primary region infrastructure
module "primary" {
  source = "./modules/infrastructure"
  
  region            = "us-south"
  prefix            = "primary"
  resource_group_id = data.ibm_resource_group.group.id
}

# DR region infrastructure
module "dr" {
  source = "./modules/infrastructure"
  
  region            = "us-east"
  prefix            = "dr"
  resource_group_id = data.ibm_resource_group.group.id
}

# Cross-region replication
resource "ibm_cos_bucket_replication_rule" "dr_replication" {
  bucket_crn      = module.primary.bucket_crn
  bucket_location = "us-south"
  
  replication_rule {
    rule_id  = "dr-replication"
    enable   = true
    priority = 1
    
    destination_bucket_crn = module.dr.bucket_crn
  }
}

# Global load balancer for failover
resource "ibm_cis_global_load_balancer" "app" {
  cis_id           = ibm_cis.instance.id
  domain_id        = ibm_cis_domain.domain.id
  name             = "app.example.com"
  fallback_pool_id = ibm_cis_origin_pool.dr.id
  default_pool_ids = [ibm_cis_origin_pool.primary.id]
  
  # Health check
  proxied = true
  enabled = true
}
```

### Use Case 4: Compliance-Ready Environment

**Scenario:**  
Deploy infrastructure meeting regulatory compliance requirements (HIPAA, PCI-DSS).

**Requirements:**
- Encryption at rest and in transit
- Audit logging enabled
- Network isolation
- Access controls

**Implementation:**
```hcl
# Compliance-ready Deployable Architecture
module "compliant_infrastructure" {
  source  = "terraform-ibm-modules/compliance-vpc/ibm"
  version = "1.0.0"
  
  prefix            = "compliant"
  region            = "us-south"
  resource_group_id = data.ibm_resource_group.group.id
  
  # Encryption
  kms_key_crn = ibm_kms_key.root_key.crn
  
  # Audit logging
  activity_tracker_crn = ibm_resource_instance.activity_tracker.crn
  
  # Network isolation
  enable_private_endpoints = true
  enable_cbr_rules        = true
  
  # Access controls
  allowed_ip_ranges = ["10.0.0.0/8"]
  
  # Compliance tags
  tags = ["hipaa", "pci-dss", "production"]
}
```

---

**Document Version:** 1.0  
**Last Updated:** 2026-02-15  
**Maintained By:** IBM Cloud Technical Advocacy Team

---

*This document is part of the IBM Cloud Technical Training Advantage workshop series. For questions or feedback, please contact your workshop facilitator or visit the IBM Cloud Community.*
