# Stage 6 - Artifact & Container Validation

## Purpose
Validate the deployable container image and ensure the exact approved artifact is promoted across environments.

## Tools
- Docker
- Container vulnerability scanner
- GitHub Actions
- Container registry

## Configuration
Artifact:
novapay-payment-api:<commit-sha>

The same immutable image must move from Dev through Production.
Environment differences are provided only through external configuration and secrets.

## Thresholds
- Critical container vulnerabilities: 0
- High vulnerabilities: 0 unless approved exception exists
- Image build success: 100%
- Artifact digest mismatch: fail

## Failure & Remediation
Rebuild the image only from corrected source.
Do not modify an already approved image between environments.

## Retry / Skip Logic
- Registry/network operations may retry
- Image security validation cannot be skipped

## SLA Target
Target execution time: less than 10 minutes.

## Evidence
- Container image digest
- Vulnerability report
- Registry metadata
- Build logs
