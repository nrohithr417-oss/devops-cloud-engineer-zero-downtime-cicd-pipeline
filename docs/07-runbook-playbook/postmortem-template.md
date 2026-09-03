# NovaPay Incident Postmortem Template

## 1. Incident Information

| Field | Details |
|---|---|
| Incident ID | INC-XXXX |
| Incident Title | <title> |
| Severity | SEV-1 / SEV-2 / SEV-3 / SEV-4 |
| Incident Date | <date> |
| Start Time | <timestamp> |
| Detection Time | <timestamp> |
| Mitigation Time | <timestamp> |
| Resolution Time | <timestamp> |
| Total Duration | <duration> |
| Affected Service | <service> |
| Environment | Production |
| Incident Commander | <name/role> |
| Technical Lead | <name/role> |
| Current Release | <version> |
| Last Known Good Release | <version> |

---

## 2. Executive Summary

Provide a concise summary of the incident.

Include:

- What happened
- Which NovaPay service was affected
- Customer impact
- Business impact
- How the incident was detected
- How service was restored

Example:

```text
NovaPay experienced a production incident affecting the Payment API
following deployment of release <version>. Monitoring detected an
increase in HTTP 5xx responses and payment failures. The deployment
was frozen and traffic was restored to the last known good release.
Service health returned to normal after rollback verification.
```

---

## 3. Customer Impact

Document the customer impact.

| Item | Details |
|---|---|
| Users affected | <number / percentage> |
| Affected functionality | <function> |
| Failed transactions | <number> |
| Delayed transactions | <number> |
| Impact duration | <duration> |
| Geographic impact | <region/global> |
| Data integrity impact | None / Under Review / Confirmed |

Describe the impact:

<customer impact description>

---

## 4. Business Impact

Document:

- Transaction impact
- Service availability impact
- SLA/SLO impact
- Operational impact
- Financial impact, if known
- Regulatory or compliance impact

Business impact summary:

<description>

---

## 5. Detection

### Detection Method

The incident was detected by:

- Prometheus alert
- Grafana dashboard
- Application monitoring
- Kubernetes monitoring
- Security monitoring
- Customer support
- Engineering report
- Other: <description>

### Triggering Alert

```text
Alert:
<alert name>

Metric:
<metric>

Observed Value:
<value>

Threshold:
<threshold>

Detected:
<timestamp>
```

### Detection Effectiveness

Was the incident automatically detected?

Yes / No

Could the incident have been detected earlier?

<answer>

Were the monitoring thresholds appropriate?

Yes / No / Requires Improvement

---

## 6. Incident Severity

Assigned Severity:

```text
SEV-X
```

Reason:

<severity justification>

Severity definitions:

| Severity | Definition | Response Time |
|---|---|---|
| SEV-1 | Complete service outage or data integrity risk | < 5 minutes |
| SEV-2 | Major degradation affecting more than 10% of users | < 15 minutes |
| SEV-3 | Minor degradation with a workaround | < 1 hour |
| SEV-4 | Cosmetic issue with no user impact | Next business day |

---

## 7. Incident Timeline

All significant events must be recorded.

| Time | Event | Owner |
|---|---|---|
| T+0 | Alert triggered | Monitoring |
| T+30s | Initial triage started | SRE On-Call |
| T+2m | Severity classified | Incident Commander |
| T+3m | Incident team mobilised | Incident Commander |
| T+5m | Production deployment frozen | SRE |
| T+7m | Rollback initiated | SRE |
| T+10m | Previous stable release restored | SRE |
| T+15m | Health verification completed | Engineering |
| T+20m | Customer impact ended | Incident Commander |
| T+30m | Resolution update communicated | Communications Lead |

Replace the example entries with the actual incident timeline.

---

## 8. Deployment Information

Record the release involved in the incident.

