#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${var.env}"
  force_destroy = var.force_destroy
  tags = merge(
    var.tags,
    {
      Bucket = "${var.bucket_name}-${var.env}"
    },
  )

  lifecycle {
    prevent_destroy = false
  }
}

#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket_versioning" "versioning" {
  count = var.versioning=="Disabled" ? 0 : 1
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = var.acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server_side_encryption" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.special_encrypted ? null : var.kms_arn != "" ? var.kms_arn : aws_kms_key.rest_key.arn
      sse_algorithm     = var.special_encrypted ? "AES256" : "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls    = true
  block_public_policy  = true
  ignore_public_acls   = true

  restrict_public_buckets = true
}
