# Antigravity

A specification and configuration framework for a multi-agent AI system that autonomously designs, builds, and operates cloud platforms.

This repository contains no application code — only Markdown specifications, agent definitions, domain rules, skills, and workflows used to guide AI agents across any project.

## What it does

Antigravity gives AI assistants (Claude Code, Gemini CLI, Cursor, Antigravity) a shared identity, consistent rules, and a structured workflow for platform engineering tasks. Once set up, agents behave as specialized engineers operating in a defined pipeline.

## Usage

### Skills (`/skill-name`)

Skills activate a specialized context in the conversation. Type `/skill-name` and the agent assumes that role with its rules and workflow.

Use skills for **focused, single-domain tasks** when you know which specialist you need:

```
/infrastructure-engineer
Create a Terraform module for a GCS bucket with versioning and lifecycle policy.
```

```
/sre-engineer
Define SLOs for the bookings API: p99 latency, availability, and error rate.
```

```
/incident-commander
We have checkout degradation since 14:00. p99 latency went from 200ms to 4s.
```

### Workflows (`specs/workflows/`)

Workflows define the **sequence of agents** for a type of task:

- `engineering-cycle.md` — full delivery cycle (architect → implement → security → SRE → observability → automation → finops)
- `agile-planning.md` — planning cycle (initiative → epics → stories → tasks)

Use the orchestrator skill for **end-to-end deliveries** that span multiple domains:

```
/devops-platform-engineer
Create a new Go microservice on GKE to process payments. Follow the full engineering cycle.
```

### Prompts (`specs/prompts/`)

Prompts are reusable templates for specific situations. Unlike skills (which configure the agent), prompts are **ready-made texts** you copy, adapt, and paste directly.

Use prompts when you need more control over the exact input, or when using a tool that does not support skills (Claude.ai web, ChatGPT, etc.).

### Agents (`specs/agents/`)

Agent files define each specialist: role, responsibilities, and stack. They are not invoked directly — they are the source of truth that feeds the skills and `AGENTS.md`.

Edit an agent file when you want to change the scope, responsibilities, or stack of a specialist. The change should be reflected in the corresponding skill.

### When to use each

| Situation | Use |
|-----------|-----|
| Focused task in a single domain | `/skill-name` |
| Full end-to-end delivery | `/devops-platform-engineer` + workflow |
| Sprint and epic planning | `/agile-scrum-master` |
| Tool without skill support | `specs/prompts/` |
| Change an agent's scope or stack | Edit `specs/agents/` + corresponding skill |
| Define a new multi-agent flow | Create in `specs/workflows/` |

---

## Repository structure

```
one-for-all/
├── AGENTS.md                        # Cross-tool agent rules (Cursor, Claude Code, Gemini)
├── CLAUDE.md                        # Claude Code project rules
├── GEMINI.md                        # Gemini CLI project rules
├── .github/
│   └── pull_request_template.md     # PR template with domain-aware checklists
├── scripts/
│   ├── init-project.sh              # Bootstrap Antigravity in any target project
│   └── setup-antigravity.sh         # Install skills and global configs locally
├── skills/                          # Antigravity skills (invoked with /skill-name)
│   ├── devops-platform-engineer/    # Orchestrator: full engineering cycle
│   ├── platform-architect/          # Architecture design and technology decisions
│   ├── infrastructure-engineer/     # Terraform, Kubernetes, Helm, CI/CD
│   ├── security-engineer/           # IAM, secrets, OPA/Kyverno, Trivy
│   ├── sre-engineer/                # SLOs, error budgets, postmortems
│   ├── observability-engineer/      # Prometheus, Grafana, OpenTelemetry, alerts
│   ├── automation-engineer/         # Self-healing, runbook automation, infra bots
│   ├── finops-engineer/             # Cost analysis, right-sizing, budget forecasting
│   ├── incident-commander/          # Incident response, triage, postmortems
│   └── agile-scrum-master/          # Jira, epics, sprint planning
└── specs/
    ├── agents/                      # Agent definitions (role, responsibilities, stack)
    ├── rules/                       # Domain-specific rules and checklists
    ├── prompts/                     # Reusable prompts per role
    ├── workflows/                   # Multi-agent workflow definitions
    └── system.md                    # System-wide configuration
```

## Skills

Skills are invoked with `/skill-name` in the Antigravity app. Use specialist skills for targeted tasks; use the orchestrator for end-to-end workflows.

| Skill | When to use |
|-------|-------------|
| `/devops-platform-engineer` | Full engineering cycle (orchestrator) |
| `/platform-architect` | Architecture design, tech decisions, golden paths |
| `/infrastructure-engineer` | Terraform, Kubernetes manifests, Helm, CI/CD pipelines |
| `/security-engineer` | IAM review, secrets management, OPA/Kyverno policies |
| `/sre-engineer` | SLOs, error budgets, reliability review, postmortems |
| `/observability-engineer` | Metrics, dashboards, tracing, alerting |
| `/automation-engineer` | Self-healing systems, runbook automation, infra bots |
| `/finops-engineer` | GCP cost analysis, right-sizing, autoscaling optimization |
| `/incident-commander` | Active incidents, severity triage, postmortems |
| `/agile-scrum-master` | Jira structuring, epics, user stories, sprint planning |

## Engineering cycle

```
platform-architect → infrastructure-engineer → security-engineer → sre-engineer →
observability-engineer → automation-engineer → finops-engineer → docs → continuous improvement
```

## Setup

### Local environment (Antigravity skills + global configs)

```bash
git clone git@github.com:evrwhr/one-for-all.git
./one-for-all/scripts/setup-antigravity.sh
```

Installs all skills into `~/.gemini/antigravity/skills/` and copies `GEMINI.md` and `CLAUDE.md` to their global paths.

### Bootstrap a target project

Copy Antigravity config into any project repository:

```bash
./scripts/init-project.sh [target-directory]
```

Copies `AGENTS.md`, `CLAUDE.md`, and `GEMINI.md` into the target directory, making agent rules available to all supported IDEs.

### Global config paths

| Tool | Global config path |
|------|--------------------|
| Claude Code | `~/.claude/CLAUDE.md` |
| Gemini CLI | `~/.gemini/GEMINI.md` |

## Domain rules

Rules in `specs/rules/` define how each agent must behave within its domain:

| Rule file | Domain |
|-----------|--------|
| `operational.md` | Cross-cutting rules (applies to all agents) |
| `infrastructure.md` | Cloud architecture, IaC, GCP provisioning |
| `kubernetes.md` | Cluster lifecycle, workloads, Helm, networking |
| `cicd.md` | GitHub Actions, ArgoCD, GitOps, pipeline standards |
| `security.md` | IAM, secrets, policy as code, supply chain |
| `observability.md` | Metrics, logs, tracing, alerting |
| `reliability.md` | SLOs, error budgets, incident response, resilience |
| `automation.md` | Self-healing, event-driven automation, runbooks |
| `cost.md` | Cost allocation, right-sizing, autoscaling, waste |
| `platform.md` | Backstage, golden paths, developer experience |
| `agile.md` | Jira, sprint planning, story refinement |

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
