<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_alias.rest_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.rest_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_public_access_block.block_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_replication_configuration.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_replication_configuration.replication_v2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.server_side_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.bucket_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | n/a | `string` | `"private"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_cross_account_access"></a> [cross\_account\_access](#input\_cross\_account\_access) | n/a | <pre>list(object({<br>    sid: string<br>    account_id: string<br>    action: list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_expiration_life_cycle_rules"></a> [expiration\_life\_cycle\_rules](#input\_expiration\_life\_cycle\_rules) | n/a | <pre>list(object({<br>    id: string<br>    prefix: string<br>    enabled: bool<br>    expiration_days: number<br>  }))</pre> | `[]` | no |
| <a name="input_expiration_non_current_bersion_life_cycle_rules"></a> [expiration\_non\_current\_bersion\_life\_cycle\_rules](#input\_expiration\_non\_current\_bersion\_life\_cycle\_rules) | n/a | <pre>list(object({<br>    id: string<br>    prefix: string<br>    enabled: bool<br>    expiration_days: number<br>  }))</pre> | `[]` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | n/a | `string` | `""` | no |
| <a name="input_kms_key_policy"></a> [kms\_key\_policy](#input\_kms\_key\_policy) | n/a | `string` | `""` | no |
| <a name="input_replication_configuration"></a> [replication\_configuration](#input\_replication\_configuration) | n/a | <pre>list(object({<br>    destination_bucket_arn: string<br>    destination_key_arn: string<br>    destination_account_id: string<br>    replication_role: string<br>    prefix: string<br>  }))</pre> | `[]` | no |
| <a name="input_replication_configuration_v2"></a> [replication\_configuration\_v2](#input\_replication\_configuration\_v2) | Configuration with the recommended schema version V2 | <pre>list(object({<br>    destination_bucket_arn: string<br>    destination_key_arn: string<br>    destination_account_id: string<br>    prefix: string<br>  }))</pre> | `[]` | no |
| <a name="input_replication_role"></a> [replication\_role](#input\_replication\_role) | Should be filled if we use the new variable `replication_configuration_v2` | `string` | `null` | no |
| <a name="input_replication_schema_version"></a> [replication\_schema\_version](#input\_replication\_schema\_version) | V2 is recommended, it supports multi-rules replications. V1 is deprecated | `string` | `"V1"` | no |
| <a name="input_special_encrypted"></a> [special\_encrypted](#input\_special\_encrypted) | n/a | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_target_log_bucket"></a> [target\_log\_bucket](#input\_target\_log\_bucket) | n/a | <pre>list(object({<br>    bucket_id: string<br>    prefix: string<br>  }))</pre> | `[]` | no |
| <a name="input_transition_life_cycle_rules"></a> [transition\_life\_cycle\_rules](#input\_transition\_life\_cycle\_rules) | n/a | <pre>list(object({<br>    id: string<br>    prefix: string<br>    enabled: bool<br>    transition_days: number<br>    transition_class: string<br>  }))</pre> | `[]` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | n/a | `string` | `"Disabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | n/a |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | n/a |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_bucket_name_w_env"></a> [bucket\_name\_w\_env](#output\_bucket\_name\_w\_env) | n/a |
| <a name="output_read_policy_arn"></a> [read\_policy\_arn](#output\_read\_policy\_arn) | n/a |
| <a name="output_read_policy_json"></a> [read\_policy\_json](#output\_read\_policy\_json) | n/a |
| <a name="output_read_write_policy_arn"></a> [read\_write\_policy\_arn](#output\_read\_write\_policy\_arn) | n/a |
| <a name="output_read_write_policy_json"></a> [read\_write\_policy\_json](#output\_read\_write\_policy\_json) | n/a |
| <a name="output_rest_kms_key"></a> [rest\_kms\_key](#output\_rest\_kms\_key) | n/a |
| <a name="output_rest_kms_key_arn"></a> [rest\_kms\_key\_arn](#output\_rest\_kms\_key\_arn) | n/a |
<!-- END_TF_DOCS -->