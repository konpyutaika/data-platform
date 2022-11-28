locals {
  namespaces = [
    data.terraform_remote_state.data_core_eks.outputs.aws_eks_dagster_namespace,
    data.terraform_remote_state.data_core_eks.outputs.product_team_namespace,
    data.terraform_remote_state.data_core_eks.outputs.business_team_namespace,
  ]
}