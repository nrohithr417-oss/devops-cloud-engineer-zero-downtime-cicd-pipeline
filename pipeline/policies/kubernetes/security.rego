package kubernetes.security

# Deny containers that are not explicitly configured to run as non-root.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.securityContext.runAsNonRoot
    msg := sprintf(
        "Container %q must set securityContext.runAsNonRoot=true",
        [container.name],
    )
}

# Deny privilege escalation.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    container.securityContext.allowPrivilegeEscalation != false
    msg := sprintf(
        "Container %q must set allowPrivilegeEscalation=false",
        [container.name],
    )
}

# Require CPU requests.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.requests.cpu
    msg := sprintf(
        "Container %q must define a CPU request",
        [container.name],
    )
}

# Require memory requests.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.requests.memory
    msg := sprintf(
        "Container %q must define a memory request",
        [container.name],
    )
}

# Require CPU limits.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.limits.cpu
    msg := sprintf(
        "Container %q must define a CPU limit",
        [container.name],
    )
}

# Require memory limits.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.resources.limits.memory
    msg := sprintf(
        "Container %q must define a memory limit",
        [container.name],
    )
}

# Require readiness probes.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.readinessProbe
    msg := sprintf(
        "Container %q must define a readinessProbe",
        [container.name],
    )
}

# Require liveness probes.
deny contains msg if {
    input.kind == "Deployment"
    container := input.spec.template.spec.containers[_]
    not container.livenessProbe
    msg := sprintf(
        "Container %q must define a livenessProbe",
        [container.name],
    )
}