variable "target_env" {}
variable "vpc_id" {}
variable "db_subnet_group_name" {}
variable "db_name" { default = "wordpressdb" }
variable "db_username" { default = "dbadmin" }
variable "db_password" {sensitive = true}