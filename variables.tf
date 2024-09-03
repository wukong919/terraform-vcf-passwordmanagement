variable "sddc_manager_username" {
  description = "Username used to authenticate against an SDDC Manager instance"
}

variable "sddc_manager_password" {
  description = "Password used to authenticate against an SDDC Manager instance"
}

variable "sddc_manager_host" {
  description = "Fully qualified domain name of an SDDC Manager instance"
}

variable "resource_type" {
  type    = string
}

variable "account_type" {
  type    = string
}

variable "rotation_frequency_days" {
  type    = number
  default = 90
}
