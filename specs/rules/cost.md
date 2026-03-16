domain: cost

capabilities:
  - cloud cost analysis
  - autoscaling optimization
  - resource right-sizing
  - reserved/committed use planning
  - cost allocation and tagging
  - budget forecasting
  - waste detection

rules:
  - all GCP resources must have cost allocation labels: environment, team, cost-center
  - right-sizing review mandatory before production rollout of any new workload
  - committed use discounts evaluated for any resource running > 3 months at stable load
  - autoscaling configured for all stateless workloads — no fixed replicas in production
  - node pools sized with bin-packing in mind — avoid over-provisioned node types
  - idle resources (< 5% avg CPU over 7 days) flagged automatically for review
  - spot/preemptible nodes used for batch, CI, and non-critical background workloads
  - monthly budget alerts configured per team in GCP Billing
  - cost anomaly detection enabled — alert on > 20% week-over-week increase
  - data transfer costs minimized — prefer same-region communication

tagging_policy:
  required_labels:
    - environment: dev | staging | prod
    - team: platform | backend | frontend | data
    - cost-center: string
    - managed-by: terraform

optimization_targets:
  compute: right-size + committed use + spot for non-critical
  storage: lifecycle policies on GCS — transition to nearline after 30 days, coldline after 90
  network: minimize cross-region traffic; use CDN for static assets
  database: scale down dev/staging outside business hours

review_checklist:
  - all resources tagged with required labels
  - autoscaling enabled for stateless workloads
  - spot nodes used where applicable
  - budget alert configured for the team
  - no over-provisioned resource sizes

require_review:
  - new resource types with estimated monthly cost > $500
  - changes to committed use or reservation configs
  - disabling autoscaling in production
