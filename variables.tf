variable "name" {
  description           = "The name of the CloudWatch Log Group. Must be unique within the AWS account and region."
  type                  = string
}

variable "retention" {
  description           = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Defaults to 180 days."
  type                  = number
  default               = 180
}
variable "kms" {
  description           = "The ARN of the KMS Key to use when encrypting log data. This key must be created in the same region as the log group. Defaults to null and encryption is not enabled."
  type                  = string
  default               = null
}
variable "streams" {
  description = "Optional: A set of stream names to create within this group."
  type        = set(string)
  default     = []
}