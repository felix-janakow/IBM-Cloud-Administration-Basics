##############################################################################
# Required Variables
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key."
  sensitive   = true
}

##############################################################################
# Common Variables - Customize defaults for your use case
##############################################################################

variable "prefix" {
  type        = string
  description = "The prefix to add to all resources that this solution creates (e.g `prod`, `test`, `dev`). To skip using a prefix, set this value to `null` or an empty string. [Learn more](https://terraform-ibm-modules.github.io/documentation/#/prefix.md)."
  default     = "dev"
}

variable "existing_resource_group_name" {
  type        = string
  description = "The name of an existing resource group to provision the resources. [Learn more](https://cloud.ibm.com/docs/account?topic=account-rgs&interface=ui#create_rgs) about how to create a resource group."
  default     = "Default"
}

variable "region" {
  type        = string
  description = "The region to provision all resources."
  default     = "us-south"
}

variable "provider_visibility" {
  type        = string
  description = "Set the visibility value for the IBM terraform provider. Supported values are `public`, `private`, `public-and-private`. [Learn more](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/guides/custom-service-endpoints)."
  default     = "private"
}

##############################################################################
# Architecture-Specific Variables
##############################################################################

variable "code_engine_project_name" {
  type        = string
  description = "The name of the IBM Cloud Code Engine project to be deployed. If specified, the prefix leads the project name in the <prefix>-<code_engine_project_name> format."
  default     = "project"
}

##############################################################################
# TODO: Add your custom variables below
##############################################################################

# Example custom variable:
# variable "custom_setting" {
#   type        = string
#   description = "Description of your custom setting"
#   default     = "default-value"
# }

