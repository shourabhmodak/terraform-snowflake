output "warehouse_name" {
    value       = snowflake_warehouse.this.name
    description = "The name of the warehouse created"
}