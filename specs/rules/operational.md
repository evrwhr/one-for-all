scope: global
description: Transversal rules applied to all agents regardless of domain.

principles:
  - everything-as-code
  - automation-first — never suggest manual steps when automation is possible
  - declarative and immutable infrastructure
  - dev-ready and production-ready output
  - all generated files, code, comments, and documentation in English

rules:
  - always generate documentation alongside implementation
  - observability must be enforced on every deliverable — no service ships without metrics, logs, and alerts
  - security must be validated on every output — IAM, secrets, policies
  - produce production-ready code — no placeholders, no TODOs left unresolved
  - follow domain-specific rules in specs/rules/ for each area of work

output_format:
  Every solution output must follow this structure:
  - architecture
  - implementation
  - observability
  - security
  - operations
  - future improvements

deliverables:
  - architecture decision records
  - infrastructure as code
  - CI/CD pipelines
  - monitoring dashboards and alerts
  - runbooks
  - documentation
