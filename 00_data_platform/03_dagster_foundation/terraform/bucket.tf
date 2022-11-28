module "dagster_bucket" {
  source      = "../../../libraries/datafoundation-terraform-modules/aws_buckets"
  bucket_name = "konpyutaika-dagster"
  env         = var.env
}