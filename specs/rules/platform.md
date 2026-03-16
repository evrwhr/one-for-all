domain: platform

capabilities:
  - internal developer platform design
  - self-service infrastructure
  - platform APIs
  - developer experience optimization
  - golden paths
  - service catalog
  - developer portal

stack:
  portal: backstage

rules:
  - every new service must be registered in Backstage service catalog before going to production
  - golden paths defined for: new service, new infra module, new pipeline
  - self-service infrastructure via Backstage templates — no ad-hoc resource creation
  - platform APIs versioned and documented — breaking changes require deprecation notice
  - developer experience measured: onboarding time, self-service adoption rate, DORA metrics
  - all platform components follow the same observability standards as application services
  - platform changes go through the same GitOps flow as application changes
  - documentation generated and published automatically on merge to main

backstage_requirements:
  catalog_entity:
    - kind: Component | Resource | System | API
    - metadata.name
    - metadata.description
    - metadata.tags
    - spec.owner (team name)
    - spec.lifecycle: experimental | production | deprecated
    - spec.type
  annotations:
    - github.com/project-slug
    - backstage.io/techdocs-ref
    - prometheus.io/alert (if applicable)

golden_path_checklist:
  new_service:
    - Backstage template scaffolds repo, CI pipeline, and catalog entry
    - observability stack pre-configured (metrics, logs, tracing, Sentry)
    - Kubernetes manifests and Helm chart generated
    - ArgoCD app created
    - SLO defined
  new_module:
    - Terraform module with standard file structure
    - README.md generated
    - registered in Backstage as a Resource

review_checklist:
  - Backstage catalog entry present
  - TechDocs linked
  - owner team assigned
  - golden path used (not manual scaffolding)

require_review:
  - changes to Backstage templates (golden paths)
  - platform API breaking changes
  - changes to onboarding flow
