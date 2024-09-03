data "vcf_credentials" "sddc_creds" {
  resource_type = var.resource_type
  account_type  = var.account_type
}


locals {
  credentials_map = { for cred in data.vcf_credentials.sddc_creds.credentials : "${cred.resource[0].name}-${cred.user_name}" => {
    resource_name   = cred.resource[0].name
    resource_type   = cred.resource[0].type
    resource_domain = cred.resource[0].domain
    credential_type = cred.credential_type
    user_name       = cred.user_name
    password        = cred.password
  } }
}

resource "time_rotating" "rotate" {
  rotation_days = var.rotation_frequency_days
}

resource "time_static" "rotate" {
  rfc3339 = time_rotating.rotate.rfc3339
}
resource "vcf_credentials_rotate" "rotate" {
  for_each = local.credentials_map

  resource_name = each.value.resource_name
  resource_type = each.value.resource_type
  once_only     = false
  credentials {
    credential_type = each.value.credential_type
    user_name       = each.value.user_name
  }
  lifecycle {
    replace_triggered_by = [
      time_static.rotate
    ]
  }
}
