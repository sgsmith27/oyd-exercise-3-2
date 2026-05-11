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

  validation {
    condition = (
      length(var.architectures) == 1 &&
      contains(["arm64", "x86_64"], var.architectures[0])
    )
    error_message = "architectures debe ser [\"arm64\"] o [\"x86_64\"]."
  }
}