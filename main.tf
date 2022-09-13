terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.22.2"
    }
  }
}

provider "rancher2" {
  api_url   = var.rancher_url
  token_key = var.rancher_token_key
  insecure  = true
}

data "rancher2_role_template" "role_list" {
  count      = var.role_count
  name       = "foo-${count.index + 1}"
  depends_on = [rancher2_role_template.foo]
}

# Create a new rancher2 cluster Role Template
resource "rancher2_role_template" "foo" {
  count        = var.role_count
  name         = "foo-${count.index + 1}"
  context      = "cluster"
  default_role = true
  description  = "Terraform role template acceptance test"
  rules {
    api_groups = ["*"]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
}

locals {
  dadfish = [for id in data.rancher2_role_template.role_list : id.id]
}

# Create a new rancher2 cluster Role Template
resource "rancher2_role_template" "bar" {
  name         = "bar"
  context      = "cluster"
  default_role = true
  description  = "Terraform role template acceptance test"
  rules {
    api_groups = ["*"]
    resources  = ["secrets"]
    verbs      = ["create"]
  }
  role_template_ids = local.dadfish
}

# Variable section

variable "rancher_url" {
  type        = string
  description = "URL for Rancher."
}

variable "rancher_token_key" {
  type        = string
  description = "API bearer token for Rancher."
  sensitive   = true
}

variable "role_count" {
  type        = number
  description = "Amount of roles that you would like to create within Rancher."
}
