locals {
  partition             = data.aws_partition.current.partition
  account_id            = data.aws_caller_identity.current.account_id
  eks_oidc_issuer_url   = replace(data.aws_eks_cluster.data_eks.identity[0].oidc[0].issuer, "https://", "")
  eks_oidc_provider_arn = "arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.eks_oidc_issuer_url}"
  dagster_ksa_name      = "dagster"

  workspace_configmap = "dagster-federated-workspace"

  namespaces = [
    data.terraform_remote_state.data_core_eks.outputs.aws_eks_dagster_namespace,
    data.terraform_remote_state.data_core_eks.outputs.product_team_namespace,
    data.terraform_remote_state.data_core_eks.outputs.business_team_namespace,
  ]
}