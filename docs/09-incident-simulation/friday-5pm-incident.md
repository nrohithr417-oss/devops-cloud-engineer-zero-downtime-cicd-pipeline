# NovaPay Friday 5 PM Incident Simulation

## 1. Scenario

**Incident Date/Time:** Friday, 5:07 PM IST  
**Environment:** Production  
**Deployment Type:** Canary  
**Incident Severity:** SEV-1 / Critical

A developer pushed a critical hotfix directly toward production and bypassed the staging environment. The canary deployment had been running for approximately 8 minutes when three alerts fired simultaneously.

### Alerts

| Alert | Observed | Threshold | Severity |
|---|---:|---:|---|
| HTTP 500 Error Rate | 12% | 5% | Critical |
| PostgreSQL Connection Pool | Exhausted | Pool availability > 0 required | High |
| Payment Gateway Timeout Rate | 35% | Normal baseline | Critical |

The incident is treated as SEV-1 because customer payment processing is directly affected.

---

## 2. Pipeline Gate Analysis

The normal NovaPay deployment path is:

Developer Commit  
→ Stage 1: Source & Build  
→ Stage 2: Unit & Integration Tests  
→ Stage 3: SAST / Dependency Security  
→ Stage 4: Compliance / OPA  
→ Stage 5: DAST & Contract Testing  
→ Stage 6: Container Validation  
→ Stage 7: Environment Promotion  
→ Stage 8: Production Verification

The hotfix violated **Stage 7 – Environment Promotion** by bypassing staging.

Because staging was skipped, the deployment did not receive the full staging integration, DAST, contract, performance, and promotion validation before production.

### Gate That Was Bypassed

**Primary bypassed gate: Stage 7 – Staging → Pre-Production → Production promotion gate.**

The production workflow must fail closed when mandatory environment promotion evidence is missing.

---

## 3. Incident Timeline

### T+0 — 17:07:00 IST — Alerts Fire

Prometheus/Alertmanager detects:

- HTTP 500 error rate = 12%
- PostgreSQL connection pool exhaustion
- Downstream payment gateway timeout rate = 35%

HTTP 500 error rate exceeds the Category A rollback threshold of 5%.

**Decision:** Declare production incident.

**Action:** Freeze further deployments.

---

### T+30s — 17:07:30 IST — Triage

On-call SRE reviews the three correlated alerts.

Customer payment transactions are potentially failing.

**Severity:** SEV-1 / Critical.

The incident commander is assigned.

Initial hypothesis:

1. New canary version is unhealthy.
2. Database connection exhaustion may be contributing to HTTP 500 responses.
3. Payment gateway timeout increase may be amplifying resource exhaustion.

**Decision:** Do not continue canary promotion.

---

### T+1m — 17:08 IST — Canary Frozen

The deployment controller is instructed to stop further canary traffic increases.

No additional production changes are allowed.

The current deployment revision, image digest, Git commit, deployment actor, approvals, and alert evidence are captured for audit purposes.

---

### T+2m — 17:09 IST — Incident Communication

Incident notification is sent to:

- SRE / Operations
- Engineering Lead
- Release Manager
- DBA
- Application Owner
- Incident Commander
- Support / Business stakeholders

Message:

> SEV-1 NovaPay payment incident detected following a production canary deployment. HTTP 500 rate is 12%, PostgreSQL connection pool is exhausted, and payment gateway timeout rate is 35%. Canary promotion has been frozen and rollback is being prepared.

---

### T+3m — 17:10 IST — Correlation

The incident commander correlates:

- deployment timestamp,
- application error increase,
- database connection metrics,
- payment gateway timeout metrics.

The failures began after the hotfix canary deployment.

**Decision:** Treat the new release as the primary suspected change.

---

### T+4m — 17:11 IST — Rollback Decision

Category A rollback criteria are satisfied because:

- HTTP 5xx > 5% for 60 seconds.
- Database connection pool exhaustion is detected.

Both are defined immediate rollback conditions.

**Decision:** Execute automated rollback.

Target rollback time: **<60 seconds after rollback initiation**.

---

### T+5m — 17:12 IST — Rollback Initiated

NovaPay rollback automation is triggered.

For Argo Rollouts:

`kubectl argo rollouts undo novapay -n novapay`

If the Argo Rollouts plugin is unavailable, Kubernetes Deployment rollback is used:

`kubectl rollout undo deployment/novapay -n novapay`

Traffic is routed away from the faulty canary revision toward the last known-good version.

---

### T+6m — 17:13 IST — Rollback Verification

SRE verifies:

- Kubernetes pods become Ready.
- `/health` responds successfully.
- `/ready` responds successfully.
- HTTP 500 rate begins returning toward baseline.
- Database connection pool begins recovering.
- Payment gateway timeout rate decreases.
- No new CrashLoopBackOff/OOM conditions appear.

Rollback remains under observation.

---

### T+8m — 17:15 IST — Service Stabilisation

