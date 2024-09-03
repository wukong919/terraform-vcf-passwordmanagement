terraform {
  required_providers {
    vcf = {
      source  = "vmware/vcf"
      version = "~> 0.10.0"
    }
  }
}

provider "vcf" {
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  sddc_manager_host     = var.sddc_manager_host
  allow_unverified_tls  = true
}

module "update-vcf-esx-service-pwd" {
  source                = "./modules/pass"
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  resource_type         = "ESXI"
  account_type          = "SERVICE"
}
