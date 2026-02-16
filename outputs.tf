############
# Outputs - Customize based on your architecture
# Uncomment and modify the outputs you need
############

# TODO: Update module reference from "module.your-custom-module" to match your main.tf module name

output "resource_group_name" {
  value       = var.existing_resource_group_name
  description = "Resource group name."
}

output "code_engine_project_name" {
  value       = var.code_engine_project_name
  description = "Code engine project name."
}

# Example: Uncomment to expose module outputs
# output "code_engine_project_id" {
#   value       = module.your-custom-module.project_id
#   description = "Created code engine project identifier."
# }

# output "next_step_primary_url" {
#   value       = "https://cloud.ibm.com/codeengine/projects"
#   description = "URL to access Code Engine projects"
# }

# TODO: Add additional outputs specific to your architecture
# output "custom_output_name" {
#   value       = module.your-custom-module.output_name
#   description = "Description of your custom output"
# }
