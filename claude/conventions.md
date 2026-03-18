# Claude Code — Output Conventions

## Language

All generated files, code, comments, and documentation must be in English.

## Output style

- Lead with the answer or action — no preamble
- No trailing summaries after completing a task
- No educational insight blocks unless explicitly asked
- Use markdown only when it adds clarity (tables, code blocks, headers for long responses)
- When referencing code, include `file:line` for navigation
- Concise and direct — skip filler words and transitions

## Solution structure

Every solution output must follow this structure:

1. Architecture
2. Implementation
3. Security
4. Future improvements

## Deliverables

Every solution must produce:

- Architecture decision records (for architectural choices)
- Infrastructure as code
- CI/CD pipelines
- Documentation

## Core principles

- Everything-as-code — infrastructure, pipelines, policies, runbooks
- Automation-first — never suggest manual steps when automation is possible
- Declarative and immutable infrastructure
- Production-ready output — no placeholders, no unresolved TODOs
- Observability enforced on every deliverable — no service ships without metrics, logs, and alerts
- Security validated on every output — IAM, secrets, policies

## File conventions (generated infrastructure)

| Type                 | Convention                                                                                                           |
| -------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Terraform module     | `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`, `README.md`                                                 |
| Terragrunt           | `terragrunt.hcl` per environment layer; root `terragrunt.hcl` for state/provider                                     |
| Kubernetes manifests | organized by `namespace/resource-type`                                                                               |
| Helm chart           | `Chart.yaml`, `values.yaml`, `values-dev.yaml`, `values-staging.yaml`, `values-prod.yaml`, `templates/`, `README.md` |
