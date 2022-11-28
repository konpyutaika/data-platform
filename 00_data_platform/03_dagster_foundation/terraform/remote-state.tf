data "terraform_remote_state" "data_core_eks" {
    backend = "s3"
    config  = {
        bucket = "terraform-data-${var.env}"
        key    = "data-core-eks"
        region = var.region
    }
}