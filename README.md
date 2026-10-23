# Terraform AWS CloudWatch Logs Module

A Terraform module for managing [Amazon CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html) log groups and their log streams, with configurable retention and optional KMS encryption at rest.

## Features

- **Log Group Management**: Creates a CloudWatch Log Group with a configurable name.
- **Retention Control**: Sets log event retention in days, defaulting to 180 days.
- **KMS Encryption**: Optionally encrypts log data with a customer managed KMS key in the same region as the log group.
- **Log Streams**: Creates an arbitrary set of log streams inside the group from a single variable.

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

---

## Usage Examples

### Basic Example

Create a log group with the default 180 day retention:

```hcl
module "cw_logs" {
  source = "git::https://github.com/virsas/terraform-aws-cw-logs.git?ref=v1.1"

  name = "/vss/application/api"
}
```

### Advanced Example (KMS Encryption & Log Streams)

Create an encrypted log group with a shorter retention and pre-created log streams:

```hcl
module "cw_logs_encrypted" {
  source = "git::https://github.com/virsas/terraform-aws-cw-logs.git?ref=v1.1"

  name      = "/vss/application/worker"
  retention = 30
  kms       = "arn:aws:kms:eu-west-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  streams = [
    "worker-stdout",
    "worker-stderr"
  ]
}
```

---

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.vss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.vss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the CloudWatch Log Group. Must be unique within the AWS account and region. | `string` | n/a | yes |
| <a name="input_retention"></a> [retention](#input\_retention) | Number of days to retain log events. Possible values are `1`, `3`, `5`, `7`, `14`, `30`, `60`, `90`, `120`, `150`, `180`, `365`, `400`, `545`, `731`, `1827` and `3653`. | `number` | `180` | no |
| <a name="input_kms"></a> [kms](#input\_kms) | ARN of the KMS key used to encrypt log data. The key must exist in the same region as the log group. Defaults to `null`, which leaves encryption disabled. | `string` | `null` | no |
| <a name="input_streams"></a> [streams](#input\_streams) | Set of log stream names to create within the log group. | `set(string)` | `[]` | no |

---

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the CloudWatch Log Group. |
| <a name="output_name"></a> [name](#output\_name) | The name of the CloudWatch Log Group. |

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
