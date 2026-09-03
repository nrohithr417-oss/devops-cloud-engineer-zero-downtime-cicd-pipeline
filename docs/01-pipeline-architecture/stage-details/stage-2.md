# Stage 2 - Unit & Integration Testing

## Purpose
Validate application functionality before security and deployment stages.

## Tools
- pytest 8.x
- FastAPI TestClient
- GitHub Actions

## Configuration
Tests include:
- Unit tests
- API health tests
- Payment API tests
- Integration tests
- Contract tests

Command:
python -m pytest -v

## Thresholds
- Mandatory tests passed: 100%
- Failed critical tests: 0
- Minimum expected functional pass rate: 100%

## Failure & Remediation
Pipeline stops if any mandatory test fails.
Developer must correct the defect and submit a new commit.

## Retry / Skip Logic
- Test retry only for identified flaky infrastructure failures
- Functional test failures cannot be skipped

## SLA Target
Target execution time: less than 10 minutes.

## Evidence
- pytest execution logs
- Test count
- Pass/fail results
- GitHub Actions test logs
