variable "name" {
  description = "Name of the Snowflake warehouse"
}

variable "size" {
  description = "Size of the Snowflake warehouse"
}

variable "auto_suspend" {
  description = "Time in seconds before the warehouse auto-suspends"
}

variable "auto_resume" {
  description = "Whether the warehouse should automatically resume"
}

variable "statement_timeout_in_seconds" {
  description = "Timeout in seconds before the query gets cancelled"
  default     = 300
}

variable "comment" {
  description = "Optional comment for the warehouse"
  default     = "Managed by Terraform"
}