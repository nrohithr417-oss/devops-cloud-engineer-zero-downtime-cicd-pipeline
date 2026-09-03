# Stage 3 - Static Security & Dependency Scanning

## Purpose
Detect vulnerable source code, insecure dependencies, licensing risks, and software supply-chain issues.

## Tools
- GitHub Actions
- SAST scanner
- Dependency scanner
- SBOM generation
- Container security tooling

## Configuration
Security checks include:
- Static Application Security Testing
- Dependency vulnerability scanning
- Licence validation
- SBOM generation

## Thresholds
- Critical vulnerabilities: 0
- High vulnerabilities: 0 unless approved exception exists
- Prohibited licences: 0
- Missing SBOM: fail

## Failure & Remediation
Critical or high-risk findings block promotion.
Developer upgrades, patches, removes or formally accepts the affected component through the compliance exception workflow.

## Retry / Skip Logic
- Scanner infrastructure failures may retry once
- Critical security gates cannot be manually skipped without approved exception evidence

## SLA Target
Target execution time: less than 15 minutes.

## Evidence
- Security scanner reports
- Dependency reports
- SBOM
- Exception approval record
