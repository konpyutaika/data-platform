module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.17.0"

  cluster_name    = local.name

  # EKS Cluster VPC and Subnet mandatory config
  vpc_id             = var.aws_vpc_id
  private_subnet_ids = var.aws_private_subnets_id

  # EKS CONTROL PLANE VARIABLES
  cluster_version = local.cluster_version


  # EKS MANAGED NODE GROUPS
  managed_node_groups = {
    mg_5 = {
      node_group_name = "managed-ondemand"
      instance_types  = ["m5.xlarge"]
      subnet_ids      = var.aws_private_subnets_id
    }
  }

  # --> Add platform team
  platform_teams = {
    admin = {
      users = [
        data.aws_caller_identity.current.arn,
      ]
    }
  }
  # <-- End platform team

  # --> Add application teams
  application_teams = {
    business = {
      "labels" = {
        "appName"     = "business",
        "projectName" = "business",
        "environment" = "dev",
        "domain"      = "konpyutaika",
        "uuid"        = "konpyutaika",
        "billingCode" = "business",
        "branch"      = "business"
      }
      "quota" = {
        "requests.cpu"    = "10000m",
        "requests.memory" = "20Gi",
        "limits.cpu"      = "20000m",
        "limits.memory"   = "50Gi",
        "pods"            = "30",
        "secrets"         = "30",
        "services"        = "10"
      }
      ## Manifests Example: we can specify a directory with kubernetes manifests that can be automatically applied in the team-riker namespace.
      # manifests_dir = "./manifests-team-red"
      users         = [data.aws_caller_identity.current.arn]
    }
    product = {
      "labels" = {
        "appName"     = "product",
        "projectName" = "product",
        "environment" = "dev",
        "domain"      = "konpyutaika",
        "uuid"        = "konpyutaika",
        "billingCode" = "product",
        "branch"      = "product"
      }
      "quota" = {
        "requests.cpu"    = "10000m",
        "requests.memory" = "20Gi",
        "limits.cpu"      = "20000m",
        "limits.memory"   = "50Gi",
        "pods"            = "30",
        "secrets"         = "30",
        "services"        = "10"
      }
      ## Manifests Example: we can specify a directory with kubernetes manifests that can be automatically applied in the team-riker namespace.
      # manifests_dir = "./manifests-team-red"
      users         = [data.aws_caller_identity.current.arn]
    }
  }
  # <-- End platform team

  tags = local.tags
}

module "aws_controllers" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.3.0/modules/kubernetes-addons"

  eks_cluster_id = module.eks_blueprints.eks_cluster_id

  #---------------------------------------------------------------
  # Use AWS controllers separately
  # So that it can delete ressources it created from other addons or workloads
  #---------------------------------------------------------------

  enable_aws_load_balancer_controller = true
  enable_karpenter                    = false
  enable_aws_for_fluentbit             = false

  depends_on = [module.eks_blueprints.managed_node_groups]
}

module "kubernetes-addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.0.7/modules/kubernetes-addons"

  eks_cluster_id        = module.eks_blueprints.eks_cluster_id
  enable_argocd         = false
  argocd_manage_add_ons = false # Indicates that ArgoCD is responsible for managing/deploying Add-ons.

  # EKS Addons
  enable_amazon_eks_aws_ebs_csi_driver = true
  enable_amazon_eks_coredns            = true
  enable_amazon_eks_kube_proxy         = true
  enable_amazon_eks_vpc_cni            = true

  enable_aws_for_fluentbit              = false
  enable_cert_manager                  = false
  enable_cluster_autoscaler            = false
  enable_ingress_nginx                 = false
  enable_keda                          = false
  enable_metrics_server                = false
  enable_prometheus                    = false
  enable_traefik                        = false
  enable_vpa                           = false
  enable_yunikorn                      = false
  enable_argo_rollouts                 = false

  depends_on = [module.eks_blueprints.managed_node_groups, module.aws_controllers]
}


resource "kubernetes_namespace" "system_dagster" {
  metadata {
    annotations = {
      name = "system-dagster"
    }
    name = "system-dagster"
  }
}