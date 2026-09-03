# Stage 7 - Environment Promotion & Deployment

## Purpose
Promote the validated artifact through Dev, Staging, Pre-Prod and Production using controlled approvals.

## Tools
- Kubernetes
- Argo CD
- GitHub Actions
- Argo Rollouts
- Helm
- RBAC

## Configuration
Promotion path:
Dev -> Staging -> Pre-Prod -> Production

Production deployment strategies:
- Blue-green
- Canary

Production approval requires authorized Release Manager and SRE approval with segregation of duties.

## Thresholds
Promotion requires:
- All upstream gates passed
- p99 latency within approved limit
- No critical alerts
- Successful readiness and health checks
- Required approvals present

## Failure & Remediation
If deployment validation fails, stop promotion and trigger rollback workflow where applicable.

## Retry / Skip Logic
- Development deployment may retry after transient infrastructure failure
- Production approval and compliance gates cannot be bypassed

## SLA Target
Total commit-to-production target: less than 2 hours.

## Evidence
- Argo CD sync record
- GitHub Actions deployment log
- Kubernetes rollout status
- Approval audit trail
