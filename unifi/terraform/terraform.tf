
terraform {
  # cloud {
  #   organization = "vyas-n"
  #   workspaces {
  #     name = "unifi_terraform"
  #   }
  # }
  required_providers {
    onepassword = {
      source  = "1Password/onepassword"
      version = "2.1.2"
    }
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.41.2"
    }
  }
}

provider "unifi" {
  api_url        = "https://192.168.2.1"
  allow_insecure = true

  username = data.onepassword_item.unifi_gateway_homelab.username
  password = data.onepassword_item.unifi_gateway_homelab.password
}

provider "onepassword" {
  # verify that this matches with: `op account ls | from ssv | get "URL".0`
  account = "my.1password.com"
}