```text
Application:
NovaPay Payment API

Failed Release:
<version>

Git Commit SHA:
<commit>

Container Image:
<image>

Container Digest:
sha256:<digest>

Pipeline Run ID:
<run-id>

Deployment Strategy:
Blue-Green / Canary

Deployment Started:
<timestamp>

Incident Detected:
<timestamp>
```

---

## 9. Root Cause

Describe the primary technical or operational cause.

Root Cause:

<root cause description>

Answer:

- What changed?
- Which component failed?
- Why did it fail?
- Why did the failure reach production?
- Which pipeline stage should have detected it?
- Was a quality gate bypassed?
- Was a compliance gate bypassed?
- Was monitoring sufficient?

---

## 10. Five Whys Analysis

### Why 1

Why did the customer-facing failure occur?

<answer>

### Why 2

Why did that technical failure happen?

<answer>

### Why 3

Why was the failure not detected before production?

<answer>

### Why 4

Why did the existing pipeline control fail to prevent it?

<answer>

### Why 5

Why was the underlying process or system weakness present?

<answer>

### Fundamental Cause

<summary>

---

## 11. Contributing Factors

Document factors that increased the likelihood or impact.

Possible examples:

- Missing automated test
- Insufficient test coverage
- Incorrect configuration
- Dependency failure
- Incorrect feature flag
- Inadequate monitoring
- Alert threshold too high
- Manual deployment error
- Missing security gate
- Missing compliance control
- Insufficient canary observation period
- Database compatibility problem

Confirmed contributing factors:

1. <factor>
2. <factor>
3. <factor>

---

## 12. Pipeline Gate Analysis

Determine which CI/CD control should have prevented the incident.

| Pipeline Gate | Expected Result | Actual Result | Improvement Required |
|---|---|---|---|
| Unit Tests | Detect code defects | <result> | <action> |
| SAST | Detect code security issues | <result> | <action> |
| Dependency Scan | Detect vulnerable dependencies | <result> | <action> |
| Container Scan | Detect image vulnerabilities | <result> | <action> |
| Integration Tests | Detect integration failures | <result> | <action> |
| Contract Tests | Detect API compatibility issues | <result> | <action> |
| DAST | Detect runtime security issues | <result> | <action> |
| Compliance Gate | Detect policy violations | <result> | <action> |
| Canary Analysis | Detect production regression | <result> | <action> |

---

## 13. Mitigation

Document immediate actions used to reduce customer impact.

Example sequence:

```text
Incident Detected
      ↓
Severity Classified
      ↓
Deployment Frozen
      ↓
Release Correlated
      ↓
Rollback Initiated
      ↓
Stable Version Restored
      ↓
Health Verification
```

Actions taken:

1. <action>
2. <action>
3. <action>

---

## 14. Recovery

Document the recovery procedure.

Example:

1. Stop further production promotion.
2. Identify the last known good release.
3. Redirect traffic to the stable version.
4. Verify Kubernetes deployment health.
5. Verify ArgoCD synchronization.
6. Run `/health`.
7. Run `/ready`.
8. Perform a controlled payment transaction.
9. Verify production metrics.
10. Confirm customer impact has ended.

Recovery completed:

<timestamp>

---

## 15. Post-Recovery Verification

Record results:

| Check | Expected | Result |
|---|---|---|
| `/health` | HTTP 200 | PASS / FAIL |
| `/ready` | HTTP 200 | PASS / FAIL |
| Payment transaction | Successful | PASS / FAIL |
| HTTP 5xx | Baseline | PASS / FAIL |
| p95 latency | Within SLO | PASS / FAIL |
| p99 latency | Within SLO | PASS / FAIL |
| Pod health | Healthy | PASS / FAIL |
| Database connectivity | Healthy | PASS / FAIL |
| Critical alerts | None | PASS / FAIL |

---

## 16. What Worked Well

Document successful controls and actions.

Examples:

- Prometheus alert detected the issue quickly.
- On-call SRE responded within the required SLA.
- Canary deployment limited customer exposure.
- Deployment freeze prevented further promotion.
- Previous stable version remained available.
- Rollback restored service quickly.
- Grafana dashboards provided useful visibility.
- Incident communication cadence was maintained.

