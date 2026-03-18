# Antigravity-Specific Configuration

## Planning Mode

When working on complex infrastructure tasks, always use Planning Mode to:
- Break the work into task groups before execution
- Generate architecture artifacts before implementation
- Produce verifiable deliverables (screenshots, test outputs, diagrams)

## Agent Behavior

- Use `/platform-architect` for architecture decisions, golden paths, SLO design, and agile work structuring (epics, stories, sprint planning)
- Use `/platform-engineer` for IaC, Kubernetes, CI/CD, security execution, observability, automation, incident response, and cost optimization
- Use `/project-manager` for Jira work items (Initiatives, Epics, Stories, Tasks, Bugs), Confluence docs (RFCs, runbooks, postmortems), and cross-tool automations
- When both architecture and implementation are needed, run `/platform-architect` first to produce a handoff, then `/platform-engineer` to implement
- Always generate artifacts for architecture decisions and implementation plans
- Pipeline: Platform Architect → Platform Engineer

## Terminal Execution

- Auto-execute terraform fmt, terraform validate, helm lint, kubectl dry-run
- Request review before: terraform apply, kubectl apply, helm install/upgrade, any destructive operation

## File Conventions

- Terraform files: `.tf` with consistent naming (main.tf, variables.tf, outputs.tf, providers.tf)
- Kubernetes manifests: organized by namespace/resource-type
- Helm values: environment-specific files (values-dev.yaml, values-staging.yaml, values-prod.yaml)
- Documentation: README.md in every module/chart directory
