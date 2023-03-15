resource "azurerm_network_interface" "demo" {
   count               = 2
   name                = "nic${count.index}"
   location            = azurerm_resource_group.demo.location
   resource_group_name = azurerm_resource_group.demo.name

   ip_configuration {
     name                          = "demoConfiguration"
     subnet_id                     = azurerm_subnet.demo.id
     private_ip_address_allocation = "dynamic"
   }
 }

resource "azurerm_managed_disk" "demo" {
   count                = 2
   name                 = "datadisk_existing_${count.index}"
   location             = azurerm_resource_group.demo.location
   resource_group_name  = azurerm_resource_group.demo.name
   storage_account_type = "Standard_LRS"
   create_option        = "Empty"
   disk_size_gb         = "1023"
 }

resource "azurerm_availability_set" "demo" {
   name                         = "avset"
   location                     = azurerm_resource_group.demo.location
   resource_group_name          = azurerm_resource_group.demo.name
   platform_fault_domain_count  = 2
   platform_update_domain_count = 2
   managed                      = true
 }

resource "azurerm_virtual_machine" "demo" {
   count                 = 2
   name                  = "vm${count.index}"
   location              = azurerm_resource_group.demo.location
   availability_set_id   = azurerm_availability_set.demo.id
   resource_group_name   = azurerm_resource_group.demo.name
   network_interface_ids = [element(azurerm_network_interface.demo.*.id, count.index)]
   vm_size               = "Standard_DS1_v2"

   storage_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "16.04-LTS"
     version   = "latest"
   }

   storage_os_disk {
     name              = "myosdisk${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
   }

   # Optional data disks
   storage_data_disk {
     name              = "datadisk_new_${count.index}"
     managed_disk_type = "Standard_LRS"
     create_option     = "Empty"
     lun               = 0
     disk_size_gb      = "1023"
   }

   storage_data_disk {
     name            = element(azurerm_managed_disk.demo.*.name, count.index)
     managed_disk_id = element(azurerm_managed_disk.demo.*.id, count.index)
     create_option   = "Attach"
     lun             = 1
     disk_size_gb    = element(azurerm_managed_disk.demo.*.disk_size_gb, count.index)
   }

   os_profile {
     computer_name  = "hostname"
     admin_username = "demoadmin"
     admin_password = "Password1234!"
   }

   os_profile_linux_config {
     disable_password_authentication = false
   }

   tags = {
     environment = "staging"
   }
 }