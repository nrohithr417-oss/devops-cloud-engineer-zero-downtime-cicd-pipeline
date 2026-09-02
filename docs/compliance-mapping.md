# NovaPay CI/CD Compliance Mapping

## 1. Purpose

This document maps NovaPay's CI/CD security and deployment controls to relevant regulatory and governance expectations.

The implementation focuses on:

- RBI security expectations
- PCI-DSS v4.x controls
- Segregation of Duties
- Auditability
- Secure software delivery
- Controlled production deployment

This mapping is for the assessment architecture and should be validated against the organization's official compliance interpretation before production use.

---

## 2. Compliance Control Summary

| Control Area | Implementation |
|---|---|
| Source control | GitHub repository with version history |
| CI/CD automation | GitHub Actions |
| SAST | Semgrep |
| Dependency / image security | Trivy |
| DAST | OWASP ZAP |
| Policy enforcement | OPA / Conftest |
| Deployment control | Argo CD |
| Progressive delivery | Argo Rollouts |
| Runtime monitoring | Prometheus |
| Visualization | Grafana |
| Rollback protection | Prometheus AnalysisRun + Argo Rollouts |
| Database change control | Expand-contract migration |
| Auditability | Git commits and pipeline execution history |

---

## 3. RBI-Oriented Security Controls

### Secure Change Management

Application and infrastructure changes are stored in Git.

Benefits include:

- Traceable change history
- Reviewable configuration
- Repeatable deployment
- Reduced manual modification
- Rollback capability

### Security Testing

The pipeline integrates multiple security layers:

- Semgrep for static analysis
- Trivy for image vulnerability scanning
- OWASP ZAP for dynamic application testing
- OPA / Conftest for policy validation

Security checks occur before production-style deployment.

### Monitoring and Incident Detection

Prometheus and Grafana provide runtime visibility.

Argo Rollouts can consume Prometheus metrics to stop or abort an unhealthy deployment.

This supports early detection and controlled recovery from deployment-related failures.

### Resilience

The design includes:

- Kubernetes replicas
- Health probes
- Blue-green deployment
- Canary deployment
- Automated rollback
- Zero-downtime schema migration

These controls support service continuity during application releases.

---

## 4. PCI-DSS v4.x Mapping

### Requirement 2 - Secure Configurations

Controls:

- Kubernetes manifests stored as code
- Restricted privilege escalation
- Dropped Linux capabilities
- Repeatable deployment configuration
- Policy-as-code validation

Evidence:

```text
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL