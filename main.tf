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
  role = "ACCOUNTADMIN"
}

provider "snowflake" {
  alias = "securityadmin"
  organization_name      = var.snowflake_organisation    
  account_name           = var.snowflake_account
  user                   = var.snowflake_user
  authenticator          = "SNOWFLAKE_JWT"
  private_key            = file("~/.ssh/svc_tf_key.p8")
  role = "SECURITYADMIN"
}

provider "snowflake" {
  alias = "sysadmin"
  organization_name      = var.snowflake_organisation    
  account_name           = var.snowflake_account
  user                   = var.snowflake_user
  authenticator          = "SNOWFLAKE_JWT"
  private_key            = file("~/.ssh/svc_tf_key.p8")
  role = "SYSADMIN"
}

resource "snowflake_database" "example" {
  provider = snowflake.sysadmin
  name = "DEMO_DB"
}
