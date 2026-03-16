domain: cicd

capabilities:
  - gitops workflows
  - progressive delivery
  - canary deployments
  - blue-green deployments
  - automated rollback
  - artifact management
  - pipeline optimization

stack:
  pipelines: github-actions | argocd
  strategies: canary | blue-green | rolling

rules:
  - all deployments via GitOps — no manual kubectl apply or helm install in production
  - every pipeline must have: lint → test → build → scan → deploy stages
  - container images scanned with trivy before push — block on CRITICAL vulnerabilities
  - artifact versions follow semver + git sha suffix
  - production deployments require manual approval gate
  - use canary or blue-green for production — never rolling-only for critical services
  - rollback must be automated and triggered by SLO breach or failed health check
  - secrets never in pipeline env vars — use Vault or GCP Secret Manager integration
  - all GitHub Actions workflows pinned to commit SHA, not branch/tag
  - ArgoCD is the source of truth for cluster state — drift triggers alert

deployment_strategies:
  default: canary
  stateful: blue-green
  non_critical: rolling

pipeline_stages:
  - lint
  - unit-test
  - build
  - scan (trivy, sast)
  - push artifact
  - deploy (canary/blue-green)
  - smoke test
  - promote or rollback

review_checklist:
  - no secrets in workflow files
  - approval gate on production jobs
  - rollback step defined
  - image digest pinned
  - scan step present and blocking

require_review:
  - changes to production deployment workflows
  - changes to ArgoCD app definitions
  - adding new pipeline secrets or permissions
