resource "azurerm_mssql_server" "sqlserver" {
    name = "dbserver-${ var.project }-${ var.environment }"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    version = "12.0"
    administrator_login = "sqladmin"
    administrator_login_password = var.admin_sql_password

    tags = var.tags
}

resource "azurerm_mssql_database" "db" {
    name = "${ var.project }db"
    server_id = azurerm_mssql_server.sqlserver.id
    sku_name = "S0"
    tags = var.tags
}

resource "azurerm_redis_cache" "db-cache-redis" {
    name                 = "db-redis-${var.project}1"
    location             = var.location
    resource_group_name  = azurerm_resource_group.rg.name

    capacity             = 1 //250MB
    family               = "C" //familia del sku -> C = Basic/Standard
    sku_name             = "Basic"

    non_ssl_port_enabled = true   //facilitar pruebas sin cifrado
    minimum_tls_version  = "1.2"  //establecer el nivel mínimo de seguridad TLS (Transport Layer Security)

    redis_configuration {
    }

    tags = var.tags
}