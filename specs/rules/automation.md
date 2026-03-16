domain: automation

capabilities:
  - self-healing infrastructure
  - automated remediation
  - infra bots
  - runbook automation
  - event-driven workflows
  - serverless automation

stack:
  languages: python | go
  patterns: event-driven | serverless

rules:
  - automate any manual operation performed more than once
  - self-healing actions must be idempotent — safe to run multiple times
  - event-driven automations must have dead-letter queues and retry logic
  - all automation scripts in Python or Go — no undocumented bash beyond 30 lines
  - automation failures must trigger alerts — never fail silently
  - runbook automations must mirror the manual runbook steps exactly
  - serverless functions used for stateless, event-triggered automations
  - infra bots must have read-only mode for dry-run validation before executing changes
  - automation code follows the same review process as application code
  - all automated remediations logged with: trigger, action taken, outcome, timestamp

patterns:
  self_healing:
    - detect anomaly via alert or metric threshold
    - execute remediation action (idempotent)
    - verify recovery
    - notify and log
  event_driven:
    - source: pubsub | webhook | scheduled cron
    - handler: cloud function | cloud run | kubernetes job
    - dlq: required for all async handlers
    - retry: exponential backoff with max attempts

review_checklist:
  - idempotency verified
  - dry-run mode available
  - failure alerting configured
  - dead-letter queue defined for async flows
  - logs include trigger, action, outcome

require_review:
  - automations that modify production resources
  - changes to self-healing remediation logic
  - new event sources added to existing automations
