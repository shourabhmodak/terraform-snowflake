terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "1.0.4"
    }
  }
}

provider "snowflake" {
  alias = "accountadmin"
  organization_name      = var.snowflake_organisation    
  account_name           = var.snowflake_account
  user                   = var.snowflake_user
  authenticator          = "SNOWFLAKE_JWT"
  private_key            = file("~/.ssh/svc_tf_key.p8")
  role = "accountadmin"
}

provider "snowflake" {
  alias = "securityadmin"
  organization_name      = var.snowflake_organisation    
  account_name           = var.snowflake_account
  user                   = var.snowflake_user
  authenticator          = "SNOWFLAKE_JWT"
  private_key            = file("~/.ssh/svc_tf_key.p8")
  role = "securityadmin"
}

provider "snowflake" {
  alias = "sysadmin"
  organization_name      = var.snowflake_organisation    
  account_name           = var.snowflake_account
  user                   = var.snowflake_user
  authenticator          = "SNOWFLAKE_JWT"
  private_key            = file("~/.ssh/svc_tf_key.p8")
  role = "sysadmin"
}

# provider "snowflake" {
#   organization_name      = var.snowflake_organisation    
#   account_name           = var.snowflake_account
#   user                   = var.snowflake_user
#   authenticator          = "SNOWFLAKE_JWT"
#   private_key            = file("~/.ssh/svc_tf_key.p8")
#   role = "sysadmin"
# }

# Read the YAML config file
locals {
  warehouse_config = yamldecode(file("./config/warehouses.yaml"))
}

# Loop through each warehouse and pass properties (use defaults when missing)
module "warehouses" {
  for_each = { for wh in local.warehouse_config.warehouses : wh.name => wh }

  source = "./modules/warehouse"

  name         = each.value.name
  size         = try(each.value.size, null) # Use null to trigger module defaults
  auto_suspend = try(each.value.auto_suspend, null)
  auto_resume  = lookup(each.value, "auto_resume", null)
  statement_timeout_in_seconds  = lookup(each.value, "statement_timeout_in_seconds", null)
  comment      = lookup(each.value, "comment", null)

  providers = {
    snowflake.sysadmin = snowflake.sysadmin
  }
}
