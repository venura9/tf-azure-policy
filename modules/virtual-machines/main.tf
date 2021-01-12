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

resource "azurerm_policy_assignment" "vm-policy-set-assignment" {
  name                 = "VM Policy Set"
  scope                = var.applied_scope_id
  policy_definition_id = azurerm_policy_set_definition.vm-polciy-set-def.id

  description  = "Collection of VM Policy applicable to a specified scope"
  display_name = "VM Policy Set"

  location = var.identity_location
}

resource "azurerm_policy_set_definition" "vm-polciy-set-def" {

  name                  = "VM Policy Set"
  policy_type           = "Custom"
  display_name          = "VM Policy Set"
  management_group_name = var.stored_management_group_id

  policy_definition_reference {
    # "Audit virtual machines without disaster recovery configured"
    # Applicable Effects: auditIfNotExists
    # Parameters: None
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0015ea4d-51ff-4ce3-8d8c-f3f8f0179a56"
  }

  policy_definition_reference {
    # "Audit VMs that do not use managed disks"
    # Applicable Effects: Audit
    # Parameters: None
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
  }

  policy_definition_reference {
    # "Azure Backup should be enabled for Virtual Machines"
    # Applicable Effects: auditIfNotExists(Default), Disabled
    # Parameters: effect
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
  }

}
