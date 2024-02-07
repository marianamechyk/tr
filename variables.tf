variable "account" {
  type = string
}
variable "password" {
  type = string
}
variable "username" {
  type = string
}

variable "warehouse_name" {
  description = "warehouse1"
  type        = string
}

variable "database_name" {
  description = "database1"
  type        = string
}

variable "schema_name" {
  description = "schema1"
  type        = string
}

variable "role_name" {
  description = "role1"
  type        = string
}

variable "table_name" {
  description = "table1"
  type        = string
}
variable "snowflake_region" {
  type = string

}

variable "snowflake_role" {
  type = string

}

terraform {
  required_version = ">= 0.13"
}