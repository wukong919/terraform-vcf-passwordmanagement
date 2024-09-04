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

module "passwordmanagement" {
  source                  = "wukong919/passwordmanagement/vcf"
  sddc_manager_host     = var.sddc_manager_host
  rotation_frequency_days = var.rotation_frequency_days
  resource_type           = var.resource_type
  account_type            = var.account_type
}