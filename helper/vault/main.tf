locals {
  transformed_secrets = {
    for key, value in var.secrets :
    key => {
      credential_type  = value.credential_type
      domain           = value.domain
      last_rotate_time = value.last_rotate_time
      password         = value.password
      resource_name    = value.resource_name
      resource_type    = value.resource_type
      secret_id        = value.secret_id
      user_name        = value.user_name
      sddc_manager     = value.sddc_manager
    }
  }
}

resource "vault_kv_secret_v2" "vault_secrets" {
  for_each = local.transformed_secrets

  mount = "vcf"
  # name                = "${each.value.secret_id}-${each.value.resource_name}-${each.value.user_name}"
  name                = "${each.value.resource_name}-${each.value.user_name}"
  cas                 = 1
  delete_all_versions = true

  data_json = jsonencode({
    username = each.value.user_name
    password = each.value.password # Replace with the actual rotated password
  })

  custom_metadata {
    max_versions = 100
    data = {
      category         = "vcf"
      system           = each.value.resource_name
      resource_type    = each.value.resource_type
      type             = each.value.credential_type
      vcf_domain       = each.value.domain
      last_rotate_time = each.value.last_rotate_time
      sddc_manager     = each.value.sddc_manager
    }
  }
}

output "secrets_metadata" {
  value = {
    for key, vault_secret in vault_kv_secret_v2.vault_secrets : key => {
      custom_metadata = vault_secret.custom_metadata
      key_version     = vault_secret.metadata.version
    }
  }
}
