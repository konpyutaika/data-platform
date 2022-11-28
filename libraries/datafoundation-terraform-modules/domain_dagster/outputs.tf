output "workspaces" {
  value = local.workspaces
}

output "aws_iam_role_name" {
  value = aws_iam_role.dagit.name
}

output "user_deployments_iam_role" {
  value = aws_iam_role.dagster_user_deployment
}