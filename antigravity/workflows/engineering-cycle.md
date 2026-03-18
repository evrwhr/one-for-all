# Engineering Cycle

Two-agent pipeline for platform engineering delivery.

```
Platform Architect  →  Platform Engineer
```

## Steps

### 1. Architect

**Trigger:** new service, new infra module, migration, incident-driven redesign, or planning request.

**Produces:**
- Architecture overview and component diagram
- ADRs (technology decisions with tradeoffs)
- SLO targets and error budget policy
- Security design (IAM, trust boundaries)
- Cost strategy (tagging, scaling, committed use)
- Golden path definition (if new service or module)
- Work breakdown (initiative → epics → stories → tasks) if applicable
- Handoff document

**Handoff format:**
```
## Handoff → Engineer
- Decisions: [architecture choices made with rationale]
- Artifacts: [ADRs, diagrams, SLO specs, Backstage catalog entries, work breakdown]
- Constraints: [cost limits, compliance requirements, SLO targets, approved tech choices]
- Open questions: [unresolved decisions the engineer must surface before implementing]
```

### 2. Engineer

**Trigger:** Architect handoff received.

**Produces:**
- Terraform/Terragrunt modules
- Kubernetes manifests and Helm charts
- GitHub Actions pipelines and ArgoCD app definitions
- IAM bindings and secrets configuration
- OPA/Kyverno policies
- Prometheus metrics, Grafana dashboards, alerts, and runbooks
- Self-healing automation scripts
- Postmortem (if incident-driven)
- Updated Backstage catalog entries

**Output structure:**
1. Architecture
2. Implementation
3. Observability
4. Security
5. Operations
6. Future improvements

---

## Autonomous operations

Between explicit cycles, the Engineer runs continuously:

- Anomaly detection and alert triage
- Incident mitigation (detect → diagnose → remediate → replace → notify → report)
- Autoscaling and resource optimization
- Error budget tracking and freeze enforcement
- Cost waste detection and flagging
- Operational reporting

---

## When to re-engage Architect

- Any change that affects component boundaries or technology choices
- SLO target changes
- New service or infra module not covered by existing golden paths
- Post-incident redesign
- Sprint planning for a new initiative
