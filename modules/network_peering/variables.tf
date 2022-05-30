variable "prefix" {
  type        = string
  default     = "network-peering"
}

variable "local_network" {
  type        = string
}

variable "peer_network" {
  type        = string
}

variable "export_peer_custom_routes" {
  type        = bool
  default     = false
}

variable "export_local_custom_routes" {
  type        = bool
  default     = false
}

variable "module_depends_on" {
  type        = list
  default     = []
}
