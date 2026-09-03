# Stage 5 - DAST & Contract Validation

## Purpose
Validate the running application against dynamic security vulnerabilities and API compatibility failures.

## Tools
- OWASP ZAP
- pytest
- Contract testing
- GitHub Actions

## Configuration
DAST executes against a running NovaPay test deployment.
Contract tests validate payment API expectations between services.

## Thresholds
- Critical DAST findings: 0
- High DAST findings: 0 unless formally approved
- Contract test failures: 0
- API compatibility failures: 0

## Failure & Remediation
DAST failures require security remediation.
Contract failures require API or consumer/provider compatibility correction before promotion.

## Retry / Skip Logic
- DAST may retry once for environment startup failures
- Security or contract validation failures cannot be skipped for production

## SLA Target
Target execution time: less than 20 minutes.

## Evidence
- ZAP reports
- Contract test logs
- Pipeline execution evidence
