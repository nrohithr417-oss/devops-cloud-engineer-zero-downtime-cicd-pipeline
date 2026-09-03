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
Production-Ready Application---

## Related Deliverables

- [Deliverable 2 – Deployment Strategies](../02-deployment-strategies/deployment-strategy.md)
- [Deliverable 3 – Compliance Gates](../03-compliance-gates/compliance-gates.md)
- [Deliverable 4 – Database Migration](../04-database-migration/database-migration-strategy.md)
- [Deliverable 5 – Environment Promotion](../05-environment-promotion/environment-promotion.md)
- [Deliverable 6 – Rollback Specification](../06-rollback-specification/rollback-specification.md)
- [Deliverable 7 – Deployment Runbook](../07-runbook-playbook/deployment-runbook.md)
- [Deliverable 8 – Observability](../08-observability/observability-strategy.md)
- [Incident Simulation](../09-incident-simulation/friday-5pm-incident.md)