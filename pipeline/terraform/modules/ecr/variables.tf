variable "repository_name" {
  description = "Name of the ECR repository for the NovaPay application"
  type        = string

  validation {
    condition     = length(var.repository_name) > 2
    error_message = "ECR repository name must contain at least 3 characters."
  }
}