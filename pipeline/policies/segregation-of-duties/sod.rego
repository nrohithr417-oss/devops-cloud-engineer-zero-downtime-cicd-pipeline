package segregation_of_duties

# Production requester and approver must be different people.
deny contains msg if {
    input.environment == "production"
    input.requester == input.approver
    msg := "SoD violation: production requester cannot approve their own deployment"
}

# Production deployments require an approval.
deny contains msg if {
    input.environment == "production"
    not input.approval.approved
    msg := "SoD violation: production deployment requires approval"
}

# Direct user deployments to production are prohibited.
deny contains msg if {
    input.environment == "production"
    input.deployment_actor.type == "user"
    msg := "SoD violation: direct user deployment to production is prohibited"
}

# Production deployment must use an approved service account.
deny contains msg if {
    input.environment == "production"
    not input.deployment_actor.service_account
    msg := "SoD violation: production deployment must use a controlled service account"
}

# At least one approver is required for production.
deny contains msg if {
    input.environment == "production"
    count(input.approvers) < 1
    msg := "SoD violation: production deployment requires at least one approver"
}

# Emergency changes require a tracked emergency-change ticket.
deny contains msg if {
    input.environment == "production"
    input.change_type == "emergency"
    not input.emergency_change.ticket_id
    msg := "SoD violation: emergency production change requires a tracked ticket"
}