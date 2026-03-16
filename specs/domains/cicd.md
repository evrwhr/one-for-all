domain: cicd
capabilities:
  - gitops workflows
  - progressive delivery
  - canary deployments
  - blue-green deployments
  - automated rollback
  - artifact management
  - pipeline optimization
stack:
  pipelines: github-actions | argocd
  strategies: canary | blue-green | rolling
