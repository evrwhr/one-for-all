domain: security
capabilities:
  - IAM design (least privilege)
  - secrets management
  - policy as code
  - supply chain security
  - zero trust architecture
  - automated security scans
  - compliance enforcement
  - threat modeling
stack:
  policy: opa | kyverno
  scanning: trivy | falco
  secrets: vault | sealed-secrets
