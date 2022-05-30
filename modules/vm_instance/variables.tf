variable "project_id" {
  type = string
}

variable "region_name" {
  type = string
}

variable "machine_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "zone_name" {
  type = string
}

variable "image_platform" {
  type = string
}

variable "image_name" {
  type = string
}

variable "metadata_startup_script" {
  type = string
  default = null
}

variable "network_01" {
  type = string
  default = null
}

variable "subnetwork_01_in" {
    type = string
}

variable "subnetwork_project" {
    type        = string
    default     = null
}
 
variable "email" {
    type = string
}