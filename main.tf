terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.12"
    }
  }
}

provider "azurerm" {
  features {}
}

module "policy_general" {
  source                     = "./modules/general"
  scope                      = var.scope
  allowed_locations          = var.allowed_locations
  stored_management_group_id = var.stored_management_group_id
  applied_scope_id           = var.applied_scope_id
  identity_location          = var.identity_location
}

module "policy_vm" {
  source                     = "./modules/virtual-machines"
  scope                      = var.applied_scope_id
  stored_management_group_id = var.stored_management_group_id
  applied_scope_id           = var.applied_scope_id
  identity_location          = var.identity_location
}

