# NovaPay SEV-1 Incident Postmortem

## 1. Incident Summary

**Incident:** Production payment failures following critical hotfix  
**Start Time:** Friday, 17:07 IST  
**Severity:** SEV-1 / Critical  
**Environment:** Production  
**Deployment Strategy:** Canary  
**Status:** Contained and rolled back  
**Primary Control Failure:** Stage 7 – Environment Promotion bypass

A critical hotfix reached the production canary after bypassing staging. Approximately eight minutes into the canary deployment, three alerts fired simultaneously:

- HTTP 500 error rate reached 12%, exceeding the 5% threshold.
- PostgreSQL connection pool exhaustion was detected.
- Downstream payment gateway timeout rate reached 35%.

The canary was frozen and the release was rolled back to the previous known-good version.

---

## 2. Customer and Business Impact

The incident affected NovaPay's payment-processing path.

Potential customer impact included:

- failed payment requests,
- delayed payment processing,
- increased HTTP 500 responses,
- payment gateway timeouts,
- increased transaction latency.

Because this is a simulated incident, the exact number of affected customers and transactions cannot be determined from the scenario.

In a real incident, transaction reconciliation would be required to identify failed, duplicated, pending, or partially completed payments.

---

## 3. Detection

The incident was detected through production observability.

Three alerts fired simultaneously:

| Signal | Observed Value | Expected Threshold | Severity |
|---|---:|---:|---|
| HTTP 500 error rate | 12% | ≤5% | Critical |
| PostgreSQL connection pool | Exhausted | Available connections required | High |
| Payment gateway timeout rate | 35% | Baseline-dependent | Critical |

The HTTP 500 threshold and database pool exhaustion satisfied NovaPay Category A rollback conditions.

---

## 4. Incident Timeline

| Time | Event |
|---|---|
| 17:07 | Three production alerts fire |
| 17:07:30 | SRE triages incident and classifies SEV-1 |
| 17:08 | Canary promotion frozen |
| 17:09 | Incident communication sent |
| 17:10 | Deployment and alert correlation performed |
| 17:11 | Rollback decision confirmed |
| 17:12 | Rollback initiated |
| 17:13 | Post-rollback verification begins |
| 17:15 | Service metrics move toward baseline |
| 17:22 | Customer-impact assessment begins |
| 17:37 | Promotion-gate bypass identified as process root cause |
| 17:52 | Corrective-action plan defined |
| 18:07 | Incident declared contained |

Detailed decision evidence is documented in:

`docs/09-incident-simulation/friday-5pm-incident.md`

---

## 5. Root Cause Analysis

### Primary Process Root Cause

The critical hotfix bypassed the mandatory staging environment and reached the production canary.

The expected deployment path was:

**Dev → Staging → Pre-Production → Production**

The simulated incident followed:

**Hotfix → Production Canary**

This bypass removed mandatory validation from the normal promotion workflow.

### Primary Bypassed Gate

**Stage 7 – Environment Promotion**

Production promotion should have failed because staging and pre-production evidence was missing.

### Technical Symptoms

The deployment correlated with:

1. HTTP 500 error rate increasing to 12%.
2. PostgreSQL connection pool exhaustion.
3. Downstream payment gateway timeout rate increasing to 35%.

The simulation does not provide application traces, SQL traces, or source-code evidence sufficient to establish a more specific code-level defect.

Therefore, the confirmed root cause is the **deployment-control failure**, while the exact technical defect remains undetermined from the supplied scenario.

---

## 6. Five Whys Analysis

### Why did customers experience payment failures?

Because the production canary became unhealthy and generated elevated HTTP 500 errors and downstream timeouts.

### Why was an unhealthy release serving production traffic?

Because a critical hotfix was deployed to the production canary.

### Why was the hotfix allowed to reach production without complete validation?

Because staging was bypassed.

### Why could staging be bypassed?

Because the production promotion process was not sufficiently fail-closed against missing lower-environment evidence.

### Why was the control insufficient?

Because the environment promotion requirement existed in the architecture but was not enforced strongly enough as a mandatory technical prerequisite for production deployment.

### Five Whys Conclusion

The fundamental issue was not simply an unhealthy release. The deeper control failure was that the delivery system allowed the mandatory promotion path to be bypassed.

---

## 7. What Worked Well

### Observability

Production monitoring detected multiple failure signals quickly.

### Rollback Classification

HTTP 5xx above 5% and database pool exhaustion provided clear Category A rollback signals.

### Canary Deployment

Only canary traffic was initially exposed to the new release rather than immediately sending all production traffic to it.

### Rollback Capability

The deployment architecture provided a mechanism to return traffic to the previous known-good version.

### Incident Response

The response process included:

- detection,
- severity classification,
- deployment freeze,
- communication,
- correlation,
- rollback,
- verification,
- customer-impact assessment,
- postmortem.

---

## 8. What Did Not Work

### Environment Promotion Enforcement

Staging could be bypassed.

### Production Access Control

The scenario demonstrates that the hotfix path allowed an unsafe production promotion.

### Evidence Enforcement

Production deployment was not blocked despite missing staging evidence.

### Hotfix Governance

Emergency changes require a controlled workflow rather than bypassing the standard delivery controls.

### Dependency Protection

Payment gateway timeout behaviour should be incorporated into production verification and rollback decisions.

