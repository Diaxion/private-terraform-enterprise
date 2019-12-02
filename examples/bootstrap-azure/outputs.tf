output "resource_group_name" {
  value = "${azurerm_resource_group.new.name}"
}

output "virtual_network_name" {
  value = "${azurerm_virtual_network.new.name}"
}

output "subnet" {
  value = "${azurerm_subnet.new.name}"
}

output "key_vault_name" {
  value = "${azurerm_key_vault.new.name}"
}

output "storage_account_name" {
  value = "${azurerm_storage_account.new.name}"
}

output "storage_container_name" {
  value = "${azurerm_storage_container.new.name}"
}