locals {
  parent_type              = split("/", var.parent)[0]
  parent_id                = split("/", var.parent)[1]
}

/******************************************
	PROJECT configuration
 *****************************************/
resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  org_id              = local.parent_type == "organizations" ? local.parent_id : ""
  folder_id           = local.parent_type == "folders" ? local.parent_id : ""
  billing_account     = var.billing_account
  auto_create_network = var.auto_create_network

  depends_on = [var.module_depends_on]
}