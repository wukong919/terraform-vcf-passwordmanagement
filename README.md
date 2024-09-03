# QuickStart Guide

## How this module help you?
This module leverages VMware Cloud Foundation Terraform Provider to automatically rotate the Passwords used in the VCF instance Management Automation. It greatly simplifies the password managements in a large scale VMware Cloud Foundation environment.

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
You can see the complete example in the docs folder.