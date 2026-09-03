# NovaPay Incident Communication Templates

## 1. Purpose

This document defines standard communication templates for NovaPay production incidents.

The objective is to ensure incident communication is timely, consistent, accurate, auditable, and appropriate for engineering teams, management, customers, security teams, compliance teams, and regulatory stakeholders.

All incident communications must use the assigned incident ID and contain verified information only.

---

## 2. Communication Responsibilities

### Incident Commander

The Incident Commander is responsible for:

- Coordinating the overall incident response.
- Confirming incident severity.
- Approving major operational decisions.
- Ensuring communication deadlines are met.
- Coordinating escalation when required.

### Communications Lead

The Communications Lead is responsible for:

- Internal incident updates.
- Management communication.
- External status-page updates.
- Maintaining communication timestamps.
- Coordinating approved customer communication.

### Technical Lead

The Technical Lead provides:

- Technical investigation updates.
- Current mitigation status.
- Recovery information.
- Preliminary root-cause information.

### Compliance and Security Teams

Compliance and Security teams review communications involving:

- Security incidents.
- Customer data.
- Data integrity.
- Regulatory impact.
- PCI-DSS implications.
- RBI-related compliance requirements.

---

## 3. Incident Communication Cadence

| Severity | Definition | Initial Response | Update Frequency | Escalation |
|---|---|---|---|---|
| SEV-1 | Complete service outage or data integrity risk | < 5 minutes | Every 30 minutes | CTO + CISO + VP Engineering |
| SEV-2 | Major degradation affecting more than 10% of users | < 15 minutes | Every 60 minutes | VP Engineering + SRE Lead |
| SEV-3 | Minor degradation with a workaround | < 1 hour | On material change | SRE On-Call + Tech Lead |
| SEV-4 | Cosmetic issue with no customer impact | Next business day | Normal engineering workflow | Assigned Engineer |

---

## 4. SEV-1 Initial Internal Acknowledgement

Use immediately when a SEV-1 incident is declared.

```text
[SEV-1 INCIDENT DECLARED]

Incident ID: INC-XXXX
Time Detected: <timestamp>
Affected Service: <service name>
Environment: Production

Incident Severity:
SEV-1

Customer Impact:
<brief description of customer impact>

Business Impact:
<brief description of business impact>

Current Symptoms:
<observed symptoms>

Current Status:
Investigation and mitigation are in progress.

Incident Commander:
<name/role>

Technical Lead:
<name/role>

Communications Lead:
<name/role>

Escalation:
CTO + CISO + VP Engineering

Next Update:
Within 30 minutes.
```

---

## 5. SEV-2 Initial Internal Acknowledgement

```text
[SEV-2 INCIDENT DECLARED]

Incident ID: INC-XXXX
Time Detected: <timestamp>
Affected Service: <service name>
Environment: Production

Incident Severity:
SEV-2

Customer Impact:
Major degradation affecting more than 10% of users.

Current Symptoms:
<observed symptoms>

Current Status:
Engineering and SRE teams are investigating.

Incident Commander:
<name/role>

Technical Lead:
<name/role>

Escalation:
VP Engineering + SRE Lead

Next Update:
Within 60 minutes.
```

---

## 6. SEV-3 Initial Notification

```text
[SEV-3 INCIDENT]

Incident ID: INC-XXXX
Detected: <timestamp>
Affected Service: <service>

Impact:
Minor service degradation with an available workaround.

Current Status:
Investigation is in progress.

Owner:
SRE On-Call / Tech Lead

Workaround:
<workaround if available>

Next Update:
When a material change occurs.
```

---

## 7. SEV-4 Notification

```text
[SEV-4 ISSUE]

Issue ID: INC-XXXX
Detected: <timestamp>
Affected Component: <component>

Impact:
No customer impact.

Description:
<issue description>

Assigned Engineer:
<name/role>

Status:
Scheduled for normal engineering remediation.

Target:
Next business day.
```

---

## 8. Internal Slack / Incident Channel Template

Use this template when creating the dedicated incident communication channel.

```text
Incident: INC-XXXX
Severity: SEV-X
Service: NovaPay Payment API
Environment: Production

Detected:
<timestamp>

Symptoms:
<description>

Customer Impact:
<description>

Business Impact:
<description>

Current Action:
<investigation / mitigation / rollback / recovery>

Incident Commander:
<name/role>

Technical Lead:
<name/role>

Current Release:
<version>

Next Update:
<timestamp>
```

