resource "azurerm_resource_group" "new" {
  name     = "${local.prefix}-rg"
  location = var.location
  tags     = local.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_virtual_network" "new" {
  name                = "${local.prefix}-vnet"
  resource_group_name = azurerm_resource_group.new.name
  location            = var.location
  address_space       = [var.address_space]
  tags                = local.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_subnet" "new" {
  name                      = "${local.prefix}-subnet"
  resource_group_name       = azurerm_resource_group.new.name
  virtual_network_name      = azurerm_virtual_network.new.name
  address_prefix            = local.rendered_subnet_cidr

  service_endpoints = [
    "Microsoft.KeyVault",
  ]
}

resource "azurerm_subnet_network_security_group_association" "new" {
  subnet_id                 = azurerm_subnet.new.id
  network_security_group_id = azurerm_network_security_group.new.id
}

