# NovaPay Observability Dashboard Wireframes

## 1. Purpose

This document defines the dashboard design for the NovaPay Zero-Downtime CI/CD platform.

NovaPay maintains three dashboards:

1. Engineering Dashboard – real-time operational visibility.
2. Management Dashboard – weekly and monthly delivery performance.
3. Regulatory Dashboard – audit-ready security and compliance visibility.

Grafana is used as the primary visualization platform, with metrics collected from CI/CD pipelines, Prometheus, Kubernetes, ArgoCD, application services, security tools, and compliance controls.

---

# 2. Engineering Dashboard

## 2.1 Audience

Primary users:

- Developers
- DevOps Engineers
- SRE Engineers
- Technical Leads
- On-Call Engineers

## 2.2 Objective

Provide real-time visibility into:

- CI/CD pipeline health
- Production deployments
- Application availability
- Error rates
- Latency
- Payment processing
- Kubernetes health
- Canary deployment status
- Rollbacks
- Active alerts

## 2.3 Engineering Dashboard Wireframe

```text
+--------------------------------------------------------------------+
|                NOVAPAY ENGINEERING DASHBOARD                        |
+--------------------------------------------------------------------+
| Environment: Production | Release: vX.X.X | ArgoCD: Synced/Healthy |
+--------------------------------------------------------------------+

+----------------------+ +----------------------+ +-------------------+
| APPLICATION          | | HTTP ERROR RATE      | | PAYMENT SUCCESS   |
| AVAILABILITY         | |                      | | RATE              |
|                      | | 5xx: XX%             | |                   |
| 99.99%               | |                      | | XX.XX%            |
+----------------------+ +----------------------+ +-------------------+

+----------------------+ +----------------------+ +-------------------+
| P95 LATENCY          | | P99 LATENCY          | | ACTIVE ALERTS     |
|                      | |                      | |                   |
| XXX ms               | | XXX ms               | | SEV-1: X          |
|                      | | Target < 500 ms      | | SEV-2: X          |
+----------------------+ +----------------------+ +-------------------+

+--------------------------------------------------------------------+
|                    REQUEST RATE / ERROR RATE                        |
|                                                                    |
|        Requests/sec and HTTP 5xx time-series graph                 |
|                                                                    |
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
|                       REQUEST LATENCY                               |
|                                                                    |
|                  p50 / p95 / p99 graph                             |
|                                                                    |
+--------------------------------------------------------------------+

+---------------------------+ +--------------------------------------+
| KUBERNETES HEALTH         | | CURRENT DEPLOYMENT                   |
|                           | |                                      |
| Healthy Pods: XX          | | Version: vX.X.X                     |
| Pod Restarts: XX          | | Strategy: Canary                    |
| CPU: XX%                  | | Traffic: 25%                         |
| Memory: XX%               | | Status: Healthy                     |
+---------------------------+ +--------------------------------------+

+---------------------------+ +--------------------------------------+
| ARGOCD                    | | CANARY ANALYSIS                      |
|                           | |                                      |
| Sync: Synced              | | Error Rate: PASS                    |
| Health: Healthy           | | Latency: PASS                       |
| Drift: None               | | Health: PASS                        |
+---------------------------+ +--------------------------------------+

+--------------------------------------------------------------------+
|                     RECENT PIPELINE RUNS                            |
|                                                                    |
| Run ID | Commit | Version | Duration | Result | Deployment          |
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
|                         ACTIVE ALERTS                               |
|                                                                    |
| Severity | Alert | Service | Started | Owner                       |
+--------------------------------------------------------------------+
```

## 2.4 Engineering Dashboard Panels