All important operational decisions must also be recorded in the incident timeline.

---

## 9. External Status Page - Initial Notification

Use this template when customers must be informed about service degradation.

```text
Investigating - NovaPay Service Degradation

We are currently investigating an issue affecting <service/function>.

Some customers may experience <brief impact description>.

Our engineering teams are actively investigating the issue and working to restore normal service.

We will provide another update as more information becomes available.
```

External communication must not contain:

- Credentials.
- Internal tokens.
- Customer-specific information.
- Sensitive architecture information.
- Unconfirmed root-cause information.
- Security details that could increase risk.

---

## 10. SEV-1 Progress Update

SEV-1 communication must be updated every 30 minutes until the incident is resolved.

```text
[SEV-1 INCIDENT UPDATE]

Incident ID: INC-XXXX
Time: <timestamp>
Affected Service: <service>

Current Customer Impact:
<customer impact>

Current Business Impact:
<business impact>

Current Status:
<investigating / mitigating / recovering>

Actions Completed:
- <action 1>
- <action 2>
- <action 3>

Current Action:
<current mitigation or investigation>

Deployment Status:
<active / frozen / rolled back>

Service Health:
<current metrics/status>

Payment Processing:
<healthy / degraded / unavailable>

Next Update:
Within 30 minutes.
```

---

## 11. SEV-2 Progress Update

SEV-2 communication must be updated every 60 minutes until resolution.

```text
[SEV-2 INCIDENT UPDATE]

Incident ID: INC-XXXX
Time: <timestamp>

Affected Service:
<service>

Current Impact:
<impact summary>

Investigation Status:
<summary>

Actions Completed:
- <action 1>
- <action 2>

Current Mitigation:
<actions being performed>

Current Service Health:
<summary>

Customer Impact:
<summary>

Next Update:
Within 60 minutes.
```

---

## 12. Management / Executive Update

Use this template for management and executive stakeholders.

```text
Subject: NovaPay Production Incident Update - INC-XXXX

Incident ID:
INC-XXXX

Severity:
SEV-X

Incident Start:
<timestamp>

Affected Service:
<service>

Business Impact:
<summary of affected customers and services>

Customer Impact:
<summary>

Current Status:
<investigating / mitigating / recovering / resolved>

Technical Summary:
<short high-level explanation>

Actions Taken:
- <action 1>
- <action 2>

Current Risk:
<high / medium / low>

Estimated Recovery:
<time or "under investigation">

Next Executive Update:
<timestamp>
```

Management communication should focus on customer impact, business risk, recovery status, and major decisions rather than unnecessary low-level technical details.

---

## 13. Security Incident Escalation

Use this template for suspected or confirmed security incidents.

```text
[SECURITY INCIDENT ESCALATION]

Incident ID:
INC-XXXX

Severity:
SEV-1

Detected:
<timestamp>

Affected Systems:
<systems>

Observed Security Event:
<high-level description>

Potential Customer Impact:
<description>

Potential Data Impact:
<description>

Data Integrity Risk:
<yes / no / under investigation>

Evidence Preserved:
Yes / No

Security Team Engaged:
Yes / No

CISO Notified:
Yes / No

Current Containment Action:
<description>

Current Status:
<status>

Next Update:
<timestamp>
```

Sensitive security information must only be distributed to authorised personnel.

Evidence must be preserved for security investigation and audit purposes.

---

## 14. Production Deployment Freeze Notification

Use when an active deployment is stopped because of an incident or failed quality gate.

```text
[PRODUCTION DEPLOYMENT FROZEN]

Incident ID:
INC-XXXX

Release:
<version>

Deployment Started:
<timestamp>

Deployment Frozen:
<timestamp>

Reason:
<alert / failed metric / security issue / customer impact>

Current Traffic:
<percentage>

Current Status:
Further production promotion has been stopped.

Current Action:
Engineering is evaluating rollback or remediation.

Next Update:
<timestamp>
```

---

## 15. Production Rollback Notification

