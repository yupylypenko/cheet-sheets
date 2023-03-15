resource "azurerm_resource_group" "demo" {
   name     = "<resource group name>"
   location = "<location>"
 }

resource "azurerm_virtual_network" "demo" {
   name                = "vnet"
   address_space       = ["10.0.0.0/16"]
   resource_group_name = azurerm_resource_group.demo.name
   location            = azurerm_resource_group.demo.location
 }

 resource "azurerm_subnet" "demo" {
   name                 = "subnet"
   resource_group_name  = azurerm_resource_group.demo.name
   virtual_network_name = azurerm_virtual_network.demo.name
   address_prefixes     = ["10.0.0.0/24"]
 }

 resource "azurerm_public_ip" "demo" {
   name                        = "publicIpForLB"
   resource_group_name         = azurerm_resource_group.demo.name
   location                    = azurerm_resource_group.demo.location
   allocation_method           = "Static"
 }

 