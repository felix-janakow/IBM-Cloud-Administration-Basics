##############################################################################
# Outputs
##############################################################################

output "resource_group_name" {
  value       = var.existing_resource_group_name
  description = "Resource group name."
}

output "code_engine_project_name" {
  value       = ibm_code_engine_project.code_engine_project.name
  description = "Code engine project name."
}

output "code_engine_project_id" {
  value       = ibm_code_engine_project.code_engine_project.id
  description = "Created code engine project identifier."
}

output "next_step_primary_url" {
  value       = "https://cloud.ibm.com/codeengine/projects"
  description = "URL to access Code Engine projects"
}

output "next_steps_text" {
  value       = "Your Code Engine project has been created. Visit the Code Engine console to start deploying applications, jobs, or functions."
  description = "Next steps text"
}

output "next_step_primary_label" {
  value       = "View Code Engine Projects"
  description = "Primary label"
}
