# NovaPay Digital Bank — Zero-Downtime DevSecOps CI/CD Pipeline

## DevOps & Cloud Engineer Assessment

This repository contains the complete design and implementation for a secure,
compliant and zero-downtime CI/CD platform for **NovaPay Digital Bank**.

The solution combines modern DevSecOps practices with:

- GitHub Actions CI/CD
- Docker
- Kubernetes
- ArgoCD
- Argo Rollouts
- Helm
- Terraform
- Open Policy Agent (OPA)
- Prometheus
- Grafana
- SAST
- DAST
- Dependency scanning
- Container vulnerability scanning
- PCI-DSS v4.0 controls
- RBI-aligned IT governance controls
- Segregation of Duties (SoD)
- Automated rollback
- Zero-downtime database migration

The target architecture supports rapid software delivery while maintaining
security, regulatory traceability, production reliability and zero-downtime
deployment practices.

---

## Project Objectives

The primary objectives of this project are to:

1. Design an eight-stage DevSecOps CI/CD pipeline.
2. Introduce automated security and compliance gates.
3. Implement blue-green and canary deployment strategies.
4. Provide automated rollback based on production telemetry.
5. Design zero-downtime database migration using expand-migrate-contract.
6. Enforce controlled environment promotion and Segregation of Duties.
7. Create production deployment and incident response runbooks.
8. Implement DORA, operational and regulatory observability.
9. Provide Infrastructure as Code using Terraform and Helm.
10. Demonstrate incident handling through a simulated production failure.

---

# Architecture Overview

The deployment flow is:

```text
Developer Commit
       |
       v
Stage 1 - Source & Build
       |
       v
Stage 2 - Unit & Integration Testing
       |
       v
Stage 3 - Static Security & Dependency Analysis
       |
       v
Stage 4 - Compliance / OPA Policy Gates
       |
       v
Stage 5 - DAST & Contract Testing
       |
       v
Stage 6 - Artifact / Container Security
       |
       v
Stage 7 - Environment Promotion
       |
       v
Stage 8 - Production Verification
       |
       v
Dev -> Staging -> Pre-Prod -> Production
                           |
                 Blue-Green / Canary
                           |
                    Prometheus Metrics
                           |
                       Grafana
                           |
                 Automated Rollback