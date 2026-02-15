# Simple IBM Cloud VSI Deployment with VPC
# This Terraform configuration creates a basic infrastructure setup

terraform {
  required_version = ">= 1.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.60"
    }
  }
}

# Provider configuration
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

# Variables
variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region"
  type        = string
  default     = "eu-de"
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
  default     = "Default"
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "demo"
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
}

# Data sources
data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_is_image" "ubuntu" {
  name = "ibm-ubuntu-22-04-3-minimal-amd64-1"
}

data "ibm_is_ssh_key" "existing_key" {
  count = var.ssh_public_key == "" ? 1 : 0
  name  = "${var.prefix}-ssh-key"
}

# VPC
resource "ibm_is_vpc" "vpc" {
  name           = "${var.prefix}-vpc"
  resource_group = data.ibm_resource_group.group.id
  tags           = ["demo", "terraform"]
}

# Subnet
resource "ibm_is_subnet" "subnet" {
  name                     = "${var.prefix}-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = "${var.region}-1"
  total_ipv4_address_count = 256
  resource_group           = data.ibm_resource_group.group.id
}

# Security Group
resource "ibm_is_security_group" "sg" {
  name           = "${var.prefix}-sg"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.group.id
}

# Security Group Rules
# Allow SSH (port 22)
resource "ibm_is_security_group_rule" "ssh_inbound" {
  group     = ibm_is_security_group.sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 22
    port_max = 22
  }
}

# Allow HTTP (port 80)
resource "ibm_is_security_group_rule" "http_inbound" {
  group     = ibm_is_security_group.sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 80
    port_max = 80
  }
}

# Allow HTTPS (port 443)
resource "ibm_is_security_group_rule" "https_inbound" {
  group     = ibm_is_security_group.sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"

  tcp {
    port_min = 443
    port_max = 443
  }
}

# Allow all outbound traffic
resource "ibm_is_security_group_rule" "outbound_all" {
  group     = ibm_is_security_group.sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

# SSH Key
resource "ibm_is_ssh_key" "ssh_key" {
  count          = var.ssh_public_key != "" ? 1 : 0
  name           = "${var.prefix}-ssh-key"
  public_key     = var.ssh_public_key
  resource_group = data.ibm_resource_group.group.id
}

# Virtual Server Instance (VSI)
resource "ibm_is_instance" "vsi" {
  name           = "${var.prefix}-vsi"
  vpc            = ibm_is_vpc.vpc.id
  zone           = "${var.region}-1"
  profile        = "cx2-2x4"
  image          = data.ibm_is_image.ubuntu.id
  keys           = var.ssh_public_key != "" ? [ibm_is_ssh_key.ssh_key[0].id] : [data.ibm_is_ssh_key.existing_key[0].id]
  resource_group = data.ibm_resource_group.group.id

  primary_network_interface {
    subnet          = ibm_is_subnet.subnet.id
    security_groups = [ibm_is_security_group.sg.id]
  }

  boot_volume {
    name = "${var.prefix}-boot-volume"
  }

  tags = ["demo", "terraform", "vsi"]
}

# Floating IP for external access
resource "ibm_is_floating_ip" "fip" {
  name           = "${var.prefix}-fip"
  target         = ibm_is_instance.vsi.primary_network_interface[0].id
  resource_group = data.ibm_resource_group.group.id
}

# Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = ibm_is_vpc.vpc.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = ibm_is_subnet.subnet.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = ibm_is_security_group.sg.id
}

output "vsi_id" {
  description = "ID of the VSI"
  value       = ibm_is_instance.vsi.id
}

output "vsi_private_ip" {
  description = "Private IP address of the VSI"
  value       = ibm_is_instance.vsi.primary_network_interface[0].primary_ipv4_address
}

output "vsi_public_ip" {
  description = "Public IP address (Floating IP) of the VSI"
  value       = ibm_is_floating_ip.fip.address
}

output "ssh_command" {
  description = "SSH command to connect to the VSI"
  value       = "ssh root@${ibm_is_floating_ip.fip.address}"
}

output "ssh_key_id" {
  description = "ID of the SSH key"
  value       = var.ssh_public_key != "" ? ibm_is_ssh_key.ssh_key[0].id : data.ibm_is_ssh_key.existing_key[0].id
}