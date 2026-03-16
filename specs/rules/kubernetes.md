domain: kubernetes

capabilities:
  - cluster lifecycle management
  - autoscaling (HPA, VPA, cluster autoscaler)
  - service mesh
  - custom operators and CRDs
  - helm chart development
  - resource optimization
  - multi-tenancy

stack:
  core: kubernetes | helm | docker
  mesh: istio | linkerd

rules:
  - never use default namespace for workloads
  - all workloads must define resource requests and limits
  - all workloads must define liveness and readiness probes
  - use HPA for stateless services; VPA for batch/stateful workloads
  - images must be pinned to digest or immutable tag — never use :latest
  - no privileged containers; no root unless explicitly justified
  - all sensitive config via Secrets — never in ConfigMaps or env literals
  - network policies must be defined per namespace (default-deny baseline)
  - use PodDisruptionBudgets for critical services
  - helm values split by environment: values-dev.yaml, values-staging.yaml, values-prod.yaml

manifest_structure:
  namespace:
    - resource organized by: namespace/resource-type
  helm:
    - Chart.yaml
    - values.yaml
    - values-dev.yaml
    - values-staging.yaml
    - values-prod.yaml
    - templates/
    - README.md

review_checklist:
  - resource limits set
  - probes configured
  - no latest image tag
  - security context defined
  - PDB present for critical workloads
  - network policy applied

auto_execute:
  - helm lint
  - kubectl apply --dry-run=client
  - kubectl diff

require_review:
  - kubectl apply (production)
  - helm upgrade (production)
  - any change to RBAC or NetworkPolicy
  - namespace creation or deletion
