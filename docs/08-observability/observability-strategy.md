# NovaPay Observability Strategy

## 1. Purpose

This document defines the observability strategy for the NovaPay zero-downtime CI/CD platform.

The objective is to provide measurable visibility into software delivery performance, pipeline health, deployment safety, compliance status, production reliability, and incident response.

The strategy covers:

- DORA metrics
- CI/CD pipeline metrics
- Deployment metrics
- Compliance metrics
- Application reliability metrics
- Dashboard requirements
- Alerting requirements
- Audit evidence

---

## 2. Observability Objectives

NovaPay observability must support four primary goals:

1. Detect failures quickly.
2. Measure CI/CD delivery performance.
3. Verify production reliability and deployment safety.
4. Provide audit-ready compliance evidence.

Observability data must be useful to:

- Developers
- DevOps engineers
- SRE teams
- Engineering management
- Security teams
- Compliance teams
- Auditors

---

## 3. Observability Architecture

The recommended observability flow is:

```text
GitHub Actions
      |
      v
Pipeline Metrics
      |
      +--------------------+
      |                    |
      v                    v
Prometheus           Application Metrics
      |                    |
      +---------+----------+
                |
                v
             Grafana
                |
        +-------+-------+
        |       |       |
        v       v       v
 Engineering Management Regulatory
 Dashboard   Dashboard   Dashboard
        |
        v
Alertmanager
        |
        v
Slack / Pager / Email / Incident Response
```

---

## 4. DORA Metrics

NovaPay will track the four standard DORA software-delivery metrics.

### 4.1 Deployment Frequency

Deployment Frequency measures how often production deployments are completed successfully.

Formula:

```text
Deployment Frequency =
Number of successful production deployments
-------------------------------------------
Measurement period
```

Examples:

- Deployments per day
- Deployments per week
- Deployments per month

Data source:

- GitHub Actions production deployment jobs
- ArgoCD deployment history

Purpose:

This metric shows how frequently NovaPay safely delivers production changes.

---

## 5. Lead Time for Changes

Lead Time for Changes measures the time between a code commit and successful production deployment.

Formula:

```text
Lead Time =
Production deployment timestamp
-
Commit timestamp
```

NovaPay target:

```text
Commit-to-production time < 2 hours
```

Measurement should include:

- Commit time
- Build time
- Testing time
- Security scanning time
- Compliance gate time
- Approval waiting time
- Deployment time

---

## 6. Change Failure Rate

Change Failure Rate measures the percentage of production deployments that cause incidents, rollback, hotfixes, or degraded service.

Formula:

```text
Change Failure Rate =
Failed production changes
-------------------------
Total production changes
x 100
```

A failed change includes:

- Automated rollback
- Manual rollback
- Production incident
- Emergency hotfix
- SLO-impacting regression

---

## 7. Mean Time to Restore

Mean Time to Restore measures how quickly NovaPay restores normal production service after a failure.

Formula:

```text
MTTR =
Sum of incident recovery durations
----------------------------------
Number of incidents
```

Measurement starts when the incident is detected and ends when service health returns to normal.

Data sources:

- Incident records
- Prometheus alerts
- Deployment rollback logs
- Postmortem records

---

## 8. Pipeline-Specific Metrics

NovaPay will monitor more than 15 pipeline-specific metrics across build, security, compliance, deployment, and reliability categories.

### Build Metrics

#### 8.1 Pipeline Success Rate

```text
Successful pipeline runs / Total pipeline runs * 100
```

Purpose:

Measures overall CI/CD reliability.

---

#### 8.2 Pipeline Failure Rate

```text
Failed pipeline runs / Total pipeline runs * 100
```

Purpose:

Identifies CI/CD instability.

---

#### 8.3 Pipeline Duration

Measures total time from pipeline start to completion.

Target:

```text
< 2 hours from commit to production
```

---

#### 8.4 Build Duration

Measures time spent compiling, packaging, and creating artifacts.

---

#### 8.5 Unit Test Success Rate

```text
Passed unit tests / Total unit tests * 100
```

---

#### 8.6 Test Coverage

Measures percentage of application code covered by automated tests.

---

## 9. Security Metrics

### 9.1 SAST Findings

Track:

- Critical findings
- High findings
- Medium findings
- Low findings

Critical or high unresolved vulnerabilities must block promotion.

---

### 9.2 Dependency Vulnerabilities

Track vulnerable dependencies identified during dependency scanning.

Metrics include:

- Critical vulnerabilities
- High vulnerabilities
- Vulnerable packages
- Remediation age

---

### 9.3 Container Vulnerabilities

Measures vulnerabilities discovered in container images.

Track:

