output "eks_namespace" {
  value = helm_release.dagster.namespace
}