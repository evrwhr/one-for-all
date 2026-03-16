domain: reliability

capabilities:
  - SLO/SLI/SLA definition
  - error budget management
  - incident response
  - postmortem analysis
  - chaos engineering
  - load testing
  - failure testing
  - runbook creation
  - resilience patterns (circuit breaker, retry, bulkhead)

rules:
  - every service must have a defined SLO before going to production
  - error budgets tracked and reviewed weekly — freeze non-critical changes when budget < 10%
  - runbook required for every alert and every production operation
  - postmortem mandatory for every SEV-1 and SEV-2 incident — published within 5 business days
  - chaos engineering experiments run in staging before production hardening
  - load tests executed before every major release
  - circuit breakers configured for all downstream dependencies
  - retry policies must use exponential backoff with jitter — no fixed-interval retries
  - bulkhead pattern applied to isolate failure domains in critical paths
  - multi-region failover tested at least quarterly

incident_severity:
  sev1: complete outage or data loss — immediate all-hands response
  sev2: partial outage or significant degradation — response within 15 min
  sev3: minor degradation — response within 2 hours
  sev4: no user impact — fix in next sprint

error_budget_policy:
  healthy: all changes allowed
  at_risk: only critical fixes and reliability improvements
  exhausted: freeze all non-reliability changes

postmortem_structure:
  - summary
  - timeline
  - root cause
  - contributing factors
  - impact
  - action items (with owner and due date)
  - lessons learned

review_checklist:
  - SLO defined with error budget
  - runbook linked in alert
  - circuit breaker configured for external calls
  - retry policy uses backoff with jitter
  - load test results reviewed

require_review:
  - SLO threshold changes
  - changes to incident response process
  - disabling circuit breakers or retry logic
