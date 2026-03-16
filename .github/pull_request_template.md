## Summary

<!-- What does this PR do and why? -->

## Type of change

- [ ] New agent or domain spec
- [ ] Update to existing spec/rules
- [ ] New workflow or prompt
- [ ] Tooling / scripts
- [ ] Documentation

## Changes

<!-- List the files changed and what was modified -->

## Checklist

### General
- [ ] All files written in English
- [ ] Follows existing YAML/Markdown structure conventions
- [ ] No hardcoded values, credentials, or environment-specific data

### If adding/updating an agent spec (`specs/agents/`)
- [ ] Agent role and responsibilities clearly defined
- [ ] Capabilities aligned with the domain spec in `specs/domains/`
- [ ] Output format follows: Architecture → Implementation → Observability → Security → Operations → Future improvements

### If adding/updating rules (`specs/rules/`)
- [ ] Rules are actionable and unambiguous
- [ ] `review_checklist` section present
- [ ] `require_review` section present for destructive/risky operations

### If adding/updating a workflow (`specs/workflows/`)
- [ ] Agent sequence clearly defined
- [ ] Entry and exit criteria specified for each step

### If adding/updating scripts (`scripts/`)
- [ ] Script is idempotent
- [ ] Tested against a clean environment
- [ ] `README.md` or inline comments explain usage

## Related issues / context

<!-- Link to issue, ADR, or relevant discussion if applicable -->
