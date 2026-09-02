# NovaPay Zero-Downtime Deployment Strategy

## 1. Objective

The NovaPay CI/CD platform is designed to deploy application and database changes while minimizing service interruption and reducing release risk.

The strategy combines:

- Kubernetes health probes
- Rolling updates
- Blue-green deployments
- Canary deployments
- Prometheus-based analysis
- Automated rollback
- GitOps with Argo CD
- Expand-contract database migrations

---

## 2. Zero-Downtime Deployment Principles

A release should not replace all running application instances simultaneously.

The platform therefore uses:

- Multiple application replicas
- Readiness probes
- Liveness probes
- Controlled traffic migration
- Progressive deployment
- Runtime verification
- Automatic failure detection
- Stable-version preservation

---

## 3. Kubernetes Rolling Updates

The base Kubernetes deployment uses:

```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxUnavailable: 0
    maxSurge: 1