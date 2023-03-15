output "resource_group_name" {
  value = azurerm_resource_group.demo.name
}

output "vnet_address_space" {
  value = azurerm_virtual_network.demo.address_space[0]
}

output "subnet_prefixes" {
  value = azurerm_subnet.demo.address_prefixes[0]
}

output "vm0_private_ip" {
  value = azurerm_network_interface.comics.0.private_ip_address
}

output "vm1_private_ip" {
  value = azurerm_network_interface.comics.1.private_ip_address
}

output "public_ip_address" {
  value = azurerm_public_ip.demo.ip_address
}

output "location" {
  value = azurerm_resource_group.demo.location
}
