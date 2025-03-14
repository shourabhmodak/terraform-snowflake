
terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "1.0.4"
      configuration_aliases = [ snowflake.sysadmin ]
    }
  }
}

resource "snowflake_warehouse" "this" {
  name                         = var.name
  comment                      = var.comment

  warehouse_size               = local.warehouse_size
  auto_suspend                 = local.auto_suspend
  auto_resume                  = local.auto_resume
  statement_timeout_in_seconds = local.statement_timeout_in_seconds

  # Generic properties
  initially_suspended = true

  provider = snowflake.sysadmin
}