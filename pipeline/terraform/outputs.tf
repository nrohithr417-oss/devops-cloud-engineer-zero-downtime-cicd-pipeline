output "vpc_id" {
  description = "ID of the NovaPay VPC"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by the EKS cluster"
  value       = module.vpc.private_subnet_ids
}

output "eks_cluster_name" {
  description = "Name of the NovaPay EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the NovaPay EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "ecr_repository_url" {
  description = "ECR repository URL for the NovaPay Payment API"
  value       = module.ecr.repository_url
}