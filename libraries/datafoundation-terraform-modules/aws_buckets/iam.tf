data "aws_iam_policy_document" "bucket_read_policy" {
  statement {
    sid     = "AllowBucketRead${replace(var.bucket_name, "-", "")}${replace(var.env, "-", "")}"
    effect  = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketPolicy"
    ]
    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.id}"]
  }

  dynamic "statement" {
    for_each = var.special_encrypted ? []: ["allow_to_use_kms_key"]
    content {
      sid       = "AllowKmsDecrypt${replace(var.bucket_name, "-", "")}${replace(var.env, "-", "")}"
      effect    = "Allow"
      actions   = ["kms:Decrypt"]
      resources = [aws_kms_key.rest_key.arn]
    }
  }

  statement {
    sid       = "AllowObjectRead${replace(var.bucket_name, "-", "")}${replace(var.env, "-", "")}"
    effect    = "Allow"
    actions   = ["s3:GetObject*"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]
  }
}

data "aws_iam_policy_document" "bucket_write_policy" {
  source_json = data.aws_iam_policy_document.bucket_read_policy.json
  statement {
    sid     = "AllowObjectAdmin${replace(var.bucket_name, "-", "")}${replace(var.env, "-", "")}"
    effect  = "Allow"
    actions = [
      "s3:PutObject*",
      "s3:DeleteObject*",
      "s3:RestoreObject"
    ]
    resources = ["arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]
  }

  dynamic "statement" {
    for_each = var.special_encrypted ? []: ["allow_to_use_kms_key"]
    content {
      sid       = "AllowKmsAccess${replace(var.bucket_name, "-", "")}${replace(var.env, "-", "")}"
      effect    = "Allow"
      actions   = [
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey"
      ]
      resources = [aws_kms_key.rest_key.arn]
    }
  }
}

resource "aws_iam_policy" "read" {
  name   = "${aws_s3_bucket.bucket.id}-read"
  policy = data.aws_iam_policy_document.bucket_read_policy.json
}

resource "aws_iam_policy" "write" {
  name   = "${aws_s3_bucket.bucket.id}-read-write"
  policy = data.aws_iam_policy_document.bucket_write_policy.json
}
