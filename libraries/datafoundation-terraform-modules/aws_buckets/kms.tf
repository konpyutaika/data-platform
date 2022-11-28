data "aws_caller_identity" "account" {}

data "aws_iam_policy_document" "key_policy" {
  version = "2012-10-17"
  policy_id="key-default-1" # necessary for backward compatibility
  statement {
    sid="Enable IAM User Permissions"
    effect="Allow"
    actions = ["kms:*"]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.account.account_id}:root"]
      type = "AWS"
    }
    resources = ["*"]
  }

  dynamic "statement" {
    for_each =var.cross_account_access
    content {
      sid = statement.value["sid"]
      effect = "Allow"
      actions = statement.value["action"]
      principals {
        identifiers = ["arn:aws:iam::${statement.value["account_id"]}:root"]
        type = "AWS"
      }
      resources = ["*"]
    }
  }
}

#tfsec:ignore:aws-kms-auto-rotate-keys
resource "aws_kms_key" "rest_key" {
  is_enabled = var.special_encrypted ? false: true
  description = "Used to encrypt ${var.bucket_name} at rest."
  policy = data.aws_iam_policy_document.key_policy.json
}

resource "aws_kms_alias" "rest_key" {
  name          = "alias/${var.bucket_name}-rest-${var.env}"
  target_key_id = aws_kms_key.rest_key.key_id
}