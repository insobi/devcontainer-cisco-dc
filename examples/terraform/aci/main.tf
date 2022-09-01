terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.1.0"
    }
  }
  required_version = ">=0.13.4"
}

provider "aci" {
  username = var.aci_user
  password = var.aci_pw
  url      = var.aci_url
  insecure = var.aci_insecure
}

resource "aci_tenant" "tenant" {
    name = "myTenant"
}