---

## 9. Corrective Actions

| ID | Corrective Action | Priority | Owner | Target |
|---|---|---|---|---|
| CA-01 | Make Stage 7 promotion fail closed | P0 | Platform Team | Immediate |
| CA-02 | Block direct developer production deployments | P0 | SRE | Immediate |
| CA-03 | Require staging evidence for production | P0 | DevOps | Immediate |
| CA-04 | Enforce requester/approver segregation | P0 | Release Management | Immediate |
| CA-05 | Verify immutable image digest across environments | P0 | DevOps | Immediate |
| CA-06 | Add payment gateway timeout alert/rollback evaluation | P1 | SRE | Next sprint |
| CA-07 | Strengthen PostgreSQL pool monitoring | P1 | DBA/SRE | Next sprint |
| CA-08 | Implement controlled emergency-hotfix workflow | P1 | Platform Team | Next sprint |
| CA-09 | Run periodic rollback exercises | P1 | SRE | Monthly |
| CA-10 | Audit emergency production changes | P1 | Compliance | Ongoing |

---

## 10. Pipeline Improvements

### 10.1 Fail-Closed Promotion

Production deployment must not begin unless required evidence exists for all previous environments.

Required evidence includes:

- successful staging deployment,
- integration test results,
- contract test results,
- DAST results,
- dependency/security results,
- compliance results,
- required approvals,
- immutable artifact identity.

Missing evidence must produce:

**DENY – Production Promotion**

---

### 10.2 Production RBAC

Developer identities must not have permission to deploy directly to production.

Production changes should be performed through controlled CI/CD service identities.

---

### 10.3 Segregation of Duties

The production deployment requester must not be the sole production approver.

The approval decision must be recorded as audit evidence.

---

### 10.4 Immutable Artifact Verification

The image digest tested in staging and pre-production must be identical to the digest promoted into production.

Rebuilding an application between environments must not be permitted.

---

### 10.5 Emergency Hotfix Workflow

Critical hotfixes require an expedited but controlled process.

Emergency status must not mean bypassing:

- security gates,
- compliance gates,
- production approval,
- artifact verification,
- rollback readiness,
- audit logging.

An emergency-change ticket must be attached to the deployment evidence.

---

### 10.6 Observability Improvements

Production monitoring should correlate:

- deployment revision,
- HTTP 5xx,
- p99 latency,
- transaction success,
- PostgreSQL pool utilisation,
- CPU and memory,
- pod health,
- downstream payment gateway timeouts.

This enables faster determination of whether degradation is associated with a new deployment.

---

## 11. Prevention Controls

The following controls must prevent recurrence:

1. Protected production environment.
2. Mandatory Stage 7 dependencies.
3. RBAC restrictions.
4. OPA/SoD policy checks.
5. Immutable artifact verification.
6. Required production approvals.
7. Deployment evidence validation.
8. Automated rollback triggers.
9. Emergency-change audit requirements.
10. Continuous production verification.

---

## 12. Post-Rollback Verification

After rollback, SRE must verify:

- application pods are Ready,
- health checks pass,
- HTTP 500 rate returns toward baseline,
- transaction success rate recovers,
- PostgreSQL pool availability recovers,
- payment gateway timeout rate returns toward baseline,
- CPU and memory remain healthy,
- no CrashLoopBackOff or OOM events occur.

Payment records must also be reconciled for the affected incident window.

---

## 13. Lessons Learned

1. Pipeline controls must be technically enforced, not only documented.
2. Emergency deployments must retain mandatory safety controls.
3. Staging bypass must automatically block production promotion.
4. Canary deployment reduces blast radius but does not replace pre-production testing.
5. Deployment events and operational metrics must be correlated.
6. Database exhaustion can rapidly amplify application failures.
7. Downstream dependency health is important for payment-system rollback decisions.
8. Production access must follow least privilege and segregation of duties.
9. Automated rollback must be tested regularly.
10. Every emergency change requires complete audit evidence.

---

## 14. Follow-Up Verification

The incident is not considered fully closed until:

- all P0 corrective actions are implemented,
- promotion bypass is technically blocked,
- RBAC/SoD controls are verified,
- rollback automation is tested,
- observability alerts are validated,
- the corrected pipeline successfully passes a simulated hotfix deployment.

---

## 15. Related Evidence

- `docs/01-pipeline-architecture/architecture.md`
- `docs/02-deployment-strategies/deployment-strategy.md`
- `docs/03-compliance-gates/compliance-gates.md`
- `docs/05-environment-promotion/environment-promotion.md`
- `docs/06-rollback-specification/rollback-specification.md`
- `docs/07-runbook-playbook/incident-response-playbook.md`
- `docs/08-observability/observability-strategy.md`
- `docs/09-incident-simulation/friday-5pm-incident.md`
- `monitoring/alerts/rollback-alert-rules.yaml`
- `pipeline/scripts/rollback.sh`

---

## 16. Postmortem Status

**Incident:** NovaPay Friday 5 PM Hotfix Incident  
**Severity:** SEV-1  
**Production Recovery:** Successful in simulation  
**Root Cause:** Mandatory environment promotion control bypass  
**Primary Failed Control:** Stage 7 – Environment Promotion  
**Postmortem Status:** Complete  
**Next Step:** Implement and validate corrective controls before another production release.