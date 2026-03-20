# Frontend Build Modernization — turnoverbnb-web

**Owner:** Platform Team
**Timeline:** TBD after spike (estimate: 1 sprint for spike, 2–4 sprints for execution)
**Status:** Future track — requires spike before committing to execution
**Repository:** turnoverbnb-web

---

## Overview

This document tracks the Node.js upgrade (DF-2) and potential Laravel Mix → Vite migration for turnoverbnb-web. These items were intentionally extracted from the [Docker Build Optimization](docker-build-optimization.md) track because they carry high risk and deep coupling with the legacy frontend dependency tree.

The core question: **should we upgrade Node 15 → 18 standalone, or skip ahead to Node 20 + Vite in a single migration?** A spike is needed to answer this before committing resources.

### Related Documents

- [Docker Build Optimization](docker-build-optimization.md) — tactical Dockerfile fixes (DF-1, DF-3 through DF-10)
- [CI/CD Architecture Decision](cicd-architecture-decision.md) — pipeline consolidation and reusable workflows

---

## Current State

### Node Stage in Production Dockerfile

**File:** `docker/production/Dockerfile` lines 100–160

| Component | Current | Problem |
|-----------|---------|---------|
| Base image | `ubuntu:22.04` | ~500MB with apt packages (python2, python3, make, g++, build-essential) |
| Node version manager | NVM | Adds installation overhead |
| Node version | `v15.14.0` | EOL since June 2021 |
| Memory allocation | `--max-old-space-size=8192` | 8GB is excessive for this build |
| Native build tool | `npm_config_python=/usr/bin/python2` | Indicates legacy native dependencies |

### Frontend Dependency Profile

| Signal | Value | Implication |
|--------|-------|-------------|
| `lockfileVersion` | 1 (npm v5/v6 format) | Very old lockfile; npm 7+ uses lockfileVersion 2-3 |
| Dependencies | 107 + 51 devDependencies | Large dependency tree |
| `node-sass` via `sass-loader` | Present | Native binding, does not compile on Node 18+ |
| `fibers` | Present | Native binding, deprecated, incompatible with Node 16+ |
| `--legacy-peer-deps` | Required | Peer dependency conflicts between Vue 2, Vuetify 2, and Laravel Mix 6 |
| Build tool | Laravel Mix 6 (Webpack 5) | Works but is in maintenance mode; Vite is the official Laravel successor |
| Entry points | 7 JS + 1 SASS (dashboard), plus marketing and public-cleaners | Significant compilation surface |

---

## Decision Point

### Path A: Node 18 Standalone Upgrade

Upgrade Node 15 → 18 while keeping Laravel Mix and the existing dependency tree.

**Effort estimate:** 2–3 sprints
**Pros:** Smaller change surface, keeps Mix config intact.
**Cons:** `fibers` and `node-sass` must be replaced with `dart-sass` regardless. Some dependencies may need upgrading. The lockfile format will change. This work becomes partially throwaway if Vite migration happens later.

### Path B: Node 20 + Vite Migration (Single Big Migration)

Skip Node 18, go directly to Node 20 + Vite, replacing Laravel Mix entirely.

**Effort estimate:** 3–5 sprints
**Pros:** One migration instead of two. Vite is dramatically faster than Webpack for the dev server and HMR. Vite is the official Laravel build tool since Laravel 10. Eliminates `node-sass`, `fibers`, UglifyJS, and the complex webpack.mix.js configuration. Node 20 is LTS until April 2026.
**Cons:** Larger blast radius. All webpack.mix.js entry points need to be ported to `vite.config.js`. Vue 2 + Vite requires `@vitejs/plugin-vue2`. Vuetify 2 may have compatibility issues with Vite's ESM-first approach.

### Recommendation

**Path B is likely the better investment**, but the spike must confirm feasibility. If the spike reveals that Vue 2 + Vuetify 2 + Vite is not viable without significant refactoring, fall back to Path A.

---

## Spike Definition

The spike produces a **go/no-go recommendation** for Path A vs Path B. Estimated duration: 1 sprint.

### S1: Map Native Dependency Compatibility

Run `npm ls` locally and catalog every package with native bindings (C/C++ addons compiled via `node-gyp`). For each:
- Test with Node 18 (`node:18-bullseye`)
- Test with Node 20 (`node:20-bullseye`)
- Document the failure and whether a replacement exists

**Key packages to test:** `node-sass`, `fibers`, any `@storybook/*` packages, `jest` (if using native transforms).

### S2: Test npm ci with Node 18 and Node 20

```bash
docker run --rm -v $(pwd):/app -w /app node:18-bullseye bash -c \
  "apt-get update && apt-get install -y python3 make g++ && npm ci --legacy-peer-deps 2>&1"

docker run --rm -v $(pwd):/app -w /app node:20-bullseye bash -c \
  "apt-get update && apt-get install -y python3 make g++ && npm ci --legacy-peer-deps 2>&1"
```

