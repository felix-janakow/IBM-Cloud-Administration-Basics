# Ansible Playbook for IBM Cloud Schematics

This directory contains an Ansible playbook designed to work with IBM Cloud Schematics to configure the VSI created by the Terraform configuration in `examples/IaC/`.

## Overview

IBM Cloud Schematics can automatically run Ansible playbooks after Terraform provisioning. The Terraform outputs (like VSI IP addresses) are automatically used as the Ansible inventory - no manual inventory file needed!

## What This Playbook Does

The `site.yml` playbook configures the Ubuntu VSI with:

1. **System Updates** - Updates apt package cache
2. **Essential Packages** - Installs nginx, git, curl, vim, htop
3. **Web Server** - Deploys nginx with a custom landing page
4. **Firewall Rules** - Configures UFW for HTTP/HTTPS traffic
5. **Service Management** - Ensures nginx is running and enabled

## Files

- `site.yml` - Main Ansible playbook
- `README.md` - This documentation

## Using with IBM Cloud Schematics

### Method 1: Schematics Workspace with Ansible Action

1. **Create Schematics Workspace** with the Terraform code:
   ```bash
   ibmcloud schematics workspace new \
     --name demo-vsi-workspace \
     --type terraform_v1.5 \
     --location us-south \
     --resource-group Default \
     --github-url https://github.com/your-repo/TTA-Advantage \
     --github-folder examples/IaC
   ```

2. **Apply Terraform** to create the VSI:
   ```bash
   ibmcloud schematics apply --id <workspace-id>
   ```

3. **Create Ansible Action** linked to the workspace:
   ```bash
   ibmcloud schematics action create \
     --name configure-vsi \
     --location us-south \
     --resource-group Default \
     --source-type git \
     --source-url https://github.com/your-repo/TTA-Advantage \
     --source-folder examples/IaC-Ansible \
     --playbook-name site.yml \
     --inventory <workspace-id>
   ```

4. **Run the Ansible Action**:
   ```bash
   ibmcloud schematics action run --id <action-id>
   ```

### Method 2: Combined Workspace (Terraform + Ansible)

Create a workspace that runs both Terraform and Ansible sequentially:

1. **Create workspace** with both Terraform and Ansible:
   ```bash
   ibmcloud schematics workspace new \
     --name demo-full-stack \
     --type terraform_v1.5 \
     --location us-south \
     --resource-group Default \
     --github-url https://github.com/your-repo/TTA-Advantage \
     --github-folder examples/IaC \
     --ansible-playbook examples/IaC-Ansible/site.yml
   ```

2. **Apply** to run both Terraform and Ansible:
   ```bash
   ibmcloud schematics apply --id <workspace-id>
   ```

## Schematics Inventory Integration

Schematics automatically creates an Ansible inventory from Terraform outputs. The playbook uses:

- **Host Group**: `all` - Targets all VSIs created by Terraform
- **Connection**: Uses the floating IP from Terraform output `vsi_public_ip`
- **SSH Key**: Uses the SSH key configured in Terraform

### Required Terraform Outputs

The Terraform file must output:
- `vsi_public_ip` - For Ansible to connect
- `ssh_key_id` - For authentication

These are already included in `examples/IaC/simple-vsi-deployment.tf`.

## Testing Locally (Optional)

If you want to test the playbook locally before using Schematics:

1. **Create inventory file** (not needed for Schematics):
   ```ini
   [webservers]
   your-vsi-ip ansible_user=root ansible_ssh_private_key_file=~/.ssh/id_rsa
   ```

2. **Run playbook**:
   ```bash
   ansible-playbook -i inventory site.yml
   ```

## Verification

After the playbook runs successfully:

1. **Get the VSI public IP** from Terraform outputs:
   ```bash
   ibmcloud schematics output --id <workspace-id>
   ```

2. **Access the web server**:
   ```bash
   curl http://<vsi-public-ip>
   ```
   
   Or open in browser: `http://<vsi-public-ip>`

3. **SSH to verify**:
   ```bash
   ssh root@<vsi-public-ip>
   nginx -v
   ```

## Customization

### Add More Tasks

Edit `site.yml` to add additional configuration:

```yaml
- name: Install Docker
  apt:
    name: docker.io
    state: present

- name: Deploy application
  git:
    repo: https://github.com/your-app/repo.git
    dest: /opt/myapp
```

### Use Variables

Create `vars.yml` for reusable variables:

```yaml
---
web_port: 80
app_name: myapp
domain: example.com
```

Reference in playbook:
```yaml
- name: Configure with variables
  hosts: all
  vars_files:
    - vars.yml
  tasks:
    - name: Use variable
      debug:
        msg: "Configuring {{ app_name }}"
```

## Workflow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                  IBM Cloud Schematics Workflow              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Terraform Phase                                         │
│     ├─ Create VPC                                           │
│     ├─ Create Subnet                                        │
│     ├─ Create Security Group                                │
│     ├─ Create VSI                                           │
│     └─ Output: vsi_public_ip, ssh_key_id                    │
│                                                             │
│  2. Inventory Generation (Automatic)                        │
│     └─ Schematics creates Ansible inventory from outputs    │
│                                                             │
│  3. Ansible Phase                                           │
│     ├─ Connect to VSI using floating IP                     │
│     ├─ Update system packages                               │
│     ├─ Install nginx and tools                              │
│     ├─ Deploy web page                                      │
│     ├─ Configure firewall                                   │
│     └─ Start services                                       │
│                                                             │
│  4. Result                                                  │
│     └─ Fully configured web server ready to use             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Best Practices

1. **Idempotency** - All tasks are idempotent (safe to run multiple times)
2. **Error Handling** - Use `when` conditions for OS-specific tasks
3. **Variables** - Use variables for reusable values
4. **Tags** - Add tags to run specific parts of the playbook
5. **Handlers** - Use handlers for service restarts

## Troubleshooting

### Issue: Ansible cannot connect to VSI

**Solution:**
- Verify security group allows SSH (port 22)
- Check floating IP is attached
- Verify SSH key is correct

### Issue: Package installation fails

**Solution:**
- Ensure VSI has internet access
- Check apt cache is updated
- Verify package names are correct

### Issue: Nginx not starting

**Solution:**
- Check port 80 is not already in use
- Verify nginx configuration syntax
- Check system logs: `journalctl -u nginx`

## Additional Resources

- [IBM Cloud Schematics Documentation](https://cloud.ibm.com/docs/schematics)
- [Schematics Actions](https://cloud.ibm.com/docs/schematics?topic=schematics-action-setup)
- [Ansible Documentation](https://docs.ansible.com/)
- [Terraform IBM Provider](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs)

---

**Note:** This playbook is designed for demonstration purposes. For production use, consider:
- Using Ansible roles for better organization
- Implementing proper secret management
- Adding comprehensive error handling
- Using Ansible Vault for sensitive data
- Implementing proper logging and monitoring