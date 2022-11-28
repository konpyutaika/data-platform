output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = module.eks_blueprints.configure_kubectl
}

output "business_team" {
  description = "Role Arn of business team"
  value       = module.eks_blueprints.teams[*].application_teams_iam_role_arn["business"]
}

output "business_team_namespace" {
  description = "Kubernetes namespace of business team"
  value       = "business"
}

output "product_team" {
  description = "Role Arn of product team"
  value       = module.eks_blueprints.teams[*].application_teams_iam_role_arn["product"]
}

output "product_team_namespace" {
  description = "Kubernetes namespace of product team"
  value       = "product"
}

output "platform_team" {
  description = "Role Arn of platform-team"
  value       = module.eks_blueprints.teams[*].platform_teams_iam_role_arn["admin"]
}


output "aws_eks_cluster_id" {
  description = "EKS cluster's id"
  value       = module.eks_blueprints.eks_cluster_id
}

output "aws_eks_cluster_endpoint" {
  description = "EKS cluster's host"
  value       = module.eks_blueprints.eks_cluster_endpoint
}

output "aws_eks_cluster_certificate_authority_data" {
  description = "EKS cluster's certificate authority data"
  value       = module.eks_blueprints.eks_cluster_certificate_authority_data
}


output "aws_eks_dagster_namespace" {
  value = kubernetes_namespace.system_dagster.metadata[0].name
}

output "cluster_primary_security_group_id" {
  value = module.eks_blueprints.cluster_primary_security_group_id
}