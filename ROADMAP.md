# Project Roadmap – Lightweight RBAC Authorization Service

This roadmap outlines the planned evolution of the Lightweight RBAC Authorization Service.
The goal is to deliver a **simple, fast, and developer-friendly authorization backend** that
solves real-world RBAC needs without unnecessary complexity.

---

## Guiding Principles

- Authorization only (no authentication / login)
- API-first and framework-agnostic
- Low latency and cache-friendly
- Easy to reason about and debug
- Safe defaults and secure-by-design

---

## v0.1 – Minimum Viable Product (MVP)

**Goal:** Make the service usable in real applications.

### Core RBAC Model
- Users (external identities)
- Roles
- Permissions (`action`, `resource`)
- Role-to-permission mapping
- User-to-role assignment
- Optional scoped roles (e.g. org/project)

### APIs
- Create / list / update / delete roles
- Create / list / update / delete permissions
- Assign and remove roles from users
- Authorization check endpoint:
  - `POST /v1/check`
- Batch authorization checks:
  - `POST /v1/batch-check`

### Security
- Admin API keys (manage roles/permissions)
- Runtime API keys (authorization checks only)
- Input validation and strict schemas

### Infrastructure
- Relational database schema
- Basic migrations
- In-memory caching of effective permissions
- Docker + Docker Compose setup

### Developer Experience
- OpenAPI specification
- Clear README and Quickstart
- Example integration for one backend framework

---

## v0.2 – Production Hardening

**Goal:** Make the service safe and reliable in production.

### Performance
- Database indexing for hot paths
- Improved cache invalidation strategy
- Optimized batch authorization checks

### Observability
- Structured logging
- Metrics (latency, cache hit rate, allow/deny counts)
- Health and readiness endpoints

### Audit Logging
- Log changes to:
  - Roles
  - Permissions
  - Role assignments
- Query audit logs via API
- Export audit data (JSON/CSV)

### Security Improvements
- Rate limiting on authorization endpoints
- Admin vs runtime key enforcement
- Safer error handling (no information leaks)

---

## v0.3 – Developer Experience & Tooling

**Goal:** Improve usability and adoption.

### Explainable Authorization
- Detailed decision reasons
- Matched roles and permissions
- Clear deny reasons (missing role, missing permission)

### CLI Tool
- Manage roles and permissions
- Assign roles to users
- Run authorization checks locally
- Import/export RBAC configuration

### Configuration Management
- RBAC config as code (YAML/JSON)
- Idempotent sync mode
- Environment-specific configs

### SDKs
- Official SDKs for:
  - Node.js
  - Python
  - Go

---

## v0.4 – Advanced RBAC Features (Optional)

**Goal:** Support more complex real-world setups without losing simplicity.

### Groups & Teams
- Group-based role assignments
- User-to-group mappings
- Effective permission resolution

### Multi-Tenancy
- Tenant isolation
- Tenant-level admin keys
- Per-tenant RBAC configuration

### ABAC-lite (Carefully Scoped)
- Simple attribute checks (e.g. resource owner)
- Explicit opt-in
- No full policy language

---

## v1.0 – Stable Release

**Goal:** Lock APIs and guarantee stability.

- Stable API contracts
- Backward compatibility guarantees
- Performance benchmarks
- Security review
- Long-term support guidelines

---

## Out of Scope (Explicitly)

- User login / authentication
- Password storage
- OAuth flows
- UI-heavy admin consoles
- Full policy languages

---

## Contribution Milestones

Good areas for community contributions:
- SDKs and middleware
- Performance benchmarks
- Database adapters
- Documentation and examples
- Security reviews and threat modeling

---

## Versioning Policy

- Pre-1.0: breaking changes allowed with notice
- 1.0+: semantic versioning
- Security fixes backported where possible

---

## Philosophy

> Authorization should be boring, fast, and predictable.
> Complexity should be opt-in, never forced.
