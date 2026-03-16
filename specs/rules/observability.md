domain: observability

capabilities:
  - metrics collection and analysis
  - structured logging
  - distributed tracing
  - SLO/SLI dashboards
  - alerting design
  - OpenTelemetry instrumentation
  - service health monitoring

stack:
  metrics: prometheus | grafana
  tracing: opentelemetry
  errors: sentry

rules:
  - every service must expose /metrics in Prometheus format
  - structured logging mandatory — no unstructured log.Print or fmt.Println in production code
  - distributed tracing required for all inter-service calls — propagate context always
  - SLO dashboards created alongside every new service deployment
  - alerts must have: severity, runbook link, and owner label
  - no alert without a runbook — block PR if runbook is missing
  - alert fatigue prevention: no alert fires more than 3x per day without action
  - OpenTelemetry SDK used for all new instrumentation — no vendor-specific SDKs
  - Sentry project created for every service that handles user-facing errors
  - log retention: 30 days hot, 1 year cold (GCS)

slo_standards:
  availability:
    critical: "99.9%"
    standard: "99.5%"
  latency_p99:
    critical: 500ms
    standard: 1000ms
  error_rate:
    critical: "0.1%"
    standard: "1%"

alert_severity:
  critical: pagerduty — immediate response required
  warning: slack — response within business hours
  info: dashboard only — no notification

review_checklist:
  - /metrics endpoint present
  - SLO defined and dashboard linked
  - alerts have runbook URLs
  - tracing context propagated
  - Sentry project configured for user-facing errors

require_review:
  - changes to existing SLO thresholds
  - disabling or silencing production alerts
  - changes to log retention policy
