# QuickStart Guide

## How would the module help you?
This module leverages the VMware Cloud Foundation Terraform Provider to automatically rotate the `SYSTEM` or `USER` passwords for different systems (e.g., `ESXI`, `VCENTER`, `NSXT_MANAGER`,`NSXT_MANAGER`,`VRSLCM`, `VROPS`, `VRA` etc.) deployed in your VCF instance. It greatly simplifies password management in a large-scale VMware Cloud Foundation environment.

Also, the module will help enforce your password rotation policy by using the `rotation_frequency_days` parameter.

## Prerequisites
* a running VMware Cloud Foundation environment

## How to use this module?

### Basic Use Case
Below is an example of how to rotate a single type of VCF passwords with this `passwordmanagement` module.

```hcl
module "update-vcf-esx-system-pwd" {
  source                  = "wukong919/passwordmanagement/vcf"
  sddc_manager_host     = var.sddc_manager_host
  rotation_frequency_days = var.rotation_frequency_days
  resource_type           = var.resource_type
  account_type            = var.account_type
}
```
### Advanced Use Case
In the [Github](https://github.com/wukong919/terraform-vcf-passwordmanagement) helper folder, a HashiCorp `vault` module is included. When used together with the `passwordmanagement` module, this `vault` module synchronizes the changes with your HashiCorp Vault system whenever VCF passwords are rotated. This helps VCF customers achieve end-to-end password management automation. The entire process operates without any human intervention, significantly minimizing the risk of password exposure or leaks.

Below is an example of how to use these two modules together.

`main.tf`
```hcl
terraform {
  required_providers {
    vcf = {
      source  = "vmware/vcf"
      version = "~> 0.10.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.0"
    }
  }
}

provider "vcf" {
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  sddc_manager_host     = var.sddc_manager_host
  allow_unverified_tls  = true
}

provider "vault" {
  address = var.vault_address
}
module "update-pwd" {
  for_each                   = var.system_secrets
  source                     = "wukong919/passwordmanagement/vcf"
  sddc_manager_host     = var.sddc_manager_host
  rotation_frequency_days = var.rotation_frequency_days
  resource_type              = each.value.resource_type
  account_type               = each.value.account_type
}
module "update-vault" {
  for_each      = var.system_secrets
  source        = "github.com/wukong919/terraform-vcf-passwordmanagement/helper/vault"
  vault_address = var.vault_address
  vault_vcf_passwords_mountpath = var.vault_vcf_passwords_mountpath
  secrets       = module.update-pwd[each.key].secrets
}

output "secrets_metadata" {
  value = {
    for key, i in module.update-vault : key => {
      vault_kv2_secrets = module.update-vault[key].secrets_metadata
    }
  }
}
```
`variable.tf`
```hcl
variable "sddc_manager_username" {
  description = "Username used to authenticate against an SDDC Manager instance"
  default     = "administrator@vsphere.local"
  type        = string
}

variable "sddc_manager_password" {
  description = "Password used to authenticate against an SDDC Manager instance"
  default     = "VMware12345!"
  sensitive   = true
}

variable "sddc_manager_host" {
  description = "Fully qualified domain name of an SDDC Manager instance"
  default     = "sfo-vcf01.sfo.rainpole.io"
  type        = string
}

variable "vault_address" {
  description = "hashicorp vault"
  default     = "http://10.221.78.150:8200"
  type        = string
}

variable "vault_vcf_passwords_mountpath" {
  description = "hashicorp vault mounth path for VCF Passwords"
  default     = "vcf"
  type        = string
}

variable "rotation_frequency_day" {
  description = "secret rotation frequency"
  default     = 15
  type        = number
}

variable "system_secrets" {
  type = map(any)
  default = {
    "nsxm-system" = {
      "resource_type" = "NSXT_MANAGER",
      "account_type"  = "SYSTEM"
    },
    "esxi-user" = {
      "resource_type" = "ESXI",
      "account_type"  = "USER"
    },
    "nsxedge-system" = {
      "resource_type" = "NSXT_EDGE",
      "account_type"  = "SYSTEM"
    },
    "vcenter-system" = {
      "resource_type" = "VCENTER",
      "account_type"  = "SYSTEM"
    },
    "wsa-system" = {
      "resource_type" = "WSA",
      "account_type"  = "SYSTEM"
    },
   "vcf-backup" = {
      "resource_type" = "BACKUP",
      "account_type"  = "SYSTEM"
    }
  }
}
```