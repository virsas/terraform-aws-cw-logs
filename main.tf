resource "aws_cloudwatch_log_group" "vss" {
  name              = var.name
  retention_in_days = var.retention
  kms_key_id        = var.kms
}

resource "aws_cloudwatch_log_stream" "vss" {
  for_each = var.streams

  name           = each.value
  log_group_name = aws_cloudwatch_log_group.vss.name
}