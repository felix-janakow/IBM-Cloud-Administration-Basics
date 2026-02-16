# TODO: Update the source to point to your module location
# Options:
# 1. Local path: source = "./modules/your-module"
# 2. Git repository: source = "git::https://github.com/your-org/your-repo.git//path/to/module?ref=v1.0.0"
# 3. Terraform Registry: source = "your-org/module-name/provider"
# 4. IBM Catalog: source = "https://cm.globalcatalog.cloud.ibm.com/api/v1-beta/offering/source/archive//..."

module "your-custom-module" {
  source               = "./modules/your-module"  # TODO: Update this path
  ibmcloud_api_key     = var.ibmcloud_api_key
  prefix               = var.prefix
  code_engine_project_name = var.code_engine_project_name
  region               = var.region
  
  # TODO: Add additional variables as needed for your architecture
  # existing_resource_group_name = var.existing_resource_group_name
  # provider_visibility = var.provider_visibility
}