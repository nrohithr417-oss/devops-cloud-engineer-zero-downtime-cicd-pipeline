# NovaPay Environment Promotion Workflow

## 1. Overview

NovaPay uses a four-environment promotion model:

Dev → Staging → Pre-Prod → Production

The same application artefact is promoted across all environments. Only configuration changes between environments.

The objective is to ensure that every release passes automated testing, security validation, compliance checks, and approval gates before reaching production.

---

## 2. Environment Model

| Environment | Purpose | Data Profile | Access Control | Deployment Trigger |
|---|---|---|---|---|
| Development | Feature development and unit testing | Synthetic / mock data | Developers | Automatic after PR merge |
| Staging | Integration testing, DAST and performance validation | Anonymised production-like data | Development + QA teams | Automatic after Dev gates pass |
| Pre-Production | UAT and regulatory compliance verification | Masked production data subset | QA + Compliance + DBA | Manual approval after Staging |
| Production | Live customer-facing banking environment | Real production data | SRE + Release Manager only | Dual approval |

---

## 3. Dev to Staging Promotion

Promotion from Development to Staging is automatic when all required gates pass.

### Promotion Criteria

- 100% unit tests must pass
- Minimum 80% line coverage
- Minimum 70% branch coverage
- SAST must report:
  - 0 Critical vulnerabilities
  - Maximum 2 High vulnerabilities
- Container image must be successfully built
- Artefact must use a SemVer version
- Container image must be signed
- Image must be pushed to the container registry

If any condition fails, promotion is blocked.

---

## 4. Staging to Pre-Production Promotion

Promotion from Staging to Pre-Production requires technical validation plus manual approval.

### Promotion Criteria

- All integration tests pass
- Consumer-driven contract tests pass
- DAST scan completes successfully
- 0 Critical OWASP Top 10 findings
- 0 High OWASP Top 10 findings
- p99 latency below 500 ms under 2x expected production load
- Dependency scan reports 0 Critical CVEs
- SBOM generated and archived
- Licence compliance passes
- No prohibited GPL / AGPL dependencies
- Tech Lead approval required

If the required checks fail, the pipeline must stop and the release cannot proceed.

---

## 5. Pre-Production to Production Promotion

Production deployment is the most restrictive promotion stage.

### Promotion Criteria

- Product Owner UAT sign-off
- RBI compliance gates passed
- PCI-DSS compliance gates passed
- Database migration validated in Pre-Prod
- Deployment runbook reviewed
- Change approval completed
- Release Manager approval
- SRE Lead approval
- Deployment blackout period check passed
- Deployment must not occur during restricted peak periods
- On-call engineer must be available

Production promotion requires dual approval to enforce segregation of duties.

---

## 6. RBAC and Segregation of Duties

NovaPay uses role-based access control throughout the promotion workflow.

### Developers

Developers can:

- Commit application code
- Create pull requests
- Deploy to Development
- View CI/CD results

Developers cannot directly deploy to Production.

### QA Team

QA engineers validate:

- Integration tests
- Contract tests
- Regression testing
- Pre-production validation

### Compliance Team

The compliance team verifies:

- RBI control mappings
- PCI-DSS requirements
- Regulatory evidence
- Policy gate results

### DBA

The DBA approves database migration procedures before Production promotion.

### Release Manager

The Release Manager reviews and approves Production releases.

### SRE Lead

The SRE Lead provides the second Production approval and validates operational readiness.

This separation prevents one individual from developing, approving, and deploying the same production change.

---

## 7. Configuration Management

NovaPay follows the principle:

> Same artefact, different configuration.

The same container image is promoted through all environments.

Configuration hierarchy:

Base Configuration
↓
Environment Override
↓
Service Override

Example:

values.yaml
values-dev.yaml
values-staging.yaml
values-preprod.yaml
values-production.yaml

Environment-specific application code branches are not permitted.

---

## 8. Secrets Management

Secrets must never be stored directly in:

- Git repositories
- Helm values
- Kubernetes manifests
- CI/CD workflow files

Secrets should be retrieved dynamically using:

- HashiCorp Vault

or

- AWS Secrets Manager

Recommended rotation policy:

- Database passwords: every 90 days
- API keys: every 30 days

Access to production secrets must be restricted using RBAC.

---

## 9. Environment Data Management

### Development

Uses:

- Synthetic data
- Mock services
- Test accounts

No production customer data is allowed.

### Staging

Uses anonymised production-like data.

Personally identifiable information must be removed.

### Pre-Production

Uses a masked subset of production-like data for:

- UAT
- Database migration testing
- Compliance validation
- Performance testing

### Production

Contains real banking and customer data.

Access must be highly restricted and audited.

---

## 10. Feature Flags

New features may be deployed while remaining disabled in Production.

Recommended progressive enablement:

1%
↓
10%
↓
50%
↓
100%

This reduces release risk and complements the NovaPay canary deployment strategy.

---

## 11. Configuration Drift Detection

ArgoCD compares the Git-declared Kubernetes configuration with the live cluster state.

Any detected drift should:

1. Generate an alert
2. Record the configuration difference
3. Notify the SRE team
4. Optionally trigger automatic synchronization

Git remains the source of truth for deployment configuration.

---

## 12. Promotion Flow

```text
Developer Commit
       |
       v
Development
       |
       | Unit Tests
       | Coverage
       | SAST
       | Image Build
       v
Staging
       |
       | Integration Tests
       | Contract Tests
       | DAST
       | Performance Tests
       | Dependency Scan
       v
Tech Lead Approval
       |
       v
Pre-Production
       |
       | UAT
       | RBI Compliance
       | PCI-DSS Compliance
       | Database Migration Validation
       v
Release Manager Approval
       +
SRE Lead Approval
       |
       v
Production---

## Related Deliverables

- [Deliverable 1 – Pipeline Architecture](../01-pipeline-architecture/architecture.md)
- [Deliverable 2 – Deployment Strategies](../02-deployment-strategies/deployment-strategy.md)
- [Deliverable 3 – Compliance Gates](../03-compliance-gates/compliance-gates.md)
- [Deliverable 4 – Database Migration](../04-database-migration/database-migration-strategy.md)
- [Deliverable 6 – Rollback Specification](../06-rollback-specification/rollback-specification.md)
- [Deliverable 7 – Deployment Runbook](../07-runbook-playbook/deployment-runbook.md)
- [Deliverable 8 – Observability](../08-observability/observability-strategy.md)
- [Incident Simulation – Friday 5 PM](../09-incident-simulation/friday-5pm-incident.md)