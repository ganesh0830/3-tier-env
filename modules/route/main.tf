resource "google_compute_route" "route-ilb" {
  provider     = google-beta
  name         = var.name
  dest_range   = var.dest_range
  network      = var.network
  next_hop_gateway = var.next_hop_gateway != null ? var.next_hop_gateway : ""
  next_hop_instance = var.next_hop_instance != null ? var.next_hop_instance : ""
  next_hop_ip = var.next_hop_ip != null ? var.next_hop_iP : "" 
  next_hop_ilb = var.next_hop_ilb != null ? var.next_hop_lib : "" 
  priority     = var.priority
}