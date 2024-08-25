
plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

# Unused data resources are intentional to document resources managed outside of terraform.
rule "terraform_unused_declarations" {
  enabled = false
}

# Not needed since terraform versions are managed by Terraform Cloud.
rule "terraform_required_version" {
  enabled = false
}
