variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "name" {
  description = "Base name for Lambda resources"
  type        = string
}

variable "memory_size" {
  description = "Lambda memory size in MB"
  type        = number
  default     = 128
}

variable "architectures" {
  description = "Lambda CPU architecture"
  type        = list(string)
  default     = ["arm64"]
}