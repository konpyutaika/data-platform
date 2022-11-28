output "rest_kms_key" {
  value = join("", aws_kms_key.rest_key.*.key_id)
}

output "rest_kms_key_arn" {
  value = aws_kms_key.rest_key.arn
}

output "bucket" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "bucket_name" {
  value = var.bucket_name
}

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_name_w_env" {
  value = aws_s3_bucket.bucket.bucket
}

output "read_policy_arn" {
  value = aws_iam_policy.read.arn
}

output "read_write_policy_arn" {
  value = aws_iam_policy.write.arn
}

output "read_policy_json" {
  value = data.aws_iam_policy_document.bucket_read_policy.json
}

output "read_write_policy_json" {
  value = data.aws_iam_policy_document.bucket_write_policy.json
}
