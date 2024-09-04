variable "sddc_manager_host" {
  description = "Fully qualified domain name of an SDDC Manager instance"
}

variable "resource_type" {
  description = "The type of the resource.One among ESXI, VCENTER, PSC, NSX_MANAGER, NSX_CONTROLLER, NSXT_EDGE, NSXT_MANAGER, VRLI, VROPS, VRA, WSA, VRSLCM, VXRAIL_MANAGER, NSX_ALB, BACKUP"
  type = string
}

variable "account_type" {
  description = "One among USER, SYSTEM, SERVICE"
  type = string
}

variable "rotation_frequency_days" {
  description = "After how many days the credentials will be rotated. Default is 90 days"
  type    = number
  default = 90
}