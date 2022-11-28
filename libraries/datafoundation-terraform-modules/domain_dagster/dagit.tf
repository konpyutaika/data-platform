resource "helm_release" "dagit" {
  name       = "dagster"
  repository = "https://dagster-io.github.io/helm"
  chart      = "dagster"
  namespace  = var.eks_namespace
  values     = [
    templatefile(
      "${path.module}/files/dagit.yaml",
      {
        ksa_name               = local.ksa_name
        postgresql_host        = var.postgresql_host
        postgresql_username    = var.postgresql_username
        postgresql_password    = var.postgresql_password
        postgresql_database    = var.postgresql_database
        postgresql_secret_name = var.postgresql_secret_name
        user_deployments       = local.workspaces
      }
    )
  ]
}

resource "aws_iam_role" "dagit" {
  name = "${local.ksa_name}-sa-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : var.eks_oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${var.eks_oidc_issuer_url}:sub" : "system:serviceaccount:${var.eks_namespace}:${local.ksa_name}",
            "${var.eks_oidc_issuer_url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}