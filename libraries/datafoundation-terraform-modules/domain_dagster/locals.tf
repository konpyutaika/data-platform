locals {
  ksa_name         = "dagster-${var.domain_name}"
  user_deployments = merge(
    [
    for workspace, workspace_config in var.repositories : {
      "${workspace}" = {
        ksa_name    = "dagster-${var.domain_name}-${workspace}"
        namespace   = var.eks_namespace
        deployments = flatten([
        for deployment, config in workspace_config :
        {
          config = {
            name  = config.name,
            image = {
              repository = config.image.repository
              tag        = config.image.tag
              pullPolicy = "Always",

            },
            dagsterApiGrpcArgs = [
              "--python-file",
              config.repo_path
            ],
            port      = var.user_deployment_port
            resources = var.user_deployment_resources
          },
          host = "${config.name}.${var.eks_namespace}"
        }
        ])
      }
    }
    ]...)


  workspaces = merge(
    flatten(
      [
      for workspace, config in local.user_deployments :
      flatten([for deployment in config.deployments : { "${deployment.host}" = deployment.config.port }])
      ]
    )...
  )
}