/******************************************
  Google Cloud Compute Engine instance
 *****************************************/

resource "google_compute_instance" "default" {
 name         = var.machine_name
 machine_type = var.machine_type
 zone         = var.zone_name
 project     = var.project_id

 boot_disk {
   initialize_params {
     image = "${var.image_platform}/${var.image_name}"
 }
 }

 metadata_startup_script = var.metadata_startup_script
 network_interface {
   network = var.network_01 != null ? var.network_01 : null
   subnetwork = var.subnetwork_01_in
   subnetwork_project = var.subnetwork_project
   access_config {

   }
 }
  service_account {
    email = var.email
    scopes = ["service-control","service-management","monitoring-write","logging-write","storage-ro","https://www.googleapis.com/auth/trace.append"]
  }
}