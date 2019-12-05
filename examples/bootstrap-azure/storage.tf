

# A Storage account is required for the TFE Production Mode.
resource "azurerm_storage_account" "new" {
  name                     = "${local.prefix}sa"
  #name                     = lower("${local.prefix}sa")
  resource_group_name      = "${azurerm_resource_group.new.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  tags                     = "${local.tags}"
}

# We need a blob container.
resource "azurerm_storage_container" "new" {
  name                     = "${local.prefix}-container"
  #name                     = lower("${local.prefix}-container")
  resource_group_name      = "${azurerm_resource_group.new.name}"
  storage_account_name     = "${azurerm_storage_account.new.name}"
  container_access_type    = "private"
}

resource "azurerm_key_vault_secret" "tfesa" {
  name                     = "tfesa-access-key"
  value                    = "${azurerm_storage_account.new.primary_access_key}"
  key_vault_id             = "${azurerm_key_vault.new.id}"
  tags                     = "${local.tags}"
}
