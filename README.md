<p align="center">
 <img src="./Gatekeeper_logo.png" height="300px"> 
</p>

# Gatekeeper <br>
<i>**Lightweight RBAC Authorization Service**</i>

A **simple, fast, self-hosted authorization service** that provides **Role-Based Access Control (RBAC)** for applications without reinventing permissions in every codebase.

This project focuses on **developer experience**, **performance**, and **clarity** - not enterprise bloat.

---

## Why this exists

Most applications need authorization, but developers usually end up with one of these bad options:

- Rebuilding RBAC logic in every service
- Hard-coding permissions all over the codebase
- Adopting heavyweight policy engines they don’t fully understand
- Lock-in to SaaS authorization vendors

This project solves that by offering:

- A **dedicated authorization backend**
- A **small, explicit RBAC model**
- A **single API call** to answer:  
  *“Can user X do action Y on resource Z?”*

---

## Core Features

- 🔐 Pure RBAC (roles → permissions → users)
- ⚡ Low-latency authorization checks
- 📦 Self-hosted & open source
- 🔌 API-first (no framework lock-in)
- 🧩 Works with existing authentication (JWT, OIDC, etc.)
- 🧠 Explainable decisions (why allowed / denied)
- 🧪 Easy to test locally

---

## Non-Goals (by design)

- No full policy language (OPA, Rego, etc.)
- No authentication or login system
- No UI in early versions
- No vendor-specific dependencies

---

## High-Level Architecture

Your application authenticates users and calls this service to authorize actions.

```
Your App ──▶ RBAC Service ──▶ Decision (allow / deny)
```

---

## RBAC Model

### Entities

- **User**: external identity reference (e.g. user ID from JWT)
- **Role**: named collection of permissions
- **Permission**: `{action, resource}`
- **Role Assignment**: user → role (optionally scoped)

Example permission: `invoice:read`

---

## Authorization API

### Check permission

```http
POST /v1/check
```

```json
{
  "subject": "user_123",
  "action": "invoice:read",
  "resource": "invoice",
  "scope": {
    "type": "org",
    "id": "org_456"
  }
}
```

```json
{
  "allow": true,
  "reason": "permission_granted",
  "matched_roles": ["accountant"]
}
```

---

## Authentication Model

This service does **not** implement user login.

- Users authenticate in your application
- Your application calls this service using API keys
- This service only performs authorization

---

## Running Locally

```bash
docker compose up
```

Service will be available at:

```
http://localhost:8080
```

---

## Roadmap

- v0.1: Core RBAC + authorization checks
- v0.2: Audit logs, batch checks, CLI
- v0.3: Groups, multi-tenancy, webhooks

---

## License

MIT
