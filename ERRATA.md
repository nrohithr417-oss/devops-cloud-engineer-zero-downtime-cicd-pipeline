# ERRATA - Deliberate Error Findings

This document records the three deliberate errors identified in the NovaPay Zero-Downtime CI/CD Pipeline Assessment.

The assessment states that exactly three deliberate technical errors are present: one in Part A, one in Part C, and one in Part D. :contentReference[oaicite:1]{index=1}

---

## Error 1 - Part A: Incorrect RBI Section Mapping

### Location

Part A - Section A4: Compliance & Regulatory Framework.

### Error

The assessment maps RBI sections such as:

- Section 4.2 → Change management
- Section 4.3 → Segregation of duties
- Section 5.1 → Vulnerability assessment
- Section 5.4 → Encryption
- Section 6.1 → Audit trails
- Section 6.3 → Incident management
- Section 7.2 → Third-party risk management

The document presents these as specific section references of the RBI Master Direction. :contentReference[oaicite:2]{index=2}

### Why This Is Incorrect

The official RBI Master Direction on Information Technology Governance, Risk, Controls and Assurance Practices, 2023 does not organize these controls using the section numbering shown above.

For example, the official RBI document identifies:

- Section 4 as IT Governance Framework
- Section 5 as Role of the Board of Directors
- Section 6 as IT Strategy Committee of the Board
- Section 7 as Senior Management and IT Steering Committee

Therefore, references such as "4.2 Change Management" and "5.1 Vulnerability Assessment" should not be treated as literal RBI section numbers.

### Correction

NovaPay should map CI/CD controls to the actual applicable provisions of the RBI Master Direction after reviewing the official RBI document.

The repository should avoid claiming unsupported regulatory section numbers.

A safer representation is:

```text
RBI IT Governance / Risk Control Area
        ↓
Relevant NovaPay CI/CD Control
        ↓
Supporting Audit Evidence