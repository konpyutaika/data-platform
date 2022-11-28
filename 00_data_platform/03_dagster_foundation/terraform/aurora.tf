locals {
  postgres_db_master_username = "dagster"
}

resource "random_password" "password" {
  length = 16
  min_numeric = 1
  min_upper = 1
  min_lower = 1
  special = false
}


#tfsec:ignore:aws-kms-auto-rotate-keys
resource "aws_kms_key" "aurora_kms_key" {
  description = "Used to encrypt dagster db."
}

module "cluster" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name           = "dagster"
  engine         = "aurora-postgresql"
  engine_version = "13.4"
  instance_class = "db.t3.medium"
  instances      = {
    primary = {}
  }

  # Network configurations
  vpc_id              = var.aws_vpc_id
  subnets             = var.aws_private_subnets_id
  publicly_accessible = false

  # Security configurations
  allowed_security_groups = [data.terraform_remote_state.data_core_eks.outputs.cluster_primary_security_group_id]
  allowed_cidr_blocks     = []

  # Encryption configurations
  storage_encrypted = true
  kms_key_id        = aws_kms_key.aurora_kms_key.arn

  #
  apply_immediately   = true
  monitoring_interval = 10

  # DB configurations
  db_parameter_group_name         = "default.aurora-postgresql13"
  db_cluster_parameter_group_name = "default.aurora-postgresql13"
  database_name                   = "dagster"

  # Master configuration
  master_username = local.postgres_db_master_username
  master_password = random_password.password.result

  enabled_cloudwatch_logs_exports     = ["postgresql"]
  iam_database_authentication_enabled = true
  tags                                = {
    Environment = "dev"
    Terraform   = "true"
  }
}

resource "kubernetes_secret" "dagster_postgresql" {
  count = length(local.namespaces)
  metadata {
    name      = "dagster-postgresql"
    namespace = local.namespaces[count.index]
  }
  data = {
    postgresql-password = module.cluster.cluster_master_password
  }
}