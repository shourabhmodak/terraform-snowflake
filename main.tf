terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.69.0"
    }
  }
}

provider "snowflake" {
  organization_name      = var.snowflake_organisation    
  account_name           = var.snowflake_account
  user                   = var.snowflake_user
  private_key            = file("~/.ssh/svc_tf_key.p8")
  #private_key_passphrase = var.private_key_passphrase

  role = "SYSADMIN"
}

resource "snowflake_database" "example" {
  name = "DEMO_DB"
}
