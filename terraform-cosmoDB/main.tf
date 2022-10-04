data "azurerm_cosmosdb_mongo_database" "example" {
  name                = "test-cosmosdb-mongo-db"
  resource_group_name = "rb-rare-teal"
  account_name        = "sokolov"
}

output "id" {
  value = data.azurerm_cosmosdb_mongo_database.example.id
}