```text
Critical vulnerabilities
High vulnerabilities
Medium vulnerabilities
Low vulnerabilities
```

Production promotion must be blocked when unacceptable vulnerability thresholds are exceeded.

---

### 9.4 DAST Findings

Track runtime security findings detected by Dynamic Application Security Testing.

---

## 10. Compliance Metrics

### 10.1 Compliance Gate Pass Rate

```text
Passed compliance checks
------------------------
Total compliance checks
x 100
```

---

### 10.2 RBI Policy Violations

Track policy violations mapped to NovaPay RBI compliance controls.

---

### 10.3 PCI-DSS Policy Violations

Track violations of controls mapped to PCI-DSS requirements.

---

### 10.4 Segregation of Duties Violations

Track attempted or detected SoD violations.

Examples:

- Developer self-approving production release
- Missing dual approval
- Unauthorized production promotion

---

### 10.5 Compliance Approval Time

Measures how long a production deployment waits for required compliance or release approvals.

---

## 11. Deployment Metrics

### 11.1 Deployment Success Rate

```text
Successful deployments
----------------------
Total deployments
x 100
```

---

### 11.2 Deployment Failure Rate

Tracks unsuccessful deployments.

---

### 11.3 Rollback Rate

```text
Rollback deployments
--------------------
Production deployments
x 100
```

---

### 11.4 Rollback Duration

Measures the time required to restore the last known good production release.

---

### 11.5 Canary Success Rate

```text
Successful canary promotions
----------------------------
Total canary deployments
x 100
```

---

### 11.6 Canary Abort Rate

Tracks canary deployments automatically stopped due to failed health thresholds.

---

### 11.7 Promotion Waiting Time

Measures time spent waiting between:

```text
Development
→ Staging
→ Pre-Production
→ Production
```

This helps identify bottlenecks caused by approvals or validation stages.

---

## 12. Application Reliability Metrics

Production application metrics include:

### Availability

```text
Successful requests / Total requests * 100
```

---

### HTTP Error Rate

Track:

```text
HTTP 5xx responses / Total requests * 100
```

---

### Request Latency

Track:

- p50
- p95
- p99

Expected production target:

```text
p99 < 500 ms
```

where applicable to the defined performance validation.

---

### Payment Success Rate

```text
Successful payments
-------------------
Total payment requests
x 100
```

---

### Payment Failure Rate

```text
Failed payments
---------------
Total payment requests
x 100
```

---

### Application Readiness

Monitor:

```text
/ready
```

Expected:

```text
HTTP 200
```

---

### Application Health

Monitor:

```text
/health
```

Expected:

```text
HTTP 200
```

---

## 13. Kubernetes Metrics

The production Kubernetes environment must monitor:

- Pod availability
- Pod restart count
- CPU usage
- Memory usage
- Deployment replicas
- Unavailable replicas
- Container failures
- Kubernetes node health
- Kubernetes API health
- Horizontal scaling events

---

## 14. ArgoCD Metrics

Track:

- Application synchronization state
- Application health status
- Sync failures
- Drift detection events
- Deployment reconciliation time
- Failed reconciliation attempts

Expected production state:

```text
Sync Status: Synced
Health Status: Healthy
```

---

## 15. Database Metrics

Track database health during and after deployments.

Metrics include:

- Database connection failures
- Query latency
- Failed migrations
- Migration duration
- Database CPU
- Database memory
- Connection pool utilisation
- Transaction failures

Database migration alerts must be correlated with deployment events.

---

## 16. Pipeline Metric Summary

NovaPay tracks the following primary CI/CD metrics:

| No. | Metric | Category |
|---:|---|---|
| 1 | Deployment Frequency | DORA |
| 2 | Lead Time for Changes | DORA |
| 3 | Change Failure Rate | DORA |
| 4 | Mean Time to Restore | DORA |
| 5 | Pipeline Success Rate | Build |
| 6 | Pipeline Failure Rate | Build |
| 7 | Pipeline Duration | Build |
| 8 | Build Duration | Build |
| 9 | Unit Test Success Rate | Testing |
| 10 | Test Coverage | Testing |
| 11 | SAST Findings | Security |
| 12 | Dependency Vulnerabilities | Security |
| 13 | Container Vulnerabilities | Security |
| 14 | DAST Findings | Security |
| 15 | Compliance Gate Pass Rate | Compliance |
| 16 | RBI Policy Violations | Compliance |
| 17 | PCI-DSS Policy Violations | Compliance |
| 18 | SoD Violations | Compliance |
| 19 | Compliance Approval Time | Compliance |
| 20 | Deployment Success Rate | Deployment |
| 21 | Deployment Failure Rate | Deployment |
| 22 | Rollback Rate | Deployment |
| 23 | Rollback Duration | Deployment |
| 24 | Canary Success Rate | Deployment |
| 25 | Canary Abort Rate | Deployment |
| 26 | Promotion Waiting Time | Deployment |
| 27 | Application Availability | Reliability |
| 28 | HTTP Error Rate | Reliability |
| 29 | p99 Request Latency | Reliability |
| 30 | Payment Success Rate | Business |

