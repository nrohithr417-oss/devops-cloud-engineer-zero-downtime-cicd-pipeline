# Stage 1 - Source & Build

## Purpose
Validate source code, install dependencies, build the NovaPay application, and generate a reproducible artifact.

## Tools
- GitHub Actions
- Python 3.12
- pip
- Docker 29.x

## Configuration
- Trigger: Pull Request and push to main
- Python dependency file: application/requirements.txt
- Dockerfile: docker/Dockerfile
- Artifact naming: novapay-payment-api:<commit-sha>

## Thresholds
- Build success rate: 100%
- Dependency installation failures: 0
- Docker build failures: 0

## Failure & Remediation
If dependency installation fails, verify requirements.txt and package versions.
If Docker build fails, validate Dockerfile paths, image base and application files.

## Retry / Skip Logic
- Automatic retry: 1 retry for transient dependency/network failures
- Build stage cannot be skipped for production releases

## SLA Target
Target execution time: less than 10 minutes.

## Evidence
- GitHub Actions logs
- Docker image build logs
- Commit SHA
