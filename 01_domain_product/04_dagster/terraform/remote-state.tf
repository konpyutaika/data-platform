data "terraform_remote_state" "data_core_eks" {
    backend = "s3"
    config  = {
        bucket = "terraform-data-${var.env}"
        key    = "data-core-eks"
        region = var.region
    }
}

data "terraform_remote_state" "data_foundation_dagster_foundation" {
    backend = "s3"
    config  = {
        bucket = "terraform-data-${var.env}"
        key    = "data-foundation-dagster-foundation"
        region = var.region
    }
}