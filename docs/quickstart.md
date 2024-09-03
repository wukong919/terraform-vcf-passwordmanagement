# QuickStart Guide

## How this module help you?
This module leverages VMware Cloud Foundation Terraform Provider and HashiCorp Vault Provider to achieve Password Management Automation. It will automatically rotate the VCF passwords and create/update the passwords in the Vault. It greatly simplifies the password managements in a large scale VMware Cloud Foundation environment.
The following shows the result in Vault post a module run. 

* ESXI Password registered in Vault
<img src="images/vault_secrets.jpg" alt="VMware Cloud Foundation Password registered in Vault">
* The metadata of an ESXI Password
<img src="images/secret_meta.jpg" alt="VMware Cloud Foundation Password Metatdata">

## Prerequisites
* a running VMware Cloud Foundation environment
* a running HashiCorp Vault with an existing path for VMware Cloud Foundation passwords

## How to use this module?
One quick example here:

```hcl
module "update-vcf-esx-service-pwd" {
  source                = "./modules/pass"
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  vault_address         = var.vault_address
  resource_type         = "ESXI"
  account_type          = "SERVICE"
}
```
You can see the complete example in the docs folder.

When apply your template, use `terraform apply -parallelism=1`.