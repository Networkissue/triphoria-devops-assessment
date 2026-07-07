output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "cluster_name" {
  value = module.ecs.cluster_name
}