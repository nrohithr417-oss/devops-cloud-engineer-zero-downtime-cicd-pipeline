variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS control plane"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS is deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by EKS"
  type        = list(string)
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS worker nodes"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired worker node count"
  type        = number
}

variable "min_capacity" {
  description = "Minimum worker node count"
  type        = number
}

variable "max_capacity" {
  description = "Maximum worker node count"
  type        = number
}