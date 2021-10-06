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

resource "linode_stackscript" "demo" {
  label       = "demo"
  description = "Sets up the node"
  script      = <<EOF
#!/bin/bash

DIST="Unknown"

if [ -x /usr/bin/lsb_release ] ; then
    DIST=$(/usr/bin/lsb_release -is)
fi

case $(lsb_release -is) in:
    Debian)
        apt-get -q update
        apt-get -q -y full-upgrade
        apt-get clean
        ;;
esac
EOF
  images      = ["linode/debian11"]
}

resource "linode_instance" "demo" {
  image           = "linode/debian11"
  label           = "demo"
  group           = "demo"
  region          = "eu-central"
  type            = "g6-standard-1"
  authorized_keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAtBQ/gFn5J5/S2mBISA5lxoxxt3Kv0Tv3WGPEJQMqdu cees@griend.eu"]
  root_pass       = random_string.linode_root_password.result
  stackscript_id  = linode_stackscript.demo.id
}

resource "linode_domain_record" "demo4" {
  domain_id   = var.linode_domain_id
  name        = "demo"
  record_type = "A"
  target      = linode_instance.demo.ip_address
  ttl_sec     = 300
}
