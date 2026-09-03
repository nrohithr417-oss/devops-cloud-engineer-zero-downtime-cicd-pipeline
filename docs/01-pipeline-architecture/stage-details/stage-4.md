# Stage 4 - Compliance & Policy Gates

## Purpose
Ensure deployment artifacts meet NovaPay banking security, RBI, PCI-DSS and segregation-of-duties controls.

## Tools
- OPA
- Conftest
- GitHub Actions
- Rego policies

## Configuration
Policy files:
- policies/compliance.rego
- policies/compliance-controls.yaml

Controls validate:
- Secure Kubernetes settings
- Privileged access restrictions
- Required approvals
- RBI-aligned controls
- PCI-DSS controls
- Segregation of Duties

## Thresholds
- Critical compliance violations: 0
- Failed mandatory policies: 0
- Missing approval evidence: fail
- Unapproved policy exception: fail

## Failure & Remediation
Failed controls stop pipeline promotion.
Engineering and compliance teams remediate policy violations or record a formally approved, time-bounded exception.

## Retry / Skip Logic
- Policy engine infrastructure failure may retry once
- Mandatory regulatory gates cannot be silently skipped

## SLA Target
Target execution time: less than 10 minutes.

## Evidence
- OPA/Conftest output
- Policy decision logs
- Approval records
- Commit SHA and pipeline run ID
