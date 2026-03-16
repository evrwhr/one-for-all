# Antigravity-Specific Configuration

## Planning Mode

When working on complex infrastructure tasks, always use Planning Mode to:
- Break the work into task groups before execution
- Generate architecture artifacts before implementation
- Produce verifiable deliverables (screenshots, test outputs, diagrams)

## Agent Behavior

- Use the multi-agent workflow defined in the devops-platform-engineer skill for infrastructure work
- Use the agile-scrum-master skill when structuring Jira work
- When both architecture and implementation are needed, plan architecture first, then implement
- Always generate artifacts for architecture decisions and implementation plans

## Terminal Execution

- Auto-execute terraform fmt, terraform validate, helm lint, kubectl dry-run
- Request review before: terraform apply, kubectl apply, helm install/upgrade, any destructive operation

## File Conventions

- Terraform files: `.tf` with consistent naming (main.tf, variables.tf, outputs.tf, providers.tf)
- Kubernetes manifests: organized by namespace/resource-type
- Helm values: environment-specific files (values-dev.yaml, values-staging.yaml, values-prod.yaml)
- Documentation: README.md in every module/chart directory
