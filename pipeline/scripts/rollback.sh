#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="${NAMESPACE:-novapay}"
ROLLOUT_NAME="${ROLLOUT_NAME:-novapay}"
DEPLOYMENT_NAME="${DEPLOYMENT_NAME:-novapay}"
ROLLBACK_CATEGORY="${ROLLBACK_CATEGORY:-B}"
REASON="${REASON:-unspecified}"
TIMESTAMP="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

echo "============================================"
echo "NovaPay Automated Rollback"
echo "Timestamp : ${TIMESTAMP}"
echo "Category  : ${ROLLBACK_CATEGORY}"
echo "Reason    : ${REASON}"
echo "Namespace : ${NAMESPACE}"
echo "============================================"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

verify_health() {
  echo "Verifying application health..."

  kubectl wait \
    --for=condition=Ready pod \
    -l app.kubernetes.io/name=novapay \
    -n "${NAMESPACE}" \
    --timeout=120s

  echo "Application pods are Ready."
}

rollback_argo_rollout() {
  echo "Attempting Argo Rollouts rollback..."

  if ! command_exists kubectl; then
    echo "ERROR: kubectl is required."
    exit 1
  fi

  if kubectl argo rollouts version >/dev/null 2>&1; then
    kubectl argo rollouts undo "${ROLLOUT_NAME}" \
      -n "${NAMESPACE}"

    kubectl argo rollouts status "${ROLLOUT_NAME}" \
      -n "${NAMESPACE}" \
      --timeout 180s
  else
    echo "Argo Rollouts plugin not available."
    return 1
  fi
}

rollback_kubernetes_deployment() {
  echo "Falling back to Kubernetes Deployment rollback..."

  kubectl rollout undo deployment/"${DEPLOYMENT_NAME}" \
    -n "${NAMESPACE}"

  kubectl rollout status deployment/"${DEPLOYMENT_NAME}" \
    -n "${NAMESPACE}" \
    --timeout=180s
}

case "${ROLLBACK_CATEGORY}" in
  A)
    echo "Category A: Immediate automated rollback (<60 seconds target)."

    if ! rollback_argo_rollout; then
      rollback_kubernetes_deployment
    fi
    ;;

  B)
    echo "Category B: Automated rollback within 15 minutes."

    if ! rollback_argo_rollout; then
      rollback_kubernetes_deployment
    fi
    ;;

  C)
    echo "Category C requires manual engineering approval."
    echo "No automatic rollback executed."
    exit 2
    ;;

  *)
    echo "ERROR: Unknown rollback category: ${ROLLBACK_CATEGORY}"
    exit 1
    ;;
esac

verify_health

echo "Running post-rollback verification..."

kubectl get pods \
  -n "${NAMESPACE}" \
  -l app.kubernetes.io/name=novapay

kubectl get services \
  -n "${NAMESPACE}"

echo "Rollback completed successfully."
echo "Timestamp: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"