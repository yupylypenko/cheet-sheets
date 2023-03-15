resource "azurerm_resource_group" "demo" {
  name     = "<rg name>"
  location = "<location>"
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "demo" {
  name                = "tfex-cosmos-db-${random_integer.ri.result}"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200   
  }

  geo_location {
    location          = "eastus"
    failover_priority = 0
  }
}

resource "azurerm_container_group" "demo" {
  name                = "demo"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name
  ip_address_type     = "public"
  dns_name_label      = "demo"
  os_type             = "linux"

  container {
    name   = "demo"
    image  = "mcr.microsoft.com/azuredocs/azure-vote-front:cosmosdb"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }

    secure_environment_variables = {
      "COSMOS_DB_ENDPOINT"  = azurerm_cosmosdb_account.demo.endpoint
      "COSMOS_DB_MASTERKEY" = azurerm_cosmosdb_account.demo.primary_master_key
      "TITLE"               = "Best Superhero!"
      "VOTE1VALUE"          = "Batman"
      "VOTE2VALUE"          = "Superman"
    }
  }
}