This provides more than the required 15 pipeline-specific metrics.

---

## 17. Metric Labels

Metrics should include consistent labels where appropriate.

Example:

```text
environment="production"
service="novapay-payment-api"
pipeline="production"
release="v1.2.0"
severity="critical"
compliance="pci-dss"
```

Labels allow dashboards to filter by:

- Environment
- Application
- Release
- Pipeline
- Severity
- Compliance framework

---

## 18. Dashboard Strategy

NovaPay will maintain three primary dashboards.

### Engineering Dashboard

Audience:

```text
Developers + DevOps + SRE
```

Focus:

- Real-time production health
- Pipeline status
- Deployment status
- Error rate
- Latency
- Kubernetes health
- Canary status
- Rollback state
- Active alerts

---

### Management Dashboard

Audience:

```text
Engineering Managers + Leadership
```

Focus:

- DORA metrics
- Deployment frequency
- Lead time
- Change failure rate
- MTTR
- Pipeline success rate
- Production incidents
- Release trends

---

### Regulatory Dashboard

Audience:

```text
Compliance + Security + Auditors
```

Focus:

- Compliance gate pass rate
- RBI control status
- PCI-DSS control status
- Security scan status
- Production approvals
- Segregation of duties
- Deployment audit trail
- Evidence completeness

---

## 19. Data Retention

Observability information used as deployment or compliance evidence must be retained according to NovaPay's approved retention requirements.

Evidence may include:

- Pipeline execution logs
- Security scan reports
- Compliance reports
- Deployment timestamps
- Approval records
- Rollback events
- Incident records
- Dashboard snapshots where required
- Release artifact metadata

---

## 20. Alerting Integration

Alerts should be generated when predefined thresholds are violated.

Examples:

```text
HTTP 5xx rate exceeds threshold
p99 latency exceeds threshold
Payment failure rate increases
Production pod becomes unavailable
Canary health check fails
ArgoCD synchronization fails
Critical vulnerability detected
Compliance gate fails
Database migration fails
Rollback is triggered
```

Alerts will be routed based on severity to the relevant teams.

Detailed alert routing is defined in:

```text
docs/08-observability/alerting-strategy.md
```

---

## 21. Auditability

Each production release must be traceable to:

```text
Git Commit
     ↓
Pipeline Run
     ↓
Test Results
     ↓
Security Scan Results
     ↓
Compliance Results
     ↓
Artifact Digest
     ↓
Approval Evidence
     ↓
Deployment
     ↓
Production Verification
```

This enables end-to-end audit evidence for every production release.

---

## 22. Success Criteria

The observability implementation is successful when:

- All four DORA metrics are measurable.
- At least 15 CI/CD metrics are available.
- Production reliability is visible.
- Deployment failures are detectable.
- Canary failures generate alerts.
- Rollbacks are measurable.
- Compliance status is visible.
- Engineering teams have real-time operational visibility.
- Management has delivery-performance visibility.
- Compliance teams have audit-ready evidence.

---

## 23. Summary

The NovaPay observability strategy provides end-to-end visibility across the CI/CD pipeline, security controls, compliance gates, deployment strategies, Kubernetes infrastructure, and production application.

DORA metrics provide delivery-performance measurement, while pipeline-specific metrics provide detailed engineering, security, compliance, and deployment visibility.

Three dedicated dashboards provide views tailored for Engineering, Management, and Regulatory stakeholders.---

## Related Deliverables

- [Deliverable 1 – Pipeline Architecture](../01-pipeline-architecture/architecture.md)
- [Deliverable 2 – Deployment Strategies](../02-deployment-strategies/deployment-strategy.md)
- [Deliverable 3 – Compliance Gates](../03-compliance-gates/compliance-gates.md)
- [Deliverable 4 – Database Migration](../04-database-migration/database-migration-strategy.md)
- [Deliverable 5 – Environment Promotion](../05-environment-promotion/environment-promotion.md)
- [Deliverable 6 – Rollback Specification](../06-rollback-specification/rollback-specification.md)
- [Deliverable 7 – Deployment Runbook](../07-runbook-playbook/deployment-runbook.md)
- [Friday 5 PM Incident Simulation](../09-incident-simulation/friday-5pm-incident.md)
- [Incident Postmortem](../09-incident-simulation/postmortem.md)