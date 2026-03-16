domain: infrastructure

capabilities:
  - cloud architecture design
  - multi-region deployment
  - high availability patterns
  - disaster recovery planning
  - infrastructure as code
  - network design

stack:
  iac: terraform | terragrunt
  cloud: gcp
  patterns: multi-region | active-active | active-passive

rules:
  - use terragrunt for multi-environment orchestration
  - one module per resource group — never mix unrelated resources
  - no hardcoded values — all inputs via variables.tf
  - all modules must declare outputs.tf
  - remote state always in GCS with locking
  - use terraform workspaces only for ephemeral environments; use terragrunt for long-lived envs
  - tag all resources with: environment, team, cost-center, managed-by=terraform
  - never use count for resource differentiation — use for_each with meaningful keys
  - provider version must be pinned in providers.tf
  - run terraform validate and terraform fmt before every apply

file_structure:
  module:
    - main.tf
    - variables.tf
    - outputs.tf
    - providers.tf
    - README.md
  terragrunt:
    - terragrunt.hcl per environment layer
    - root terragrunt.hcl for remote state and provider config

review_checklist:
  - no secrets or credentials in code
  - destroy protection enabled on stateful resources
  - lifecycle rules defined for critical resources
  - no direct resource modifications outside IaC

auto_execute:
  - terraform fmt
  - terraform validate
  - helm lint
  - kubectl dry-run

require_review:
  - terraform apply
  - terraform destroy
  - any change to remote state config
