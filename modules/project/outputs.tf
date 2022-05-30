output "project_name" {
  value       = google_project.project.name
  description = "The name of the Google Project being created."
}

output "project_id" {
    value       = google_project.project.project_id
    description = "The ID of the Google Project being created."
}

output "project_number" {
  description = "Project number"
  value       = google_project.project.number
}