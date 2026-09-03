package pci_dss.security_gates

deny contains msg if {
    input.sast.critical_vulnerabilities > 0
    msg := sprintf(
        "PCI-DSS gate failed: %v critical SAST vulnerabilities detected",
        [input.sast.critical_vulnerabilities],
    )
}

deny contains msg if {
    input.dependency_scan.critical_vulnerabilities > 0
    msg := sprintf(
        "PCI-DSS gate failed: %v critical dependency vulnerabilities detected",
        [input.dependency_scan.critical_vulnerabilities],
    )
}

deny contains msg if {
    input.container_scan.critical_vulnerabilities > 0
    msg := sprintf(
        "PCI-DSS gate failed: %v critical container vulnerabilities detected",
        [input.container_scan.critical_vulnerabilities],
    )
}

deny contains msg if {
    input.dast.high_findings > 0
    msg := sprintf(
        "PCI-DSS gate failed: %v high-severity DAST findings detected",
        [input.dast.high_findings],
    )
}

deny contains msg if {
    input.environment == "production"
    not input.approval.approved
    msg := "PCI-DSS gate failed: production deployment requires approval"
}

deny contains msg if {
    input.environment == "production"
    not input.audit_logging.enabled
    msg := "PCI-DSS gate failed: audit logging must be enabled for production"
}