resource "azurerm_service_plan" "sp" {
    name = "sp-${ var.project }-${var.environment}"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    sku_name = "B1"
    os_type = "Linux"
}

resource "azurerm_linux_web_app" "webappui" {
    name = "ui-${var.project}-${var.environment}-1"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.sp.id

    //definir el metodo deployment de la app
    site_config {
        always_on = true
        application_stack { //bajo asp, phyton, node, docker..
            docker_registry_url = "https://index.docker.io" //pull de las imagenes de docker con los contenedores
            docker_image_name = "nginx:latest"//imagen asociada a la webapp
        }
    }

    //variables environment que se decidieron en la webapp
    app_settings = {
        WEBSITES_PORT = "80"
    }

    tags = var.tags
}

resource "azurerm_linux_web_app" "webappapi" {
    name = "api-${var.project}-${var.environment}"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.sp.id

    //definir el metodo deployment de la app
    site_config {
        always_on = true
        application_stack { //bajo asp, phyton, node, docker..
            docker_registry_url = "https://index.docker.io" //pull de las imagenes de docker con los contenedores
            docker_image_name = "nginx:latest"//magen asociada a la webapp
        }
    }

    //variables environment que se decidieron en la webapp
    app_settings = {
        WEBSITES_PORT = "80"
    }

    tags = var.tags
}