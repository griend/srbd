terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.21.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

resource "linode_domain" "cvdg" {
  domain      = "cvdg.eu"
  soa_email   = "c.vande.griend@gmail.com"
  type        = "master"
  ttl_sec     = 300
  retry_sec   = 300
  refresh_sec = 300
  expire_sec  = 300

}

output "domain_id" {
  value = linode_domain.cvdg.id
}
