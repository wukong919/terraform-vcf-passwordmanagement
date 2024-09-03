output "secrets" {
  value = {
    for key, i in vcf_credentials_rotate.rotate : key => {
      resource_name    = i.resource_name
      resource_type    = i.resource_type
      credential_type  = i.credentials[0].credential_type
      user_name        = i.credentials[0].user_name
      password         = i.credentials[0].password
      secret_id        = i.id
      last_rotate_time = i.last_rotate_time
      domain           = local.credentials_map[key].resource_domain
      sddc_manager     = var.sddc_manager_host
    }
  }
  sensitive = true
}
