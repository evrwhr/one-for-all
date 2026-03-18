# Antigravity

A specification and configuration framework for AI agents that autonomously design, build, and operate cloud platforms.

No application code — only Markdown specifications, agent definitions, skills, and workflows used to guide AI agents across any project.

## What it does

Antigravity gives AI assistants (Claude Code, Gemini CLI, Cursor) a shared identity, consistent rules, and a structured workflow for platform engineering tasks.

## Usage

### Skills (`/skill-name`)

Skills activate a specialized agent context in Claude Code. Type `/skill-name` and the agent assumes that role.

```
/platform-architect
Design the architecture for a new Go payment service on GKE. Include SLOs and golden path.
```

```
/platform-engineer
Create a Terraform module for a GCS bucket with versioning, lifecycle policy, and cost labels.
```

```
/project-manager
Create a Jira epic to migrate Redis to GCP Memorystore. Break it into stories.
```

### When to use each skill

| Task | Skill |
|------|-------|
| Architecture design, tech decisions, golden paths | `/platform-architect` |
| Terraform, Kubernetes, Helm, CI/CD | `/platform-engineer` |
| IAM, secrets, OPA/Kyverno policies | `/platform-engineer` |
| SLO dashboards, alerts, tracing | `/platform-engineer` |
| Self-healing, runbook automation | `/platform-engineer` |
| Active incident, postmortem | `/platform-engineer` |
| Cost analysis, right-sizing | `/platform-engineer` |
| Jira items (Initiatives, Epics, Stories, Tasks, Bugs) | `/project-manager` |
| Confluence docs (RFCs, runbooks, postmortems, status updates) | `/project-manager` |
| Jira/Confluence/Slack automations | `/project-manager` |
| Full end-to-end delivery | `/platform-architect` then `/platform-engineer` |

### Engineering cycle

```
Platform Architect  →  Platform Engineer
```

Architect produces: architecture, ADRs, SLO specs, security design, handoff document.
Engineer consumes handoff and produces: IaC, manifests, pipelines, dashboards, runbooks, automation.

---

## Repository structure

```
one-for-all/
├── CLAUDE.md                                    # Claude Code global config (inline rules)
├── AGENTS.md                                    # Cross-tool rules (Cursor, Gemini, etc.)
├── GEMINI.md                                    # Gemini CLI config
├── antigravity/                                 # Agent definitions and workflows (repo only)
│   ├── agents/
│   │   ├── platform-architect.md
│   │   ├── platform-engineer.md
│   │   └── project-manager.md
│   └── workflows/
│       └── engineering-cycle.md
├── claude/                                      # Claude Code specific
│   ├── conventions.md                           # Output style, file conventions (source of truth)
│   ├── permissions.md                           # Execution policy (source of truth)
│   └── skills/                                  # Skills → installed to ~/.claude/skills/
│       ├── platform-architect/SKILL.md
│       ├── platform-engineer/SKILL.md
│       └── project-manager/SKILL.md
├── scripts/
│   ├── install-global.sh                        # Install globally (~/.claude/ and ~/.gemini/)
│   └── init-project.sh                          # Bootstrap Antigravity in a target project
└── .github/
    └── pull_request_template.md
```

### What lives where

| Location | What | Read by |
|----------|------|---------|
| `~/.claude/CLAUDE.md` | Global rules, conventions, stack, execution policy | Claude Code (automatic) |
| `~/.claude/skills/<name>/SKILL.md` | Skills invocable with `/name` | Claude Code (automatic) |
| `~/.gemini/GEMINI.md` | Gemini CLI config | Gemini CLI (automatic) |
| `<project>/AGENTS.md` | Cross-tool agent rules | Cursor, Claude Code, Gemini |
| `<project>/GEMINI.md` | Project-level Gemini config | Gemini CLI |
| `antigravity/` | Agent specs and workflows | Humans (reference only) |
| `claude/conventions.md`, `claude/permissions.md` | Source of truth for rules merged into CLAUDE.md | Humans (reference only) |

---

## Setup

### Install globally

```bash
git clone git@github.com:evrwhr/one-for-all.git
./one-for-all/scripts/install-global.sh
```

Installs:
- `CLAUDE.md` → `~/.claude/CLAUDE.md`
- `claude/skills/*` → `~/.claude/skills/`
- `GEMINI.md` → `~/.gemini/GEMINI.md`

### Bootstrap a target project

```bash
./scripts/init-project.sh [target-directory]
```

Copies `AGENTS.md` and `GEMINI.md` into the target directory.

### Global config paths

| Tool | Global config | Skills |
|------|--------------|--------|
| Claude Code | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |
| Gemini CLI | `~/.gemini/GEMINI.md` | — |

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
