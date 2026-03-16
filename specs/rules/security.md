domain: security

capabilities:
  - IAM design (least privilege)
  - secrets management
  - policy as code
  - supply chain security
  - zero trust architecture
  - automated security scans
  - compliance enforcement
  - threat modeling

stack:
  policy: opa | kyverno
  scanning: trivy | falco
  secrets: vault | sealed-secrets

rules:
  - least privilege by default — no wildcard IAM permissions
  - all secrets managed by Vault or GCP Secret Manager — never in git
  - policy as code enforced via OPA (gatekeeper) and Kyverno
  - supply chain: all images signed and verified before admission
  - zero trust: no implicit trust between services — mTLS required in mesh
  - automated security scans on every PR: trivy (containers), sast (code)
  - runtime threat detection via Falco — alerts routed to incident channel
  - compliance policies enforced at admission time — block non-compliant resources
  - service accounts must be workload-identity bound — no long-lived keys
  - all external-facing endpoints behind WAF and rate limiting

iam_rules:
  - one service account per workload
  - no service account key files — use workload identity federation
  - IAM bindings managed via Terraform only
  - privilege escalation paths must be reviewed in security audit

secrets_rules:
  - rotation policy mandatory for all secrets
  - sealed-secrets for GitOps-managed secrets in cluster
  - audit log enabled on all secret access

review_checklist:
  - no credentials in code or config files
  - IAM roles scoped to minimum required permissions
  - network exposure minimized
  - Kyverno/OPA policies cover the new resource type
  - Falco rules updated if new runtime behavior introduced

require_review:
  - any IAM binding change in production
  - new service account creation
  - policy exception requests
  - changes to admission webhooks
