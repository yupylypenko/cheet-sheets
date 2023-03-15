resource "azurerm_virtual_machine_scale_set" "demo" {
   name                = "vmscaleset"
   location            = var.location
   resource_group_name = azurerm_resource_group.demo.name
   upgrade_policy_mode = "Manual"
   sku {
     name     = "Standard_DS1_v2"
     tier     = "Standard"
     capacity = 2
   }    

   storage_profile_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "16.04-LTS"
     version   = "latest"
   }    

   storage_profile_os_disk {
     name              = ""
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
   }    

   storage_profile_data_disk {
     lun          = 0
     caching        = "ReadWrite"
     create_option  = "Empty"
     disk_size_gb   = 10
   }    

   os_profile {
     computer_name_prefix = "vmlab"
     admin_username       = var.admin_user
     admin_password       = var.admin_password
     custom_data          = file("./web.conf")
   }    

   os_profile_linux_config {
     disable_password_authentication = false
   }    

   network_profile {
     name    = "terraformnetworkprofile"
     primary = true    

     ip_configuration {
       name                                   = "IPConfiguration"
       subnet_id                              = azurerm_subnet.demo.id
       load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
       primary = true
     }
   }    

   tags = var.tags
}