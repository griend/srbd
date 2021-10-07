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

#
# Generate a random 32 long password
#
resource "random_string" "linode_root_password" {
  length  = 32
  special = true
}

output "linode_root_password" {
  value = random_string.linode_root_password.result
}

resource "linode_firewall" "demo_firewall" {
  label = "demo_firewall"
  tags  = ["demo"]

  inbound {
    label    = "allow-ssh"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = ["213.127.47.116/32"]
  }

  inbound_policy = "DROP"

  outbound_policy = "ACCEPT"

  linodes = [linode_instance.demo01.id]
}

resource "linode_instance" "demo01" {
  image           = "linode/debian11"
  label           = "demo01"
  region          = "eu-central"
  type            = "g6-standard-1"
  authorized_keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtBQ/gFn5J5/S2mBISA5lxoxxt3Kv0Tv3WGPEJQMqdu cees@griend.eu"]
  root_pass       = random_string.linode_root_password.result
  tags            = ["demo"]
}

resource "linode_domain_record" "demo01" {
  domain_id   = var.linode_domain_id
  name        = linode_instance.demo01.label
  record_type = "A"
  target      = linode_instance.demo01.ip_address
  ttl_sec     = 300
}
