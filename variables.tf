variable "scope" {
  type    = string
  default = "/subscriptions/23156ece-4568-4f49-8b95-0aa51cc7a4c"
}

variable "allowed_locations" {
  type    = string
  default = "[\"Australia East\", \"Australia Southeast\"]"
}

variable "stored_management_group_id" {
  type    = string
  default = "a1fed89c-7184-43d7-ac4b-197bc55ef160"
}

variable "applied_scope_id" {
  type    = string
  default = "/providers/Microsoft.Management/managementGroups/a1fed89c-7184-43d7-ac4b-197bc55ef160"
}

variable "identity_location" {
  type    = string
  default = "Australia East"
}
