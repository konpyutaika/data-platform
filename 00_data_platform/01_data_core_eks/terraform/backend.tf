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
    
    required_version = "= 1.1.0"

    backend "s3" {
        key = "data-core-eks"
        region = var.region
    }
}