| Panel | Metric |
|---|---|
| Application Availability | Successful requests / total requests |
| HTTP Error Rate | HTTP 5xx percentage |
| Payment Success Rate | Successful payment percentage |
| p95 Latency | p95 request latency |
| p99 Latency | p99 request latency |
| Request Rate | Requests per second |
| Pod Health | Available Kubernetes pods |
| Pod Restarts | Container restart count |
| CPU Usage | Kubernetes CPU utilisation |
| Memory Usage | Kubernetes memory utilisation |
| ArgoCD Sync | Application sync status |
| ArgoCD Health | Application health |
| Canary Status | Current canary phase |
| Rollback Status | Current/recent rollback |
| Active Alerts | Current severity-based alerts |

## 2.5 Engineering Refresh Rate

Recommended dashboard refresh:

```text
15-30 seconds
```

The Engineering Dashboard is intended for real-time operational use.

---

# 3. Management Dashboard

## 3.1 Audience

Primary users:

- Engineering Managers
- SRE Managers
- VP Engineering
- CTO
- Release Management

## 3.2 Objective

Provide weekly and monthly visibility into software-delivery performance and operational reliability.

The dashboard focuses primarily on DORA metrics and release trends.

## 3.3 Management Dashboard Wireframe

```text
+--------------------------------------------------------------------+
|                 NOVAPAY MANAGEMENT DASHBOARD                        |
+--------------------------------------------------------------------+
| Period: Last 30 Days | Application: NovaPay Payment API             |
+--------------------------------------------------------------------+

+----------------------+ +----------------------+ +-------------------+
| DEPLOYMENT           | | LEAD TIME FOR       | | CHANGE FAILURE    |
| FREQUENCY            | | CHANGES             | | RATE              |
|                      | |                      | |                   |
| XX / Week            | | XX Minutes          | | XX%               |
+----------------------+ +----------------------+ +-------------------+

+----------------------+ +----------------------+ +-------------------+
| MTTR                 | | PIPELINE SUCCESS     | | PROD INCIDENTS    |
|                      | | RATE                 | |                   |
| XX Minutes           | | XX%                  | | SEV-1: X          |
|                      | |                      | | SEV-2: X          |
+----------------------+ +----------------------+ +-------------------+

+--------------------------------------------------------------------+
|                     DEPLOYMENT FREQUENCY                            |
|                                                                    |
|             Daily / Weekly Deployment Trend                        |
|                                                                    |
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
|                       LEAD TIME TREND                               |
|                                                                    |
|            Commit-to-Production Duration Trend                     |
|                                                                    |
+--------------------------------------------------------------------+

+------------------------------+ +-----------------------------------+
| CHANGE FAILURE RATE          | | MTTR TREND                        |
|                              | |                                   |
| Successful: XX               | | Incident recovery duration        |
| Failed: XX                   | | by week/month                     |
| Rollbacks: XX                | |                                   |
+------------------------------+ +-----------------------------------+

+--------------------------------------------------------------------+
|                    PIPELINE PERFORMANCE                             |
|                                                                    |
| Pipeline Success | Failure | Avg Duration | Approval Waiting Time  |
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
|                      RELEASE SUMMARY                                |
|                                                                    |
| Version | Date | Lead Time | Result | Rollback | Incident           |
+--------------------------------------------------------------------+
```

## 3.4 Management Dashboard Panels

| Panel | Purpose |
|---|---|
| Deployment Frequency | Measure production delivery frequency |
| Lead Time for Changes | Measure commit-to-production time |
| Change Failure Rate | Measure production change failures |
| MTTR | Measure recovery performance |
| Pipeline Success Rate | Measure CI/CD reliability |
| Pipeline Duration | Identify pipeline delays |
| Approval Waiting Time | Identify approval bottlenecks |
| Production Incidents | Track SEV-1 and SEV-2 incidents |
| Rollback Rate | Track deployment instability |
| Release Trend | Show release performance over time |

## 3.5 Reporting Period

Management should be able to select:

```text
7 Days
30 Days
Quarter
Custom Range
```

The dashboard supports both weekly and monthly executive reporting.

---

# 4. Regulatory Dashboard

## 4.1 Audience

Primary users:

