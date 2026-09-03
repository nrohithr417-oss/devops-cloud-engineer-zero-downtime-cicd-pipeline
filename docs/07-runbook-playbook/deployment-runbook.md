# NovaPay Production Deployment Runbook

## 1. Purpose

This runbook provides the operational procedure for safely deploying NovaPay application releases to production.

It is designed for use by SRE, DevOps, Release Management, and on-call engineers during both planned and emergency production deployments.

The deployment process follows NovaPay's zero-downtime CI/CD architecture using automated quality gates, compliance validation, immutable artifacts, progressive deployment strategies, and automated rollback.

---

## 2. Scope

This runbook covers:

- Production deployment readiness
- Pre-deployment validation
- Change approval
- Blue-green or canary deployment
- Database migration validation
- Health verification
- Monitoring
- Rollback decisions
- Post-deployment evidence collection

---

## 3. Roles and Responsibilities

### Release Manager

Responsible for:

- Confirming release readiness
- Checking required approvals
- Authorising production promotion
- Coordinating release communications

### SRE Lead

Responsible for:

- Validating operational readiness
- Confirming monitoring and rollback readiness
- Providing production approval
- Supporting deployment execution

### On-Call SRE

Responsible for:

- Monitoring deployment health
- Responding to alerts
- Executing rollback when required
- Escalating incidents

### DBA

Responsible for:

- Reviewing database changes
- Approving migration procedures
- Monitoring migration health

### Compliance Team

Responsible for:

- Confirming RBI control checks
- Confirming PCI-DSS controls
- Reviewing compliance evidence

---

# 4. Pre-Deployment Checklist

All eight items must be completed before production deployment begins.

| No. | Check | Required Evidence | Status |
|---|---|---|---|
| 1 | CI pipeline completed successfully | GitHub Actions pipeline run URL / ID | Pending |
| 2 | Unit, integration and contract tests passed | Test reports | Pending |
| 3 | SAST, DAST, dependency and container scans passed | Security scan reports | Pending |
| 4 | RBI and PCI-DSS compliance gates passed | Compliance evidence | Pending |
| 5 | Production artifact verified and signed | Image tag + digest + signature | Pending |
| 6 | Database migration reviewed and validated | Migration test evidence + DBA approval | Pending |
| 7 | Production approvals completed | Release Manager + SRE Lead approval | Pending |
| 8 | Monitoring, rollback and on-call readiness confirmed | Dashboard links + alert status + on-call confirmation | Pending |

If any checklist item is incomplete:

**STOP THE DEPLOYMENT.**

Do not bypass the failed requirement without an authorised exception.

---

# 5. Deployment Preconditions

Before starting deployment, verify:

- Production cluster is healthy
- Kubernetes nodes have sufficient capacity
- ArgoCD is available
- Prometheus is collecting metrics
- Grafana dashboards are operational
- Alertmanager is operational
- No active SEV-1 or SEV-2 incident exists
- No restricted deployment blackout is active
- Required engineering staff are available

---

# 6. Deployment Procedure

## Step 1 – Confirm Release Version

Record:

- Git commit SHA
- Application version
- Container image tag
- Container image digest
- Pipeline run ID

Example:

```text
Application: NovaPay Payment API
Version: 1.4.0
Commit SHA: abc123def456
Image: novapay/payment-api:1.4.0
Digest: sha256:<digest>