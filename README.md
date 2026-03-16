# Antigravity

A specification and configuration framework for a multi-agent AI system that autonomously designs, builds, and operates cloud platforms.

This repository contains no application code — only Markdown specifications, agent definitions, domain rules, and workflows used to guide AI agents across any project.

## What it does

Antigravity gives AI assistants (Claude Code, Gemini CLI, Cursor) a shared identity, consistent rules, and a structured workflow for platform engineering tasks. Once bootstrapped in a project, agents behave as specialized engineers operating in a defined pipeline.

## Repository structure

```
one-for-all/
├── AGENTS.md                   # Cross-tool agent rules (Cursor, Claude Code, Gemini)
├── CLAUDE.md                   # Claude Code project rules
├── GEMINI.md                   # Gemini CLI project rules
├── scripts/
│   └── init-project.sh         # Bootstrap Antigravity in any target project
└── specs/
    ├── agents/                 # One file per specialized agent
    ├── rules/                  # Domain-specific rules and checklists
    ├── prompts/                # Reusable prompts per role
    ├── workflows/              # Multi-agent workflow definitions
    └── system.md               # System-wide configuration
```

## Agents

| Agent | Responsibility |
|-------|---------------|
| Platform Architect | System design and architecture decisions |
| Infrastructure Engineer | IaC implementation (Terraform/Terragrunt) |
| Security Engineer | IAM, policies, secrets validation |
| SRE Engineer | Reliability, SLOs, error budgets |
| Observability Engineer | Metrics, logs, tracing setup |
| Automation Engineer | Self-healing systems, event-driven automation |
| FinOps Engineer | Cost analysis and optimization |
| Incident Commander | Incident response and postmortems |
| Agile Scrum Master | Jira work structuring |

## Engineering cycle

```
architect → implement → security review → SRE review →
observability → automation → finops → docs → continuous improvement
```

## Bootstrap a project

Copy Antigravity config into any target project:

```bash
./scripts/init-project.sh [target-directory]
```

This copies `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` into the target directory, making agent rules available to all supported IDEs.

## Global installation

To apply Antigravity rules globally (outside any specific project):

| Tool | Global config path |
|------|--------------------|
| Claude Code | `~/.claude/CLAUDE.md` |
| Gemini CLI | `~/.gemini/GEMINI.md` |

## Technology stack

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
