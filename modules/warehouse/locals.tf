locals {
    warehouse_size = var.size != null ? var.size : "XSMALL"
    auto_suspend = var.auto_suspend != null ? var.auto_suspend : 60
    auto_resume = var.auto_resume != null ? var.auto_resume : true
    statement_timeout_in_seconds = var.statement_timeout_in_seconds != null ? var.statement_timeout_in_seconds : 900
}