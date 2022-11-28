
module "dagster" {
  source = "../../../libraries/datafoundation-terraform-modules/domain_dagster"

  # Global configuration
  domain_name  = "business"
  repositories = var.repositories

  # Postgres configurations
  postgresql_host        = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_endpoint
  postgresql_username    = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_username
  postgresql_password    = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_password
  postgresql_database    = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.postgres_database_name
  postgresql_secret_name = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.aws_eks_postgresql_secret_name

  # EKS configurations
  eks_namespace         = data.terraform_remote_state.data_core_eks.outputs.business_team_namespace
  eks_oidc_issuer_url   = local.eks_oidc_issuer_url
  eks_oidc_provider_arn = local.eks_oidc_provider_arn

  # AWS configurations
  aws_partition  = local.partition
  aws_account_id = local.account_id

}

resource "aws_iam_role_policy_attachment" "business" {
  role       = module.dagster.aws_iam_role_name
  policy_arn = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.bucket_read_write_policy_arn
}

resource "aws_iam_role_policy_attachment" "dagster_user_deployment" {
  for_each   = module.dagster.user_deployments_iam_role
  role       = module.dagster.user_deployments_iam_role[each.key].name
  policy_arn = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.dagster_bucket_read_write_policy_arn
}