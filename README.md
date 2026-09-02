# DevOps & Cloud Engineer Zero Downtime CI/CD Pipeline Assessment

## NovaPay Digital Bank

A production-oriented DevSecOps CI/CD implementation demonstrating secure automated delivery, Kubernetes GitOps, progressive deployments, automated rollback, observability, compliance gates, and zero-downtime database migration.

---

## Project Objectives

This project demonstrates:

- End-to-end CI/CD automation
- Eight-stage secure delivery pipeline
- SAST and vulnerability scanning
- Integration and contract testing
- DAST
- Policy-as-code compliance gates
- Kubernetes deployment
- GitOps using Argo CD
- Blue-green deployment
- Canary deployment
- Prometheus-based rollout analysis
- Automated rollback
- Grafana monitoring
- PostgreSQL expand-contract migration
- Architecture designed toward 99.999% availability
- Commit-to-production target below two hours

---

## CI/CD Pipeline

```text
Source Control
      |
      v
Build
      |
      v
SAST
      |
      v
Dependency / Container Scan
      |
      v
Integration + Contract Tests
      |
      v
DAST
      |
      v
Policy / Compliance Gate
      |
      v
Deployment + Verification
```

### Eight Canonical Stages

| Stage | Implementation |
|---|---|
| 1. Source Control | GitHub |
| 2. Build | GitHub Actions + Docker |
| 3. SAST | Semgrep |
| 4. Dependency / Container Scan | Trivy |
| 5. Integration / Contract Testing | pytest |
| 6. DAST | OWASP ZAP |
| 7. Compliance Gates | OPA + Conftest |
| 8. Deployment / Verification | Kubernetes + Argo CD + Argo Rollouts |

---

## Technology Stack

### Application

- Python
- FastAPI
- pytest
- Prometheus client

### CI/CD

- GitHub
- GitHub Actions
- Docker

### Security

- Semgrep
- Trivy
- OWASP ZAP

### Compliance

- OPA
- Conftest

### Kubernetes / GitOps

- Kubernetes
- Kind
- Argo CD
- Argo Rollouts

### Monitoring

- Prometheus
- Grafana

### Database

- PostgreSQL 16

### Infrastructure as Code

- Terraform

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── ci.yml
│       ├── security.yml
│       ├── dast.yml
│       └── compliance.yml
│
├── application/
├── argocd/
├── database/
│   ├── expand/
│   ├── migrate/
│   └── contract/
│
├── docker/
├── docs/
├── kubernetes/
│   ├── analysis/
│   ├── base/
│   ├── blue-green/
│   └── canary/
│
├── monitoring/
│   ├── alerts/
│   ├── grafana/
│   └── prometheus/
│
├── policies/
│   ├── kubernetes/
│   ├── pci-dss/
│   ├── rbi/
│   ├── segregation-of-duties/
│   └── terraform/
│
├── security/
├── terraform/
└── tests/
```

---

## Application Health

The NovaPay API exposes:

```text
/health
/ready
/metrics
```

These endpoints support Kubernetes health checking and Prometheus monitoring.

---

## Automated Testing

The project contains:

- Unit tests
- Integration tests
- Contract tests

Validated result:

```text
9 tests passed
```

---

## Security Pipeline

### Semgrep

Provides static application security testing.

### Trivy

Scans the final container image for HIGH and CRITICAL vulnerabilities.

During implementation, HIGH-severity dependency vulnerabilities were detected and remediated before successful validation.

### OWASP ZAP

Provides dynamic application security testing against the running API.

---

## Compliance Gates

OPA and Conftest implement policy-as-code validation.

Assessment controls are mapped to:

- RBI-oriented security expectations
- PCI-DSS v4.x
- Segregation of Duties

A controlled policy violation was introduced during testing and correctly caused the compliance validation to fail.

---

## Kubernetes

The application runs with multiple replicas and includes:

- Readiness probes
- Liveness probes
- Resource requests
- Resource limits
- Restricted privilege escalation
- Dropped Linux capabilities
- Rolling update configuration

The base deployment uses:

```yaml
maxUnavailable: 0
maxSurge: 1
```

---

## GitOps with Argo CD

Argo CD manages Kubernetes deployment using Git as the desired-state source.

Configured capabilities include:

- Automated synchronization
- Self-healing
- Resource pruning

The application was validated in:

```text
Synced
Healthy
```

state.

---

## Blue-Green Deployment

Argo Rollouts implements blue-green deployment using:

```text
Active Service
+
Preview Service
```

A new release can be validated through the preview service before promotion to active traffic.

---

## Canary Deployment

The canary strategy progressively advances through:

```text
5%
 ↓
