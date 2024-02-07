terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "~> 0.76"
    }
  }
}
#specifing the provider
provider "snowflake" {
  username = var.username
  password = var.password
  account  = var.account
  role = var.snowflake_role
}
#creating warehouse
resource "snowflake_warehouse" "test_warehouse" {
  name           = var.warehouse_name
  comment        = "foo"
  warehouse_size = "x-small"
  depends_on = [ snowflake_warehouse.test_warehouse ]
}
#creating db
resource "snowflake_database" "test_database" {
  name                        = var.database_name
  comment                     = "test comment"
  data_retention_time_in_days = 3
  depends_on = [ snowflake_warehouse.test_warehouse ]
}
#creating schema
resource "snowflake_schema" "test_schema" {
  database = var.database_name
  name     = var.schema_name
  comment  = "A schema."
  is_transient        = false
  is_managed          = false
  data_retention_days = 1
  depends_on = [ snowflake_warehouse.test_warehouse, snowflake_database.test_database ]
}
#creating table
resource "snowflake_table" "test_table" {
  database                    = snowflake_database.test_database.name
  schema                      = snowflake_schema.test_schema.name
  name                        = var.table_name
  column {
    name = "ID"
    type = "INTEGER"
  }
  column {
    name = "name"
    type = "VARCHAR(100)"
  }
  column {
    name = "time"
    type = "TIMESTAMP_LTZ"
  }
  column {
    name = "b"
    type = "BOOLEAN"
  }
  
  depends_on = [ snowflake_database.test_database, snowflake_schema.test_schema, snowflake_warehouse.test_warehouse ]
}
#creating role
resource "snowflake_role" "role1" {
  name    = var.role_name
  comment = "A role."
  
}
#giving the role access to warehouse
resource "snowflake_grant_privileges_to_role" "warehouse_grant" {
  role_name  = snowflake_role.role1.name
  privileges = ["USAGE"]
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.test_warehouse.name
  }
}
#giving the role access to db
resource "snowflake_grant_privileges_to_role" "db_grant" {
  privileges = ["USAGE"]
  role_name  = snowflake_role.role1.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.test_database.name
  }
}
#giving the role access to schema
resource "snowflake_schema_grant" "schema_grant" {
  schema_name   = snowflake_schema.test_schema.name
  database_name = snowflake_database.test_database.name
  roles = [snowflake_role.role1.name]
  with_grant_option = true
}
#giving the role access to table(select only)
resource "snowflake_table_grant" "role_grant" {
  database_name = snowflake_database.test_database.name
  schema_name   = snowflake_schema.test_schema.name
  table_name    = snowflake_table.test_table.name
  privilege     = "SELECT"
  roles         = [snowflake_role.role1.name] 
  depends_on = [snowflake_role.role1,
    snowflake_database.test_database, snowflake_schema.test_schema,
  snowflake_table.test_table]
}