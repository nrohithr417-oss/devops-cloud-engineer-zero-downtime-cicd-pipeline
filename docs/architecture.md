# NovaPay Zero-Downtime CI/CD Architecture

## 1. Overview

NovaPay Digital Bank uses a production-oriented CI/CD architecture designed to support secure, automated and zero-downtime application delivery.

The solution integrates:

- GitHub
- GitHub Actions
- Docker
- Kubernetes
- Argo CD
- Argo Rollouts
- Semgrep
- Trivy
- OWASP ZAP
- OPA / Conftest
- Prometheus
- Grafana
- PostgreSQL

The local implementation uses Docker Desktop and Kind Kubernetes to keep the assessment environment free while preserving an architecture that can be adapted to managed Kubernetes platforms such as Amazon EKS.

---

## 2. CI/CD Pipeline Stages

The pipeline follows eight canonical stages:

1. Source Control
2. Build
3. SAST
4. Dependency and Container Security Scanning
5. Integration and Contract Testing
6. DAST
7. Policy and Compliance Gates
8. Deployment and Verification

### Pipeline Flow

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Actions
    |
    +--> Build Application
    |
    +--> Unit Tests
    |
    +--> SAST - Semgrep
    |
    +--> Container Scan - Trivy
    |
    +--> Integration Tests
    |
    +--> Contract Tests
    |
    +--> DAST - OWASP ZAP
    |
    +--> Compliance Gate - OPA / Conftest
    |
    v
Docker Image
    |
    v
Kubernetes
    |
    v
Argo CD
    |
    v
Argo Rollouts
    |
    +--> Blue-Green Deployment
    |
    +--> Canary Deployment
    |
    +--> Prometheus Analysis
    |
    +--> Automated Rollback
    |
    v
Production-Ready Application