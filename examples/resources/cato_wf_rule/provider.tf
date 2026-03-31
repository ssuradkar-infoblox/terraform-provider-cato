terraform {
  required_providers {
    cato = {
      source = "catonetworks/cato"
    }
  }
}

provider "cato" {
  baseurl    = "https://api.catonetworks.com/api/v1/graphql2"
  token      = var.cato_token
  account_id = var.account_id
}

variable "cato_token" {
  type      = string
  sensitive = true
}

variable "account_id" {
  type = string
}
