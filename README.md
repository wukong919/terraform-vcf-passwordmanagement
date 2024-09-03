# QuickStart Guide

## How would the module help you?
This module leverages the VMware Cloud Foundation Terraform Provider to automatically rotate the passwords for different systems (e.g., ESXi, vCenter, NSX, VRSLCM, VROPS, VRA etc.) deployed in your VCF instance. It greatly simplifies password management in a large-scale VMware Cloud Foundation environment.

Also, the module will help enforce your password rotation policy by using the `rotation_frequency_days` parameter.

## Prerequisites
* a running VMware Cloud Foundation environment

## How to use this module?
One quick example here:

```hcl
module "update-vcf-esx-system-pwd" {
  source                = "github.com/wukong919/terraform-vcf-passwordmanagement"
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  resource_type         = "ESXI"
  account_type          = "SYSTEM"
}
```
You can see an complete example in the docs folder.
