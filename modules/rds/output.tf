output "rds_endpoint" {
  value       = aws_db_instance.mysql_db.endpoint
  description = "The connection endpoint for the MySQL database"
}