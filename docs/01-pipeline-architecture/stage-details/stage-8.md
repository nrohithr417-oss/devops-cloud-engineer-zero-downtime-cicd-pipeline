# Stage 8 - Production Verification, Observability & Rollback

## Purpose
Verify production health after deployment and automatically protect NovaPay through monitoring and rollback.

## Tools
- Prometheus
- Grafana
- Kubernetes
- Argo Rollouts
- GitHub Actions

## Configuration
Monitor:
- HTTP 5xx error rate
- p99 latency
- Health/readiness status
- Payment success rate
- CPU and memory
- OOM and CrashLoopBackOff
- Database connectivity
- DORA metrics

## Thresholds
Immediate rollback examples:
- HTTP 5xx > 5% for 60 seconds
- 3 consecutive health-check failures
- OOM kill
- CrashLoopBackOff
- Database connection pool exhaustion

Escalated rollback examples:
- p99 latency > 2x baseline for 5 minutes
- Error budget burn rate > 10x normal for 10 minutes
- Transaction success rate falls > 2% below baseline
- CPU > 90% or memory > 85% for 5 minutes

## Failure & Remediation
Immediate conditions trigger automatic rollback.
Escalated conditions alert on-call engineers and roll back when the escalation window expires without resolution.

## Retry / Skip Logic
- Health verification retries according to probe configuration
- Category A rollback conditions cannot be overridden during automated protection

## SLA Target
- Immediate rollback: less than 60 seconds
- Escalated rollback: less than 15 minutes

## Evidence
- Prometheus metrics
- Grafana dashboards
- Rollout history
- Incident records
- Post-deployment verification logs
