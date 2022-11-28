resource "aws_iam_role" "dagster_user_deployment" {
  for_each = local.user_deployments
  name = "${each.value.ksa_name}-sa-role"
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
            "${var.eks_oidc_issuer_url}:sub" : "system:serviceaccount:${each.value.namespace}:${each.value.ksa_name}",
            "${var.eks_oidc_issuer_url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}



resource "helm_release" "dagster_user_deployment" {
  for_each   = local.user_deployments
  name       = each.key
  repository = "https://dagster-io.github.io/helm"
  chart      = "dagster-user-deployments"
  namespace  = each.value.namespace
  values     = [
    templatefile(
      "${path.module}/files/user_deployment.yaml",
      {
        ksa_name                         = each.value.ksa_name
        service_account_aws_iam_role_arn = aws_iam_role.dagster_user_deployment[each.key].arn
        postgresql_secret_name           = var.postgresql_secret_name
        deployments                      = {
          deployments = flatten([for deployment in local.user_deployments[each.key].deployments : deployment.config])
        }
      }
    )
  ]
}