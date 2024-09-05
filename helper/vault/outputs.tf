output "secrets_metadata" {
  value = {
    for key, vault_secret in vault_kv_secret_v2.vault_secrets : key => {
      custom_metadata = vault_secret.custom_metadata
      key_version     = vault_secret.metadata.version
    }
  }
}