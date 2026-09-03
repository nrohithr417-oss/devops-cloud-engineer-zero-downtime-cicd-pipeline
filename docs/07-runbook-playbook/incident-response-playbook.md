# NovaPay Incident Response Playbook

## 1. Purpose

This playbook defines how NovaPay detects, classifies, escalates, communicates, mitigates, and resolves production incidents.

It is intended for SRE, DevOps, Engineering, Security, Compliance, Release Management, and on-call teams.

The objective is to restore service quickly while preserving customer safety, data integrity, regulatory compliance, and auditability.

---

## 2. Incident Severity Classification

| Severity | Definition | Response Time | Escalation Path |
|---|---|---:|---|
| SEV-1 | Complete service outage or data integrity risk | < 5 minutes | CTO + CISO + VP Engineering |
| SEV-2 | Major feature degradation affecting more than 10% of users | < 15 minutes | VP Engineering + SRE Lead |
| SEV-3 | Minor degradation where a workaround exists | < 1 hour | SRE On-Call + Tech Lead |
| SEV-4 | Cosmetic issue with no user impact | Next business day | Assigned Engineer |

---

## 3. Incident Examples

### SEV-1

Examples:

- NovaPay payment service unavailable
- Customer transactions failing globally
- Confirmed data corruption
- Critical security compromise
- Production database unavailable
- Widespread authentication outage

### SEV-2

Examples:

- Payment failures affecting more than 10% of users
- Significant latency degradation
- One major banking function unavailable
- Production service unstable but partially functional
- Repeated pod crashes causing partial customer impact

### SEV-3

Examples:

- Minor performance degradation
- Limited regional impact
- Non-critical integration failure
- Intermittent issue with a known workaround

### SEV-4

Examples:

- UI alignment problem
- Logging formatting issue
- Non-customer-facing dashboard defect
- Cosmetic documentation error

---

# 4. Incident Response Workflow

NovaPay follows a seven-step incident response workflow.

```text
1. Detect
   ↓
2. Classify
   ↓
3. Mobilise
   ↓
4. Contain / Mitigate
   ↓
5. Recover
   ↓
6. Communicate & Close
   ↓
7. Postmortem