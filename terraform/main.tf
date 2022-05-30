/******************************************
	Host project configuration
 *****************************************/
module "host_project" {
  source = "../modules/project"
  project_name = var.host_project_name
  project_id = var.host_project_id
  parent = var.host_project_parent_id
  billing_account = var.host_billing_account
}

/******************************************
	Host project services configuration
 *****************************************/
module "host_project_services" {
  source              = "../../modules/project_services"
  project_id          = module.host_project.project_id
  activate_apis       = var.host_proj_activate_apis
}

/******************************************
	Host Project - Private VPC configuration
 *****************************************/
module "host_project_priv_vpc" {
  source                = "../../modules/vpc"
  network_name          = "vpc-priv"
  project_id            = var.host_project.project_id
  description           = var.host_network_description
  shared_vpc_host       = true
}

/**************************************************
	Host Project - Subnet configuration
 *************************************************/
module "host_project_priv_subnets" {
  source                = "../../modules/subnets"
  project_id            = module.host_project.project_id
  network_name          = module.host_project_priv_vpc.network_name
  subnets               = var.service_project_subnets
}

/******************************************
	Host Project - Public VPC configuration
 *****************************************/
module "host_project_pub_vpc" {
  source                = "../../modules/vpc"
  network_name          = "vpc-pub"
  project_id            = var.host_project.project_id
  description           = var.host_network_description
}

/**************************************************
	Host Project - Subnet configuration
 *************************************************/
module "host_project_pub_subnets" {
  source                = "../../modules/subnets"
  project_id            = module.host_project.project_id
  network_name          = module.host_project_pub_vpc.network_name
  subnets               = var.service_project_subnets
}

/**********************************************************
	Host Project - firewall rules configuration
 **********************************************************/
module "service_project_firewall_rule" {
  source                = "../../modules/firewall"
  project_id            = module.host_project.project_id
  network               = module.host_project_vpc.network_name
  custom_rules          = var.host_project_firewall_rules
}

/******************************************
	Service Account Creation
 *****************************************/
module "service_account" {
    source               = "../../modules/serviceAccount"
    project_id           = var.module.host_project.project_id
    roles                = var.sa_roles
    account_name         = var.account_name
    account_display_name = var.account_display_name
    account_description  = var.account_description
}

/******************************************
        VM Instance Creation
 *****************************************/
module "vminstance-proxy" {
    source              = "../../modules/vm_instance"
    project_id                              = module.host_project.project_id
    region_name                             = var.region
    machine_name                            = var.machine_name
    machine_type                            = var.machine_type
    zone_name                               = var.zone_name
    image_platform                          = var.image_platform
    image_name                              = var.image_name
    network_01                              = module.host_project_vpc.network_name
    subnetwork_01_in                        = module.host_project_pub_subnets.name
    email                                   = module.service_account.service_account_email
    subnetwork_project                      = var.subnetwork_project
    metadata_startup_script                 = var.metadata_startup_script
}

/******************************************
	Service project configuration
 *****************************************/
module "service_project" {
  source = "../modules/project"
  project_name = var.service_project_name
  project_id = var.service_project_id
  parent = var.service_project_parent_id
  billing_account = var.service_billing_account
}

/******************************************
	Service project services configuration
 *****************************************/
module "service_project_services" {
  source              = "../../modules/project_services"
  project_id          = module.service_project.project_id
  activate_apis       = var.service_proj_activate_apis
}

/************************************************
	Service Project - VPC configuration
 ***********************************************/
module "service_project_vpc" {
  source                = "../../modules/vpc"
  network_name          = var.service_project_network_name
  project_id            = module.service_project.project_id
  description           = var.service_project_network_description
  shared_vpc_service    = true
  host_project_id       = module.host_project.project_id
  service_project_id    = module.service_project.project_id
  module_depends_on     = [module.service_project_services]
}

/**************************************************
	Service Project - Subnet configuration
 *************************************************/
module "service_project_subnets" {
  source                = "../../modules/subnets"
  project_id            = module.service_project.project_id
  network_name          = module.service_project_vpc.network_name
  subnets               = var.service_project_subnets
}

/**********************************************************
	Service Project - firewall rules configuration
 **********************************************************/
module "service_project_firewall_rule" {
  source                = "../../modules/firewall"
  project_id            = module.service_project.project_id
  network               = module.service_project_vpc.network_name
  custom_rules          = var.service_project_firewall_rules
}

/******************************************
        VM Instance Creation
 *****************************************/
module "vminstance-gateway" {
    source              = "../../modules/vm_instance"
    project_id                              = var.project_id_in
    region_name                             = var.region_name_in
    machine_name                            = var.machine_name_in
    machine_type                            = var.machine_type_in
    zone_name                               = var.zone_name_in
    image_platform                          = var.image_platform_in
    image_name                              = var.image_name_in
    network_01                              = var.network_01_in
    subnetwork_01_in                        = var.subnetwork_01_in
    email                                   = module.service_account.service_account_email
    subnetwork_project                      = var.subnetwork_project
    metadata_startup_script                 = var.metadata_startup_script
}

/******************************************
	Customer project configuration
 *****************************************/
module "cust_project" {
  source = "../modules/project"
  project_name = var.cust_project_name
  project_id = var.cust_project_id
  parent = var.cust_project_parent_id
  billing_account = var.cust_billing_account
}

/******************************************
	Customer project services configuration
 *****************************************/
module "cust_project_services" {
  source              = "../../modules/project_services"
  project_id          = module.cust_project.project_id
  activate_apis       = var.cust_proj_activate_apis
}

/************************************************
	Customer Project - VPC configuration
 ***********************************************/
module "cust_project_vpc" {
  source                = "../../modules/vpc"
  network_name          = var.cust_project_network_name
  project_id            = module.cust_project.project_id
  description           = var.cust_project_network_description

  module_depends_on     = [module.cust_project_services]
}

/**************************************************
	Customer Project - Subnet configuration
 *************************************************/
module "cust_project_subnets" {
  source                = "../../modules/subnets"
  project_id            = module.cust_project.project_id
  network_name          = module.cust_project_vpc.network_name
  subnets               = var.cust_project_subnets
}

/**********************************************************
	Customer Project - firewall rules configuration
 **********************************************************/
module "cust_project_firewall_rule" {
  source                = "../../modules/firewall"
  project_id            = module.cust_project.project_id
  network               = module.cust_project_vpc.network_name
  custom_rules          = var.cust_project_firewall_rules
}

/**************************************************
	VPC Peering configuration
 *************************************************/
module "peering-1" {
  source                = "../../modules/network_peering"
  prefix                = "peering"
  local_network         = module.service_project_vpc.network_self_link
  peer_network          = module.cust_project_vpc.network_self_link
}