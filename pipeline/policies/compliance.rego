package main

deny contains msg if {
    input.controls.rbi.secure_cicd != true
    msg := "RBI control failed: secure CI/CD must be enabled"
}

deny contains msg if {
    input.controls.rbi.vulnerability_scanning != true
    msg := "RBI control failed: vulnerability scanning must be enabled"
}

deny contains msg if {
    input.controls.rbi.change_management != true
    msg := "RBI control failed: change management must be enabled"
}

deny contains msg if {
    input.controls.rbi.audit_logging != true
    msg := "RBI control failed: audit logging must be enabled"
}

deny contains msg if {
    input.controls.pci_dss.secure_software_development != true
    msg := "PCI-DSS control failed: secure software development is required"
}

deny contains msg if {
    input.controls.pci_dss.vulnerability_management != true
    msg := "PCI-DSS control failed: vulnerability management is required"
}

deny contains msg if {
    input.controls.pci_dss.access_control != true
    msg := "PCI-DSS control failed: access control is required"
}

deny contains msg if {
    input.controls.pci_dss.security_testing != true
    msg := "PCI-DSS control failed: security testing is required"
}

deny contains msg if {
    input.controls.segregation_of_duties.developer_cannot_self_approve != true
    msg := "SoD control failed: developers must not self-approve production changes"
}

deny contains msg if {
    input.controls.segregation_of_duties.production_requires_approval != true
    msg := "SoD control failed: production deployment requires approval"
}

deny contains msg if {
    input.controls.segregation_of_duties.deployment_uses_service_account != true
    msg := "SoD control failed: deployments must use a service account"
}

deny contains msg if {
    input.controls.segregation_of_duties.no_direct_production_access != true
    msg := "SoD control failed: direct production access is prohibited"
}