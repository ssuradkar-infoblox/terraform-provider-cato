# WAN Firewall Rule Examples

## Why `provider.tf` Was Added

The existing `resource.tf` in this directory contains example `cato_wf_rule` and `cato_wf_section` resource definitions, but was missing the required `terraform` and `provider` blocks. Without these blocks, `terraform init` would fail because Terraform has no way to resolve the `cato` provider.

`provider.tf` was added to supply:
- The `terraform.required_providers` block — tells Terraform to download the `catonetworks/cato` provider.
- The `provider "cato"` block — configures the API endpoint, authentication token, and account ID.
- Input variables (`cato_token`, `account_id`) — so credentials are passed via environment variables (`TF_VAR_cato_token`, `TF_VAR_account_id`) instead of being hardcoded.

With `provider.tf` in place, the existing `resource.tf` examples can be used directly:
```bash
export TF_VAR_cato_token="your-api-key"
export TF_VAR_account_id="your-account-id"
cd examples/resources/cato_wf_rule
terraform init
terraform apply -parallelism=1
```

## About `wf_rule_terraform/main.tf`

The `wf_rule_terraform/` subdirectory contains a self-contained, standalone example for creating a single WAN firewall rule. It includes the provider configuration and a single rule definition in one file (`main.tf`).

**What the rule does:**
- **Name:** `wf_rule_terraform`
- **Action:** ALLOW
- **Direction:** TO
- **Source:** Site `SATISH-AWS-AP-East-1-vSocket`
- **Destination:** IP `10.10.10.10`
- **Tracking:** Event logging enabled

**Usage:**
```bash
export TF_VAR_cato_token="your-api-key"
export TF_VAR_account_id="your-account-id"
cd examples/resources/cato_wf_rule/wf_rule_terraform
terraform init
terraform apply -parallelism=1
```

> **Note:** The `-parallelism=1` flag is recommended by Cato Networks since their API requires sequential execution.
