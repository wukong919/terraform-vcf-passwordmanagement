# QuickStart Guide

## How would the module help you?
This module leverages the VMware Cloud Foundation Terraform Provider to automatically rotate the `SYSTEM` or `USER` passwords for different systems (e.g., `ESXI`, `VCENTER`, `NSXT_MANAGER`,`NSXT_MANAGER`,`VRSLCM`, `VROPS`, `VRA` etc.) deployed in your VCF instance. It greatly simplifies password management in a large-scale VMware Cloud Foundation environment.

Also, the module will help enforce your password rotation policy by using the `rotation_frequency_days` parameter.

## Prerequisites
* a running VMware Cloud Foundation environment

## How to use this module?
One quick example here:

```hcl
module "update-vcf-esx-system-pwd" {
  source                  = "wukong919/passwordmanagement/vcf"
  sddc_manager_host     = var.sddc_manager_host
  rotation_frequency_days = var.rotation_frequency_days
  resource_type           = var.resource_type
  account_type            = var.account_type
}
```
You can see a complete example in the docs folder.