What worked:

1. <item>
2. <item>
3. <item>

---

## 17. What Did Not Work Well

Examples:

- Automated testing did not detect the defect.
- Canary threshold was insufficient.
- Alert threshold was too high.
- Deployment observation period was too short.
- Communication was delayed.
- Runbook instructions were unclear.
- Required pipeline control was missing.

Issues identified:

1. <item>
2. <item>
3. <item>

---

## 18. Corrective and Preventive Actions

Every significant finding must have an owner and target date.

| ID | Corrective Action | Priority | Owner | Target Date | Status |
|---|---|---|---|---|---|
| CA-001 | Add missing automated test | High | Engineering | <date> | Open |
| CA-002 | Improve monitoring threshold | High | SRE | <date> | Open |
| CA-003 | Add pipeline validation gate | Critical | DevOps | <date> | Open |
| CA-004 | Update deployment runbook | Medium | SRE | <date> | Open |
| CA-005 | Review compliance control | High | Compliance | <date> | Open |

No corrective action should be recorded without an assigned owner.

---

## 19. CI/CD Improvements

Review whether improvements are required in:

- Unit testing
- Code coverage
- SAST
- Dependency scanning
- Container scanning
- Integration testing
- Contract testing
- DAST
- OPA policies
- Compliance gates
- Database migration validation
- Canary analysis
- Blue-green deployment
- Automated rollback
- Observability
- Alerting

Required improvements:

<details>

---

## 20. Monitoring Improvements

Evaluate:

- Was the correct metric monitored?
- Was the threshold appropriate?
- Was the alert actionable?
- Was alert routing correct?
- Was escalation fast enough?
- Did dashboards expose the failure clearly?

Required monitoring changes:

<details>

---

## 21. Compliance Impact Assessment

### RBI Impact

```text
None / Under Review / Confirmed
```

Details:

<details>

### PCI-DSS Impact

```text
None / Under Review / Confirmed
```

Details:

<details>

### Data Integrity Impact

```text
None / Under Review / Confirmed
```

Details:

<details>

### Security Impact

```text
None / Under Review / Confirmed
```

Details:

<details>

### Regulatory Notification Required

```text
Yes / No / Under Review
```

All external regulatory communication must follow NovaPay's approved Compliance and Security procedures.

---

## 22. Lessons Learned

Document lessons that can improve:

- Architecture
- CI/CD pipeline
- Testing
- Deployment safety
- Monitoring
- Rollback automation
- Security
- Compliance
- Incident response
- Communication

Lessons:

1. <lesson>
2. <lesson>
3. <lesson>

---

## 23. Follow-Up Review

A follow-up review must confirm completion of corrective actions.

Review Date:

```text
<date>
```

Reviewed By:

```text
<roles>
```

Outstanding Actions:

```text
<actions>
```

---

## 24. Postmortem Approval

Postmortem reviewed by:

- Incident Commander
- SRE Lead
- Engineering Lead
- Security representative where applicable
- Compliance representative where applicable

Final Status:

```text
OPEN / ACTIONS IN PROGRESS / CLOSED
```

---

## 25. Postmortem Completion Checklist

Before closing the postmortem, confirm:

- Incident timeline is complete.
- Root cause is documented.
- Contributing factors are documented.
- Customer impact is quantified where possible.
- Pipeline gate failure is identified.
- Corrective actions have owners.
- Corrective actions have target dates.
- Monitoring improvements are documented.
- Compliance impact has been assessed.
- Lessons learned are recorded.
- Follow-up review has been scheduled.

---

## 26. Summary

This postmortem template provides NovaPay with a structured method for reviewing production incidents, identifying root causes, tracking corrective actions, and improving CI/CD reliability.

The objective is not only to document the incident but to ensure lessons learned result in measurable improvements to deployment safety, monitoring, security, compliance, and operational resilience.