resource "azurerm_lb" "demo" {
   name                = "loadBalancer"
   resource_group_name = azurerm_resource_group.demo.name
   location            = azurerm_resource_group.demo.location

   frontend_ip_configuration {
     name                 = "publicIPAddress"
     public_ip_address_id = azurerm_public_ip.demo.id
   }
 }

 resource "azurerm_lb_backend_address_pool" "demo" {
   loadbalancer_id     = azurerm_lb.demo.id
   name                = "BackendAddressPool"
 }

