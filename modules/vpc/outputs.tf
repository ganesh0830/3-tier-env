output "network" {
  value       = google_compute_network.network
}

output "network_name" {
  value       = google_compute_network.network.name
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
}

output "project_id" {
  value       = var.shared_vpc_host && length(google_compute_shared_vpc_host_project.shared_vpc_host) > 0 ? google_compute_shared_vpc_host_project.shared_vpc_host.*.project[0] : google_compute_network.network.project
}