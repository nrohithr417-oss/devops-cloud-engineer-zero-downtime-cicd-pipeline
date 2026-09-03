variable "name" {
  description = "Name prefix for VPC resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnets) == length(var.availability_zones)
    error_message = "The number of public subnets must match the number of availability zones."
  }
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)

  validation {
    condition     = length(var.private_subnets) == length(var.availability_zones)
    error_message = "The number of private subnets must match the number of availability zones."
  }
}