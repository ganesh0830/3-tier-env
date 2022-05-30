variable "project_id" {
  type = string
}

variable "network_name" {
  type = string
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
}

variable "shared_vpc_host" {
  type        = bool
  default     = false
}

variable "description" {
  type        = string
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  default     = false
}

variable "module_depends_on" {
  type        = list
  default     = []
}

variable "shared_vpc_service" {
  type        = bool
  default     = false
}

variable "host_project_id" {
  type        = string
}

variable "service_project_id" {
  type        = string
}