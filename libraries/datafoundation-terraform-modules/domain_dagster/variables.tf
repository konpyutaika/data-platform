# Postgres configurations
variable "postgresql_host" {
  description = "host address of the dagster's postgresql"
  type        = string
}

variable "postgresql_username" {
  description = "Username to connect to the dagster's postgresql"
  type        = string
}

variable "postgresql_password" {
  description = "Password to connect to the dagster's postgresql"
  type        = string
}

variable "postgresql_database" {
  description = "database name of the dagster's postgresql"
  type        = string
}

variable "postgresql_secret_name" {
  description = "Kubernetes secret name, containing postgresql password, to use be pod task instance"
  type        = string
}

# EKS configurations
variable "eks_namespace" {
  description = "Kubernetes namespace where will be deployed resources"
  type        = string
}

variable "eks_oidc_issuer_url" {
  type = string
}

variable "eks_oidc_provider_arn" {
  type = string
}

# AWS configurations
variable "aws_partition" {
  type = string
}

variable "aws_account_id" {
  type = string
}

# Global configurations
variable "domain_name" {
  type = string
  description = "Domain name, will be used to name resources"
}

variable "user_deployment_port" {
  type    = number
  default = 3030
}

variable "user_deployment_resources" {
  type = object({
    limits = object({
      cpu    = number
      memory = string
    }),
    requests = object({
      cpu    = number
      memory = string
    })
  })
  default = {
    limits = {
      cpu    = 1
      memory = "200Mi"
    }
    requests = {
      cpu    = 1
      memory = "200Mi"
    }
  }
}
variable "repositories" {
  type = map(
    list(
      object(
        {
          name = string,
          image = object({
            repository = string,
            tag = string
          }),
          repo_path = string
        }
      )
    )
  )
  default = {}
}