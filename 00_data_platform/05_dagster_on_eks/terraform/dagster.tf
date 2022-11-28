locals {
  servers = flatten([for host, port in merge(data.terraform_remote_state.domain_business_dagster.outputs.workspaces, data.terraform_remote_state.domain_product_dagster.outputs.workspaces): {
    host = host,
    port = port,
    name = host
  }])
}

# Kubernetes configuration
resource "helm_release" "dagster" {
  name       = "dagster"
  repository = "https://dagster-io.github.io/helm"
  chart      = "dagster"
  namespace  = data.terraform_remote_state.data_core_eks.outputs.aws_eks_dagster_namespace
  values     = [
    templatefile(
      "${path.module}/files/dagster.yaml",
      {
        ksa_name               = local.dagster_ksa_name
        postgresql_host        = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_endpoint
        postgresql_username    = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_username
        postgresql_password    = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_password
        postgresql_database    = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_database_name
        postgresql_secret_name = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.aws_eks_postgresql_secret_name
        workspace_servers      = { servers = local.servers }
      }
    )
  ]
}


