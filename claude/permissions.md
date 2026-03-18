# Claude Code — Permissions & Execution Policy

## Auto-execute (no confirmation required)

- `terraform fmt`
- `terraform validate`
- `helm lint`
- `kubectl apply --dry-run=client`
- `kubectl diff`

## Require review before executing

- `terraform apply`
- `terraform destroy`
- Any change to remote state config
- `kubectl apply` (production)
- `helm upgrade` / `helm install` (production)
- Any namespace creation or deletion
- Any RBAC or NetworkPolicy change
- Any IAM binding change in production
- Changes to production deployment workflows
- Changes to ArgoCD app definitions
- Any destructive operation

## Planning Mode

Use Planning Mode for complex infrastructure tasks: break work into task groups, generate architecture artifacts, and produce verifiable deliverables before implementation.

## Git

- Do not add Co-Authored-By lines to commit messages.
