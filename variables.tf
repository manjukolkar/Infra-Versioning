variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "infra-demo-app-bucket-manjunath"
}
