# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repository Is

**Antigravity** — a specification and configuration framework for a multi-agent AI system that autonomously designs, builds, and operates cloud platforms. This repo contains no application code; it is a collection of Markdown specifications, agent definitions, and domain knowledge files used to guide AI agents.

## Project Initialization

To bootstrap Antigravity in a target project:

```bash
./scripts/init-project.sh [target-directory]
```

This copies `GEMINI.md` and `AGENTS.md` into the target directory, making those agent rules available to IDEs (Cursor, Claude Code, etc.) in that project.

## Core Agent Identity & Rules

All agents in this system follow `AGENTS.md`:

- **Everything-as-code** — infrastructure, pipelines, policies, runbooks
- **Automation-first** — never suggest manual steps when automation is possible
- **Declarative and immutable infrastructure**
- All generated files, code, comments, and documentation must be in **English**

Every solution output must follow this structure: **Architecture → Implementation → Observability → Security → Operations → Future improvements**

## Technology Stack

| Domain | Tools |
|--------|-------|
| IaC | Terraform, Terragrunt |
| Containers | Kubernetes, Helm, Docker |
| Cloud | GCP |
| CI/CD | GitHub Actions, ArgoCD |
| Observability | Prometheus, Grafana, OpenTelemetry, Sentry |
| Platform | Backstage |
| Languages | Python, Go, Bash, YAML |
| Security | OPA, Kyverno, Trivy, Falco, Vault |

## Multi-Agent Architecture

Nine specialized agents operate in a defined pipeline (see `specs/agents/`):

1. **Platform Architect** — system design and architecture decisions
2. **Infrastructure Engineer** — IaC implementation (Terraform/Terragrunt)
3. **Security Engineer** — IAM, policies, secrets validation
4. **SRE Engineer** — reliability, SLOs, error budgets
5. **Observability Engineer** — metrics, logs, tracing setup
6. **Automation Engineer** — self-healing systems, event-driven automation
7. **FinOps Engineer** — cost analysis and optimization
8. **Incident Commander** — incident response and postmortems
9. **Agile Scrum Master** — Jira work structuring

The engineering cycle workflow (`specs/workflows/engineering-cycle.md`) sequences these agents: architect → implement → security review → SRE review → observability → automation → finops → docs → continuous improvement.

## File Conventions (for generated infrastructure)

- **Terraform**: `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf` per module
- **Kubernetes manifests**: organized by `namespace/resource-type`
- **Helm values**: `values-dev.yaml`, `values-staging.yaml`, `values-prod.yaml`
- **Every module/chart directory** should have a `README.md`

## Terminal Execution Policy

- **Auto-execute**: `terraform fmt`, `terraform validate`, `helm lint`, `kubectl dry-run`
- **Require review before**: `terraform apply`, `kubectl apply`, `helm install/upgrade`, any destructive operation

## Planning Mode

For complex infrastructure tasks, use Planning Mode to break work into task groups, generate architecture artifacts, and produce verifiable deliverables before implementation.

## Git
- Do not add Co-Authored-By lines to commit messages.