Prometheus metrics show recovery toward the pre-deployment baseline.

The team confirms that traffic is being served by the previous stable release.

No further deployment is permitted until root-cause investigation is complete.

---

### T+15m — 17:22 IST — Customer Impact Assessment

Engineering and support review failed payment transactions during the incident window.

Actions:

- Identify failed transactions.
- Check for duplicate/partial payment states.
- Reconcile payment records.
- Confirm transaction consistency.
- Prepare customer/support communication if required.

---

### T+30m — 17:37 IST — Root Cause Identified

Primary process root cause:

**The critical hotfix bypassed the mandatory staging and environment-promotion gate.**

The production pipeline allowed a release to progress without complete staging evidence.

Contributing technical symptoms:

- application HTTP 500 failures,
- PostgreSQL connection pool exhaustion,
- downstream payment gateway timeouts.

The available scenario establishes these symptoms but does not by itself prove which code-level defect caused all three. Detailed application/database traces would be required for that conclusion.

---

### T+45m — 17:52 IST — Remediation Plan

The team defines corrective actions:

1. Make Stage 7 environment promotion fail closed.
2. Prevent direct production deployment by developers.
3. Require staging evidence before pre-production.
4. Require production approval through RBAC/SoD controls.
5. Require immutable artifact promotion.
6. Add automated verification of staging deployment history.
7. Maintain automatic Category A rollback.
8. Preserve deployment and approval evidence for audit review.

---

### T+60m — 18:07 IST — Incident Contained

Production is stable on the previous known-good release.

Incident status changes from:

**ACTIVE → CONTAINED**

Monitoring continues while the postmortem process begins.

---

## 4. Root Cause

### Primary Root Cause

The mandatory environment promotion workflow was bypassed for a critical hotfix.

The hotfix reached the production canary without completing the normal staging validation path.

### Bypassed Pipeline Control

**Stage 7 – Environment Promotion**

Expected path:

Dev → Staging → Pre-Production → Production

Actual incident path:

Hotfix → Production Canary

This is a fail-open process that must be converted to fail-closed enforcement.

---

## 5. Why the Pipeline Did Not Prevent the Incident

The pipeline architecture defines environment promotion controls, but the simulated incident demonstrates that architectural documentation alone is insufficient.

Production deployment must technically require evidence that:

- the same artifact passed staging,
- integration tests passed,
- DAST passed,
- contract tests passed,
- required compliance gates passed,
- required approvals exist,
- the requester cannot self-approve.

If any evidence is absent, production promotion must automatically fail.

---

## 6. Corrective and Preventive Actions

| Action | Priority | Owner |
|---|---|---|
| Enforce staging promotion evidence | P0 | DevOps/SRE |
| Block direct developer production deployment | P0 | Platform Team |
| Enforce SoD production approval | P0 | Release Management |
| Verify immutable image digest across environments | P0 | DevOps |
| Strengthen DB pool monitoring | P1 | DBA/SRE |
| Add payment gateway timeout rollback signal | P1 | SRE |
| Add hotfix-specific controlled workflow | P1 | Platform Team |
| Test rollback procedure regularly | P1 | SRE |
| Review audit evidence after every emergency deployment | P1 | Compliance |

---

## 7. Pipeline Improvements

### Promotion Enforcement

Production jobs must depend on successful staging and pre-production jobs.

### RBAC

Developers must not have direct production deployment permission.

### Segregation of Duties

The person requesting a production deployment cannot be the sole approver.

### Immutable Artifact Promotion

The exact image digest validated in lower environments must be promoted to production.

### Automated Evidence Validation

The production gate must verify test results, security scans, compliance results, approvals, and artifact identity before deployment.

### Rollback Automation

Prometheus Category A alerts must trigger immediate rollback according to the rollback specification.

---

## 8. Lessons Learned

1. A documented control is not sufficient unless technically enforced.
2. Emergency hotfixes must not bypass mandatory safety controls.
3. Multiple simultaneous alerts should be correlated with recent deployment events.
4. Automated rollback reduces customer impact.
5. Database and downstream dependency health must be included in production verification.
6. SoD and RBAC controls must prevent direct production changes.
7. Deployment evidence must be retained for audit and post-incident analysis.

---

## 9. Final Incident Status

**Severity:** SEV-1  
**Status:** Contained  
**Rollback:** Successful in simulation  
**Primary Bypassed Gate:** Stage 7 – Environment Promotion  
**Customer Risk:** Failed/delayed payment transactions  
**Required Follow-up:** Formal postmortem and pipeline remediation

---

## 10. Related NovaPay Deliverables

- Deliverable 1 — Pipeline Architecture
- Deliverable 3 — Compliance Gates
- Deliverable 5 — Environment Promotion
- Deliverable 6 — Rollback Specification
- Deliverable 7 — Incident Response Playbook
- Deliverable 8 — Observability and Alerting
- `pipeline/scripts/rollback.sh`
- `monitoring/alerts/rollback-alert-rules.yaml`