provider "azurerm" {
    subscription_id = var.subscription_id
    features {} //configuraciones globales en la suscripcion
}

//rg: nombre del objeto a nivel del proyecto
resource "azurerm_resource_group" "rg" {
    name = "rg-${var.project}-${var.environment}" //nombre del recurso cuando se despliega en azure
    location = var.location //proveedor
    tags = var.tags //información de proyecto
}

resource "azurerm_data_factory" "adf" {
    name                = "adf-${var.project}-${var.environment}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name

    identity {
        type = "SystemAssigned"
    }

    tags = var.tags
}

resource "azurerm_application_insights" "appi" {
    name                = "appi-${var.project}-${var.environment}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    application_type    = "web"
    workspace_id        = null

    tags = var.tags
}

