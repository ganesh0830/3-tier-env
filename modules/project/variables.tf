variable "parent" {
  type        = string
}

variable "project_name" {
  type        = string
}

variable "project_id" {
  type        = string
}

variable "billing_account" {
    type        = string
}

variable "auto_create_network" {
    type        = bool
    default     = false
}

variable "module_depends_on" {
  type        = list
  default     = []
}