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

resource "cato_wf_section" "terraform_section" {
  at = {
    position = "LAST_IN_POLICY"
  }
  section = {
    name = "Terraform Rules"
  }
}

resource "cato_wf_rule" "wf_rule_terraform" {
  at = {
    position = "FIRST_IN_SECTION"
    ref      = cato_wf_section.terraform_section.section.id
  }
  rule = {
    name      = "wf_rule_terraform"
    enabled   = true
    action    = "BLOCK"
    direction = "TO"
    source = {
      site = [
        {
          name = "SATISH-AWS-AP-East-1-vSocket"
        }
      ]
    }
    destination = {
      ip = ["10.10.10.10"]
    }
    application = {}
    tracking = {
      event = {
        enabled = true
      }
    }
  }
}
