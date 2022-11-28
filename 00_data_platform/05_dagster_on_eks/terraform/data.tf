data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "data_eks" {
  name = data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_id
}
data "aws_eks_cluster" "data_eks" {
  name = data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_id
}