- Compliance Team
- Security Team
- Risk Team
- Internal Auditors
- Authorized External Auditors

## 4.2 Objective

Provide audit-ready evidence showing that required security, compliance, approval, and segregation-of-duties controls were executed for production releases.

## 4.3 Regulatory Dashboard Wireframe

```text
+--------------------------------------------------------------------+
|                 NOVAPAY REGULATORY DASHBOARD                        |
+--------------------------------------------------------------------+
| Period: <range> | Environment: Production | Service: Payment API    |
+--------------------------------------------------------------------+

+----------------------+ +----------------------+ +-------------------+
| COMPLIANCE GATE      | | RBI CONTROL         | | PCI-DSS CONTROL   |
| PASS RATE            | | STATUS              | | STATUS            |
|                      | |                      | |                   |
| XX%                  | | PASS / FAIL         | | PASS / FAIL       |
+----------------------+ +----------------------+ +-------------------+

+----------------------+ +----------------------+ +-------------------+
| SAST                 | | CONTAINER SCAN      | | DAST              |
|                      | |                      | |                   |
| Critical: 0          | | Critical: 0         | | Critical: 0       |
| High: 0              | | High: 0             | | High: 0           |
+----------------------+ +----------------------+ +-------------------+

+----------------------+ +----------------------+ +-------------------+
| DEPENDENCY SCAN      | | SoD VIOLATIONS      | | APPROVAL STATUS   |
|                      | |                      | |                   |
| Critical: 0          | | 0                    | | Approved          |
| High: 0              | |                      | |                   |
+----------------------+ +----------------------+ +-------------------+

+--------------------------------------------------------------------+
|                     COMPLIANCE GATE HISTORY                         |
|                                                                    |
| Release | RBI | PCI-DSS | SAST | DAST | Container | Result         |
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
|                      APPROVAL AUDIT TRAIL                           |
|                                                                    |
| Release | Approver | Role | Approval Time | Result                 |
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
|                  SEGREGATION OF DUTIES                              |
|                                                                    |
| Release | Developer | Approver | SoD Status | Evidence             |
+--------------------------------------------------------------------+

+--------------------------------------------------------------------+
|                     RELEASE EVIDENCE                                |
|                                                                    |
| Commit | Pipeline | Artifact | SBOM | Scans | Approvals | Deploy    |
+--------------------------------------------------------------------+
```

## 4.4 Regulatory Dashboard Panels

| Panel | Purpose |
|---|---|
| Compliance Gate Pass Rate | Overall policy compliance |
| RBI Control Status | RBI control visibility |
| PCI-DSS Control Status | PCI-DSS compliance visibility |
| SAST Findings | Static security evidence |
| DAST Findings | Runtime security evidence |
| Dependency Findings | Dependency security evidence |
| Container Findings | Container security evidence |
| SoD Violations | Segregation-of-duties monitoring |
| Approval Status | Production approval evidence |
| Compliance Gate History | Historical control execution |
| Approval Audit Trail | Evidence of authorized approvals |
| Release Evidence | End-to-end deployment traceability |

---

# 5. Release Evidence Traceability

The Regulatory Dashboard must allow a production release to be traced through the complete delivery process.

```text
Git Commit
    |
    v
Pipeline Run
    |
    v
Unit / Integration Tests
    |
    v
SAST
    |
    v
Dependency Scan
    |
    v
Container Scan
    |
    v
DAST
    |
    v
RBI Compliance Gate
    |
    v
PCI-DSS Compliance Gate
    |
    v
Artifact + Digest + SBOM
    |
    v
Production Approvals
    |
    v
Production Deployment
    |
    v
Post-Deployment Verification
```

---

# 6. Dashboard Data Sources