```text
[PRODUCTION ROLLBACK INITIATED]

Incident ID:
INC-XXXX

Affected Service:
NovaPay Payment API

Failed Release Version:
<version>

Previous Stable Version:
<version>

Rollback Trigger:
<rollback trigger>

Rollback Started:
<timestamp>

Customer Impact:
<description>

Current Action:
Traffic is being restored to the last known good release.

Verification In Progress:
- Application health checks
- Readiness checks
- Payment transaction validation
- Error-rate monitoring
- Latency monitoring
- Kubernetes health validation

Next Update:
<timestamp>
```

---

## 16. Rollback Completion Notification

```text
[PRODUCTION ROLLBACK COMPLETED]

Incident ID:
INC-XXXX

Failed Release:
<version>

Restored Release:
<version>

Rollback Completed:
<timestamp>

Current Status:
Previous stable release has been restored.

Health Verification:
PASS / FAIL

Readiness Verification:
PASS / FAIL

Payment Validation:
PASS / FAIL

Error Rate:
<value/status>

Customer Impact:
<current status>

Enhanced Monitoring:
Active

Incident Status:
Recovering / Resolved
```

---

## 17. Service Recovery Notification

Use when primary functionality has been restored but enhanced monitoring continues.

```text
[SERVICE RECOVERY IN PROGRESS]

Incident ID:
INC-XXXX

Time:
<timestamp>

Service:
<service>

Status:
Primary service functionality has been restored.

Verification Completed:
- Health checks passing
- Readiness checks passing
- Error rate returning to baseline
- Payment processing validated
- Kubernetes pods healthy
- Database connectivity healthy
- Critical alerts cleared

Customer Impact:
No longer increasing.

Monitoring:
Enhanced production monitoring remains active.

Incident Status:
Recovering
```

---

## 18. Internal Resolution Notification

```text
[INCIDENT RESOLVED]

Incident ID:
INC-XXXX

Severity:
SEV-X

Incident Started:
<timestamp>

Incident Resolved:
<timestamp>

Total Duration:
<duration>

Affected Service:
<service>

Customer Impact:
<summary>

Business Impact:
<summary>

Resolution:
<description of what restored service>

Current Status:
Service is stable and monitoring confirms normal behaviour.

Root Cause:
<preliminary / confirmed>

Root Cause Summary:
<summary>

Follow-Up:
A postmortem and corrective-action review will be completed where required.

Postmortem Owner:
<name/role>
```

---

## 19. External Status Page - Recovery Update

```text
Monitoring - NovaPay Service Recovery

Service functionality has been restored following the earlier disruption affecting <service/function>.

Our engineering teams are monitoring system performance to confirm continued stability.

We will provide a final update once the incident is fully resolved.
```

---

## 20. External Status Page - Resolution

```text
Resolved - NovaPay Service Incident

The issue affecting <service/function> has been resolved.

Service has returned to normal operation and our teams have confirmed system stability.

We will continue routine monitoring.

We apologise for the disruption experienced by affected customers.
```

---

## 21. Postmortem Announcement

```text
Subject: Postmortem Review - INC-XXXX

Incident ID:
INC-XXXX

Severity:
SEV-X

Incident Date:
<date>

Incident Duration:
<duration>

Postmortem Review Date:
<date/time>

Summary:
<brief incident description>

The postmortem review will cover:

- Customer impact
- Business impact
- Incident timeline
- Detection effectiveness
- Root cause
- Contributing factors
- Mitigation and recovery
- What worked well
- What did not work well
- Pipeline control failures
- Corrective actions
- Preventive actions
- Assigned owners
- Target completion dates

Required Participants:
<teams/roles>

Postmortem Owner:
<name/role>
```

---

## 22. Regulatory / Compliance Communication Template

Use this template only when regulatory or compliance notification is required under NovaPay's approved procedures.

```text
Incident Reference:
INC-XXXX

Incident Date:
<date>

Incident Start:
<timestamp>

Incident Resolution:
<timestamp>

Affected Service:
<service>

Incident Classification:
<severity/type>

Impact Summary:
<approved factual summary>

Customer Impact:
<summary>

Data Integrity Impact:
<none / under investigation / confirmed>

Security Impact:
<none / under investigation / confirmed>

Detection Method:
<monitoring / security control / operational alert>

Containment Measures:
<summary>

Recovery Measures:
<summary>

Current Status:
<status>

Root Cause:
<confirmed information where available>

Corrective Actions:
<summary>

Preventive Actions:
<summary>

Prepared By:
<role>

Reviewed By:
<Compliance/Security role>

Approved By:
<authorised approver>

Timestamp:
<timestamp>
```