10%
 ↓
25%
 ↓
Prometheus Analysis
 ↓
50%
 ↓
100%
```

A successful rollout completed all stages and reached 100%.

The local Kind implementation approximates low traffic percentages using replica counts. Exact production traffic weighting requires an ingress controller or service mesh.

---

## Monitoring

Prometheus collects application metrics.

Grafana is configured with Prometheus as its data source.

The application exposes:

```text
novapay_payments_total
```

for assessment monitoring and rollout-analysis validation.

Production monitoring should additionally include:

- HTTP request rate
- HTTP 5xx rate
- Success rate
- p95 latency
- Pod restarts
- Resource utilization
- Business transaction failures

---

## Automated Rollback

Argo Rollouts integrates with Prometheus AnalysisRuns.

A controlled failure test was performed using application version:

```text
novapay-payment-api:1.0.4
```

The analysis failed its deliberately configured threshold.

Argo Rollouts:

1. Detected the failed analysis.
2. Aborted revision 4.
3. Scaled down the new canary ReplicaSet.
4. Preserved version `1.0.3` as the stable release.
5. Maintained four ready application replicas.

This demonstrates automated metric-driven release protection.

---

## Zero-Downtime Database Migration

PostgreSQL schema changes use the expand-contract pattern.

```text
EXPAND
   |
   v
MIGRATE / BACKFILL
   |
   v
VALIDATE
   |
   v
CONTRACT
```

The assessment demonstrated:

1. Creation of the original payments schema.
2. Addition of nullable `payment_reference`.
3. Continued compatibility with legacy records.
4. Backfill of existing records.
5. Validation of migrated data.
6. Enforcement of `NOT NULL` after migration.

Example:

```text
TXN-1001 → PAY-TXN-1001
TXN-1002 → PAY-TXN-1002
TXN-1003 → PAY-TXN-1003
```

---

## Availability Design

The architecture is designed toward a:

```text
99.999% availability objective
```

Supporting mechanisms include:

- Multiple replicas
- Health probes
- Rolling updates
- Blue-green deployment
- Canary deployment
- Runtime analysis
- Automated rollback
- GitOps reconciliation
- Expand-contract database migrations

The CI/CD implementation supports this objective but does not independently guarantee five-nines availability.

Production infrastructure would additionally require multi-AZ compute, highly available databases, resilient networking, backups, disaster recovery, and capacity planning.

---

## Commit-to-Production Target

Target:

```text
< 2 hours
```

Automation reduces manual delivery time through integrated:

```text
Build
→ Test
→ Security
→ Compliance
→ Deploy
→ Verify
```

Actual production performance should be measured from pipeline timestamps.

---

## Production Architecture

```text
Developer
    |
    v
GitHub
    |
    v
GitHub Actions
    |
    v
Security + Compliance Gates
    |
    v
Container Registry
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
    +----------------+
    |                |
Blue-Green        Canary
    |                |
    +-------+--------+
            |
            v
       Application
            |
            v
       PostgreSQL
            |
            v
Prometheus + Grafana
```

---

## Production Improvements

Before real production adoption, the assessment implementation should be extended with:

- Production container registry
- Immutable image digests
- Image signing
- SBOM generation
- Exact canary traffic routing
- HTTP success/error/latency metrics
- Alertmanager
- Persistent Prometheus storage
- Persistent Grafana storage
- TLS
- Secrets management
- Kubernetes RBAC
- Protected Git branches
- Production approval workflows
- Multi-AZ Kubernetes
- Highly available PostgreSQL
- Backup and disaster recovery
- Centralized logging / SIEM

---

## Documentation

Detailed documentation is available under `docs/`:

- `architecture.md`
- `compliance-mapping.md`
- `zero-downtime-strategy.md`
- `demo-evidence.md`

---

## Assessment Coverage

| Capability | Status |
|---|---|
| CI/CD | ✅ |
| SAST | ✅ |
| Container scanning | ✅ |
| Integration testing | ✅ |
| Contract testing | ✅ |
| DAST | ✅ |
| Compliance gates | ✅ |
| Kubernetes | ✅ |
| GitOps | ✅ |
| Blue-green | ✅ |
| Canary | ✅ |
| Prometheus | ✅ |
| Grafana | ✅ |
| Automated rollback | ✅ |
| Expand-contract DB migration | ✅ |

---

## Final Result

This project demonstrates an end-to-end DevSecOps delivery architecture for NovaPay Digital Bank with security, compliance, GitOps, progressive delivery, observability, automated rollback and zero-downtime database migration.