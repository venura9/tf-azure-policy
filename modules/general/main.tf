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

resource "azurerm_policy_assignment" "general-policy-set-assignment" {
  name                 = "General Policy Set"
  scope                = var.applied_scope_id
  policy_definition_id = azurerm_policy_set_definition.general-polciy-set-def.id

  description  = "Collection of General Policy applicable to a specified scope"
  display_name = "General Policy Set"

  identity {
    type     = "SystemAssigned"
  }
 location = var.identity_location
 
 parameters = <<PARAMETERS
    {
      "allowedLocations": {
         "value": ${var.allowed_locations}
      }
    }
  PARAMETERS
}

resource "azurerm_policy_set_definition" "general-polciy-set-def" {

  name                  = "General Policy Set"
  policy_type           = "Custom"
  display_name          = "General Policy Set"
  management_group_name = var.stored_management_group_id

  parameters = <<PARAMETERS
    {
      "allowedLocations": {
          "type": "Array",
          "metadata": {
              "description": "The list of allowed locations for resources.",
              "displayName": "Allowed locations",
              "strongType": "location"
          }
      }
    }
  PARAMETERS

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
    parameter_values     = <<VALUE
    {
      "listOfAllowedLocations": {"value": "[parameters('allowedLocations')]"}
    }
    VALUE
  }
}
