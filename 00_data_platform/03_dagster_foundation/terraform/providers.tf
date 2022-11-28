provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_endpoint
  cluster_ca_certificate  = base64decode(data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.data_eks.token
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_endpoint
    cluster_ca_certificate  = base64decode(data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.data_eks.token
  }
}

provider "kubectl" {
  apply_retry_count      = 10
  host                   = data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_endpoint
  cluster_ca_certificate  = base64decode(data.terraform_remote_state.data_core_eks.outputs.aws_eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.data_eks.token
  load_config_file         = false
}