Catalog each error. Classify as:
- **Blocker:** package does not install and has no drop-in replacement
- **Fixable:** package fails but a replacement exists (e.g., `node-sass` → `sass`)
- **Warning:** deprecation notices that do not break the build

### S3: Assess dart-sass Migration

`node-sass` (LibSass) is deprecated and does not compile on Node 18+. The replacement is `sass` (Dart Sass). Assess:
- Does `sass-loader` work with `sass` as the implementation?
- Are there any Sass features used in the codebase that are incompatible with Dart Sass (e.g., `/` for division is deprecated in Dart Sass)?
- What is the LOE to update SCSS files?

### S4: Assess Vite Migration (Path B only)

- Inventory all `webpack.mix.js` entry points and their configurations (aliases, plugins, loaders)
- Evaluate the [Laravel Vite migration guide](https://laravel.com/docs/vite#migrating-from-laravel-mix)
- Test `@vitejs/plugin-vue2` with the existing Vue 2 components
- Verify Vuetify 2 compatibility with Vite's ESM module resolution
- Estimate total LOE to port all entry points

### S5: Produce Go/No-Go Recommendation

Deliverable: a brief document with:
- Path A feasibility: yes/no, effort estimate, list of breaking changes
- Path B feasibility: yes/no, effort estimate, list of breaking changes
- Recommendation: A, B, or "defer until Vue 3 migration"

---

## Systemic Risk

### R2: Node 18 Migration Trap

**Risk:** The signals (`fibers`, `node-sass`, `--legacy-peer-deps`, `python2`, `lockfileVersion: 1`) indicate the entire frontend toolchain is locked to a 2020 ecosystem. What looks like "change the base image" is actually a partial rewrite of the build pipeline. Without the spike, the team may commit to a timeline that is 2–3x too short.

**Probability:** High | **Impact:** High

**Mitigation:**
- Do not start execution without completing the spike.
- If the spike reveals more than 2 weeks of dependency fixing, strongly consider Path B (Vite) to avoid doing the work twice.
- If neither Path A nor Path B is feasible in a reasonable timeframe, defer this track entirely until a Vue 3 migration is planned (which would naturally resolve the Node version and tooling constraints).

---

## Timeline

| Phase | Duration | Scope |
|-------|----------|-------|
| Spike | 1 sprint | S1–S5: feasibility analysis and go/no-go |
| Execution (if Path A) | 2–3 sprints | dart-sass migration, Node 18 upgrade, lockfile regeneration, testing |
| Execution (if Path B) | 3–5 sprints | Vite migration, dart-sass, Node 20, all entry points ported, testing |

**Note:** This track is independent of the [Docker Build Optimization](docker-build-optimization.md) and [CI/CD Architecture](cicd-architecture-decision.md) tracks. Those can proceed in parallel without waiting for this spike.

---

## Jira Hierarchy Suggestion

### Initiative: Frontend Build Modernization — turnoverbnb-web

Upgrade the frontend build toolchain from Node 15 + Laravel Mix + node-sass to Node 20 + Vite + dart-sass, eliminating EOL dependencies and reducing build times.

### Epic: Frontend Build Modernization Spike

Validate feasibility and effort for Node upgrade and Vite migration before committing to execution.

- **Story: Map native dependency compatibility with Node 18/20**
  Identify all packages with native bindings and test them against Node 18 and Node 20.
  - Task: Run `npm ls` and catalog all native binding packages
  - Task: Test `npm ci` with Node 18-bullseye, document failures
  - Task: Test `npm ci` with Node 20-bullseye, document failures
  - Task: For each failure, identify replacement or workaround

- **Story: Assess dart-sass migration path**
  Evaluate replacing node-sass with dart-sass (required for any Node upgrade path).
  - Task: Test sass-loader with sass (Dart Sass) as implementation
  - Task: Scan SCSS files for deprecated `/` division syntax
  - Task: Estimate LOE for SCSS compatibility fixes

- **Story: Assess Vite migration path**
  Evaluate replacing Laravel Mix with Vite for the production build.
  - Task: Inventory all webpack.mix.js entry points and configurations
  - Task: Evaluate Laravel Mix → Vite migration guide applicability
  - Task: Test `@vitejs/plugin-vue2` with existing Vue 2 components
  - Task: Verify Vuetify 2 compatibility with Vite ESM resolution
  - Task: Estimate total LOE to port all entry points

- **Story: Produce go/no-go recommendation**
  - Task: Write spike report with Path A and Path B feasibility
  - Task: Present recommendation to platform team and app team leads
