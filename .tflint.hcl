
plugin "terraform" {
  enabled = true
  preset  = "all"
}

# Unused data resources are intentional to document resources managed outside of terraform.
rule "terraform_unused_declarations" {
  enabled = false
}

# Not needed since terraform versions are managed by Terraform Cloud.
rule "terraform_required_version" {
  enabled = false
}

# This rule is dumb, if there's no outputs then there's no need for an outputs.tf file. Same for all other standard structure files.
rule "terraform_standard_module_structure" {
  enabled = false
}

## Temporarily disabled

#
rule "terraform_documented_outputs" {
  enabled = false
}

rule "terraform_documented_variables" {
  enabled = false
}
