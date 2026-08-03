variable "aws_region" {
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair (created earlier via console)"
  default     = "dream-key-tf"
}
