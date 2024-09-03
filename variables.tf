variable "sddc_manager_username" {
  description = "Username used to authenticate against an SDDC Manager instance"
  default     = "administrator@vsphere.local"
}

variable "sddc_manager_password" {
  description = "Password used to authenticate against an SDDC Manager instance"
  default     = "VMware123456!"
}

variable "sddc_manager_host" {
  description = "Fully qualified domain name of an SDDC Manager instance"
  default     = "sfo-vcf01.sfo.rainpole.io"
}

variable "resource_type" {
  type    = string
  default = "NSXT_EDGE"
}

variable "account_type" {
  type    = string
  default = "SYSTEM"
}

variable "rotation_frequency_days" {
  type    = number
  default = 90
}
