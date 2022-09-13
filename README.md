# Rancher Breadth Check Cluster Roles

> Terraform to test performance & functionality of some code in rancher that was checking depth of calls. This is checking to make sure a breadth use case is not affected.

### How to Use

#### What Your `TFVARS` File Should Look Like

This file `terraform.tfvars` should sit next to the `main.tf` file.

🚨 `WARNING!` Make sure `terraform.tfvars` IS NOT TRACKED WITH GIT / UPLOADED TO GitHub 🚨

```tf
# Variable section

rancher_url       = "enter-your-rancher-url-here"
rancher_token_key = "enter-your-admin-token-here"
role_count        = 1100
```