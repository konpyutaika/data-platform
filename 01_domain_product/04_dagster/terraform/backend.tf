terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 3.72"
        }
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = ">= 2.12.1"
        }
        helm = {
            source  = "hashicorp/helm"
            version = ">= 2.4.1"
        }
        kubectl = {
            source  = "gavinbunney/kubectl"
            version = ">= 1.14"
        }
    }

    required_version = "= 1.3.1"

    backend "s3" {
        key    = "domain-product-dagster"
        region = var.region
    }
}
