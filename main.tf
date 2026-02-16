##############################################################################
# Terraform Providers
##############################################################################

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

##############################################################################
# Resource Group
##############################################################################

data "ibm_resource_group" "resource_group" {
  name = var.existing_resource_group_name
}

##############################################################################
# Code Engine Project
##############################################################################

resource "ibm_code_engine_project" "code_engine_project" {
  name              = var.prefix != null && var.prefix != "" ? "${var.prefix}-${var.code_engine_project_name}" : var.code_engine_project_name
  resource_group_id = data.ibm_resource_group.resource_group.id
}