| Source | Data |
|---|---|
| GitHub Actions | Pipeline execution and build data |
| Prometheus | Application and infrastructure metrics |
| Grafana | Visualization |
| Kubernetes | Pod, CPU, memory and deployment health |
| ArgoCD | GitOps sync and deployment status |
| SAST Tool | Static security findings |
| Dependency Scanner | Dependency vulnerabilities |
| Container Scanner | Image vulnerabilities |
| DAST Tool | Runtime security findings |
| OPA / Conftest | Compliance policy results |
| Incident Records | SEV incidents and MTTR |
| Deployment Records | Deployment and rollback history |

---

# 7. Dashboard Variables

Grafana dashboards should support filtering using variables.

Recommended variables:

```text
$environment
$service
$release
$pipeline
$severity
$compliance_framework
$time_range
```

Example:

```text
Environment: Production
Service: novapay-payment-api
Release: v1.2.0
```

---

# 8. Dashboard Time Ranges

## Engineering

Default:

```text
Last 1 Hour
```

Options:

```text
15 Minutes
1 Hour
6 Hours
24 Hours
```

## Management

Default:

```text
Last 30 Days
```

Options:

```text
7 Days
30 Days
Quarter
Custom
```

## Regulatory

Default:

```text
Last 90 Days
```

Options:

```text
30 Days
90 Days
Quarter
Year
Custom Audit Period
```

---

# 9. Dashboard Access Control

Dashboard access should follow RBAC principles.

| Dashboard | Access |
|---|---|
| Engineering | Developers, DevOps, SRE |
| Management | Engineering Management, SRE Management, Executives |
| Regulatory | Compliance, Security, Risk, Authorized Auditors |

Regulatory dashboard modification rights should be restricted.

Auditors should normally receive read-only access.

---

# 10. Alert Visualization

The Engineering Dashboard must clearly display active alerts by severity.

Example:

```text
SEV-1: Critical
SEV-2: Major
SEV-3: Minor
SEV-4: Informational
```

Each alert should contain:

```text
Incident ID
Severity
Service
Alert Name
Start Time
Current Status
Owner
```

---

# 11. Deployment Annotation

Production deployment events should be displayed as annotations on relevant Grafana graphs.

Example:

```text
14:05 - Production deployment v1.2.0
14:10 - Canary traffic 10%
14:15 - Canary traffic 25%
14:20 - Canary traffic 50%
14:25 - Full promotion
```

This allows SRE teams to correlate changes in:

- Error rate
- Latency
- Payment failures
- CPU
- Memory
- Availability

with a specific deployment.

---

# 12. Rollback Annotation

Rollback events should also appear on operational graphs.

Example:

```text
14:27 - Error threshold exceeded
14:28 - Canary promotion frozen
14:29 - Automated rollback initiated
14:32 - Previous version restored
14:35 - Health verification passed
```

---

# 13. Dashboard Success Criteria

The dashboard implementation is successful when:

- Engineering has real-time operational visibility.
- All four DORA metrics are visible to management.
- Pipeline performance can be measured.
- Production deployment events are traceable.
- Canary and rollback status are visible.
- Security findings are visible.
- Compliance gate status is visible.
- RBI and PCI-DSS controls can be reviewed.
- Segregation-of-duties evidence is available.
- Production approvals are auditable.
- Regulatory evidence can be filtered by release and time period.

---

# 14. Dashboard Files

Grafana dashboard JSON exports are maintained in:

```text
dashboards/grafana/engineering-dashboard.json
dashboards/grafana/management-dashboard.json
dashboards/grafana/regulatory-dashboard.json
```

These files provide version-controlled dashboard definitions alongside the NovaPay CI/CD project.

---

# 15. Summary

NovaPay uses three dedicated dashboard views to serve different operational and governance requirements.

The Engineering Dashboard provides real-time application, infrastructure, pipeline, and deployment visibility.

The Management Dashboard provides DORA metrics and delivery-performance trends for weekly and monthly reporting.

The Regulatory Dashboard provides audit-ready security, compliance, approval, and segregation-of-duties evidence.

Together, these dashboards provide end-to-end visibility from code commit through production operation and compliance verification.