All regulatory communication must be reviewed and approved by authorised Compliance and Security personnel before external submission.

---

## 23. Technical Engineering Update

Use this template when engineering teams require detailed operational information.

```text
[TECHNICAL INCIDENT UPDATE]

Incident ID:
INC-XXXX

Severity:
SEV-X

Affected Component:
<component>

Current Release:
<version>

Last Known Good Release:
<version>

Observed Metrics:
- HTTP 5xx: <value>
- p95 latency: <value>
- p99 latency: <value>
- Payment success rate: <value>
- Pod restarts: <value>
- CPU: <value>
- Memory: <value>

Relevant Alerts:
<alerts>

Relevant Logs:
<summary/reference>

Actions Executed:
- <action>
- <action>

Current Hypothesis:
<hypothesis - clearly identify as unconfirmed>

Next Technical Action:
<action>

Owner:
<name/role>

Next Update:
<timestamp>
```

---

## 24. Customer Support Briefing

Use when the customer support team needs an approved incident summary.

```text
[CUSTOMER SUPPORT INCIDENT BRIEF]

Incident ID:
INC-XXXX

Affected Service:
<service>

Customer Impact:
<approved description>

Incident Status:
<investigating / recovering / resolved>

Customer Guidance:
<approved workaround or guidance>

What Support Should Communicate:
<approved customer-facing statement>

What Support Should Not Communicate:
- Unconfirmed root cause
- Internal security information
- Customer-specific data
- Internal credentials or infrastructure details

Next Update:
<timestamp>
```

---

## 25. Communication Rules

All NovaPay incident communications must follow these rules:

1. Use factual and verified information only.
2. Clearly distinguish confirmed facts from investigation hypotheses.
3. Use the same incident ID across all communication channels.
4. Record timestamps for all major updates.
5. Maintain the required severity-based update cadence.
6. Never expose credentials, secrets, API keys, tokens, or passwords.
7. Never expose sensitive customer information.
8. Do not publish unconfirmed root-cause statements externally.
9. Record major operational decisions.
10. Preserve incident communications as audit evidence.
11. Ensure regulatory communication receives appropriate approval.
12. Communicate customer impact clearly without unnecessary technical details.

---

## 26. Communication Decision Flow

```text
Incident Detected
       |
       v
Classify Severity
       |
       v
Create Incident ID
       |
       v
Internal Acknowledgement
       |
       v
Customer Impact?
    /       \
   NO       YES
   |         |
Internal   Status Page
Updates      |
   |         |
   +----+----+
        |
        v
Regular Severity-Based Updates
        |
        v
Security / Compliance Impact?
       / \
     YES  NO
      |    |
Escalate   |
      |    |
      +----+
        |
        v
Service Recovery
        |
        v
Resolution Notification
        |
        v
Postmortem Communication
```

---

## 27. Communication Evidence Requirements

The following evidence should be retained for significant production incidents:

- Incident declaration.
- Severity classification.
- Internal Slack or incident-channel messages.
- Management updates.
- Status-page updates.
- Security escalation messages where applicable.
- Compliance communication where applicable.
- Rollback notifications.
- Recovery notification.
- Resolution notification.
- Postmortem announcement.
- Communication timestamps.
- Approver identities where required.

These records provide traceability for operational review and compliance auditing.

---

## 28. Closure Communication Checklist

Before sending the final resolution communication, confirm:

- Service is stable.
- Customer impact has ended.
- Critical alerts are cleared.
- Health checks are passing.
- Payment processing is operating normally.
- Resolution timestamp is recorded.
- Incident severity is confirmed.
- Customer impact statement is accurate.
- Root-cause status is clearly identified as preliminary or confirmed.
- Required stakeholders have been informed.
- Follow-up actions have been created.
- Postmortem requirement has been determined.
- Regulatory or compliance follow-up has been identified where applicable.

---

## 29. Summary

These communication templates provide NovaPay with a consistent incident communication process across technical, management, customer, security, compliance, and regulatory audiences.

The templates support the complete incident lifecycle from initial acknowledgement through ongoing updates, rollback, service recovery, resolution, and postmortem review.