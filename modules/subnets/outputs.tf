output "subnet_name" {
  value       = [for v in google_compute_subnetwork.subnetwork : v.name]
  description = "The created subnet resources"
}
