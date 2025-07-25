variable "subscription_id" {
    type = string
    description = "The azure description ID"
}

variable "project" {
    type = string
    description = "The name of the project"
    default = "musicreview"
}

variable "environment" {
    type = string
    description = "The environment to deploy"
    default = "dev"
}

variable "location" {
    type = string
    description = "The Azure region to deploy resources"
    default = "Central US"
}

variable "tags" {
    type = map(string)
    description = "A map of tags to apply to all resource"
    default = {
        enviroments = "development"
        date = "julio-2025"
        createdBy = "Terraform"
    }
}

variable "admin_sql_password" {
    type = string
    description = "The password for the SQL administrator"
}