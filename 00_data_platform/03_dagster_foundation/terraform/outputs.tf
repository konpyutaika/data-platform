output "postgres_endpoint" {
  value = module.cluster.cluster_endpoint
}

output "postgres_username" {
  value     = module.cluster.cluster_master_username
  sensitive = true
}

output "postgres_password" {
  value     = module.cluster.cluster_master_password
  sensitive = true
}

output "postgres_database_name" {
  value = module.cluster.cluster_database_name
}

output "aws_eks_postgresql_secret_name" {
  value = kubernetes_secret.dagster_postgresql[0].metadata[0].name
}

output "dagster_bucket_read_write_policy_arn" {
  value = module.dagster_bucket.read_write_policy_arn
}