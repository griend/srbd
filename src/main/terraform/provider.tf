terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.21.0"
    }
  }
}

provider "linode" {
  token = var.token
}
