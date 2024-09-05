variable "vault_address" {
  description = "Hashicorp Vault address"
  type        = string
}

variable "vault_vcf_passwords_mountpath" {
  description = "Hashicorp Vault mounth path to store VCF Passwords"
  type        = string
}

variable "secrets" {
  description = "map of VCF passwords, outputs of Passwordmanagement module"
  type = map(any)
}