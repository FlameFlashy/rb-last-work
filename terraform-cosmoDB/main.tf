resource "azurerm_resource_group" "example" {
  name     = "rb-rare-teal"
  location = "West Europe"
}

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_cosmosdb_account" "db" {
  name                = "sokolov-cosmos-db"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  geo_location {
    location          = "westeurope"
    failover_priority = 1
  }

  geo_location {
    location          = "westeurope"
    failover_priority = 0
  }
}

data "azurerm_cosmosdb_account" "db" {
  name                = "sokolov-cosmos-db"
  resource_group_name = "rb-rare-teal"
}

resource "azurerm_cosmosdb_mongo_database" "db" {
  name                = "tfex-cosmos-mongo-db"
  resource_group_name = data.azurerm_cosmosdb_account.db.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.db.name
  throughput          = 400
}
