resource "aws_iam_role" "dagster" {
  name               = "${local.dagster_ksa_name}-sa-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : local.eks_oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.eks_oidc_issuer_url}:sub" : "system:serviceaccount:${ data.terraform_remote_state.data_core_eks.outputs.aws_eks_dagster_namespace}:${local.dagster_ksa_name}",
            "${local.eks_oidc_issuer_url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dagster" {
  role       = aws_iam_role.dagster.name
  policy_arn = data.terraform_remote_state.data_foundation_dagster_foundation.outputs.dagster_bucket_read_write_policy_arn
}

resource "kubernetes_role" "dagster" {
  count = length(local.namespaces)
  metadata {
    name      = "dagster-${local.namespaces[count.index]}-role"
    namespace = local.namespaces[count.index]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "jobs/status"]
    verbs      = ["*"]
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/log", "pods/status"]
    verbs      = ["*"]
  }
}

resource "kubernetes_role_binding" "dagster" {
  count = length(local.namespaces)
  metadata {
    name      = "dagster-${local.namespaces[count.index]}"
    namespace = local.namespaces[count.index]
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.dagster[count.index].metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = local.dagster_ksa_name
    namespace = data.terraform_remote_state.data_core_eks.outputs.aws_eks_dagster_namespace
  }
}