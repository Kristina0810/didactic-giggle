# CLAUDE.md

**Document Type**: AI Assistant Configuration & Project Specification
**Target Audience**: Claude Code, GitHub Copilot, Cursor, and compatible AI assistants
**Classification**: Internal - Technical Authority
**Last Updated**: [YYYY-MM-DD]
**Version**: 1.0.0

---

## I. EXECUTIVE CONTEXT

### 1.1 Project Identity

```yaml
project:
  name: "[Project Name]"
  repository: "[username/repo-name]"
  description: "[One-sentence project description]"

structure:
  technical_lead:
    name: "[Name or AI/Human]"
    authority: ["architecture", "implementation", "code_standards"]
  product_owner:
    name: "[Name]"
    authority: ["features", "priorities", "business_decisions"]
```

### 1.2 Project Status

```yaml
phase: "[Discovery/MVP/Alpha/Beta/Production/Maintenance]"
status: "[Active Development/On Hold/Complete]"
started: "[YYYY-MM-DD]"
current_focus: "[What you're working on right now]"
```

### 1.3 Critical Constraints

```yaml
constraints:
  timeline: "[Hard deadline or 'Flexible']"
  budget: "[Cost constraints or 'Unlimited']"
  team_size: "[Number of contributors]"
  tech_debt_tolerance: "[Zero/Low/Medium/High]"

priorities:
  - "[Priority 1: e.g., Speed to market]"
  - "[Priority 2: e.g., Code quality]"
  - "[Priority 3: e.g., Performance]"
```

---

## II. REPOSITORY ARCHITECTURE

### 2.1 File System Structure

```
[Project Root]
├── [Directory 1]/          → [Purpose]
│   ├── [Subdirectory]/     → [Purpose]
│   └── [Key files]         → [Purpose]
├── [Directory 2]/          → [Purpose]
└── [Configuration files]   → [Purpose]
```

**Design Principles**:
- [Principle 1: e.g., "Separation of concerns"]
- [Principle 2: e.g., "Configuration over hardcoding"]
- [Principle 3: e.g., "Test coverage >80%"]

### 2.2 Critical Files (DO NOT MODIFY WITHOUT APPROVAL)

| File | Purpose | Owner | Modification Policy |
|------|---------|-------|---------------------|
| [filename] | [purpose] | [name] | [Always ask / CEO approval / Free to modify] |

### 2.3 Technology Stack

```yaml
languages:
  primary: "[e.g., Python 3.11]"
  secondary: "[e.g., TypeScript, SQL]"

frameworks:
  backend: "[e.g., FastAPI, Django, Rails]"
  frontend: "[e.g., React, Vue, Next.js]"

infrastructure:
  hosting: "[e.g., AWS, Vercel, Railway]"
  database: "[e.g., PostgreSQL, MongoDB]"
  cache: "[e.g., Redis, Memcached]"

dependencies:
  critical: "[List packages that MUST NOT be upgraded without testing]"
  version_pinning: "[Strict/Flexible]"
```

---

## III. DEVELOPMENT WORKFLOW

### 3.1 Branch Strategy

```yaml
main_branch:
  name: "[main/master]"
  protection: "[Protected/Unprotected]"
  deployment: "[Auto/Manual to production]"

feature_branches:
  pattern: "[e.g., feature/*, feat/ISSUE-123-description]"
  lifespan: "[Delete after merge/Keep indefinitely]"

pull_requests:
  required: [true/false]
  reviewers: "[Names or 'Not required']"
  ci_checks: "[Required/Optional]"
```

### 3.2 Commit Message Standard

```
[Type] Brief summary (≤50 chars)

Detailed explanation:
- What changed
- Why it changed
- Impact/risk assessment (if applicable)

[Optional footer: issue references, breaking changes]
```

**Type Taxonomy**:
- `[FEAT]` - New features
- `[FIX]` - Bug fixes
- `[DOCS]` - Documentation only
- `[REFACTOR]` - Code restructuring (no behavior change)
- `[TEST]` - Test additions/modifications
- `[CHORE]` - Maintenance (deps, config, etc.)
- `[SECURITY]` - Security patches

### 3.3 Code Standards

```yaml
style:
  formatter: "[e.g., Black, Prettier, gofmt]"
  linter: "[e.g., ESLint, Pylint, RuboCop]"
  auto_format_on_save: [true/false]

testing:
  required_before_commit: [true/false]
  minimum_coverage: "[e.g., 80%]"
  test_command: "[e.g., pytest, npm test]"

documentation:
  docstrings: "[Required/Optional]"
  inline_comments: "[Complex logic only/Everywhere/Minimal]"
  README_updates: "[Required for API changes]"
```

---

## IV. POLICY ENFORCEMENT

### 4.1 PROHIBITED ACTIONS

```yaml
code_violations:
  - action: "[e.g., Hardcoded credentials]"
  - rationale: "[Why this is forbidden]"
  - exception: "[When this is allowed, if ever]"

workflow_violations:
  - action: "[e.g., Direct commit to main]"
  - rationale: "[Why this is forbidden]"
  - exception: "[When this is allowed, if ever]"

architectural_violations:
  - action: "[e.g., New database without approval]"
  - rationale: "[Why this is forbidden]"
  - exception: "[When this is allowed, if ever]"
```

### 4.2 MANDATORY ACTIONS

```yaml
before_commit:
  - action: "[e.g., Run tests]"
  - rationale: "[Why this is required]"
  - command: "[Exact command to run]"

before_pr:
  - action: "[e.g., Update CHANGELOG.md]"
  - rationale: "[Why this is required]"
  - location: "[Where to make changes]"

before_deployment:
  - action: "[e.g., Database migration plan]"
  - rationale: "[Why this is required]"
  - verification: "[How to verify completion]"
```

---

## V. TECHNICAL DECISIONS

### 5.1 Architecture Decision Records (ADRs)

#### ADR-001: [Decision Title]

```yaml
status: "[Proposed/Accepted/Deprecated/Superseded]"
date: "[YYYY-MM-DD]"
decision: "[One-sentence summary of decision]"

context:
  - "[Why this decision was needed]"
  - "[What alternatives were considered]"

consequences:
  positive:
    - "[Benefit 1]"
    - "[Benefit 2]"
  negative:
    - "[Trade-off 1]"
    - "[Trade-off 2]"
  mitigation:
    - "[How to address negative consequences]"

rationale: |
  [Detailed explanation of why this decision was made]
```

#### ADR-002: [Next Decision]

[Same structure as ADR-001]

---

## VI. TROUBLESHOOTING

### 6.1 Common Issues

| Issue | Root Cause | Resolution | Prevention |
|-------|-----------|------------|------------|
| [Error message] | [Why it happens] | [How to fix] | [How to avoid] |

### 6.2 Diagnostic Commands

```bash
# [System health check]
[command]

# [Dependency verification]
[command]

# [Database connection test]
[command]

# [Service status check]
[command]
```

---

## VII. COMMUNICATION PROTOCOLS

### 7.1 Decision Authority

| Domain | Authority | Escalation Path |
|--------|-----------|-----------------|
| [Product features] | [Product Owner] | [N/A or escalation contact] |
| [Technical architecture] | [Tech Lead] | [Product Owner if budget/timeline impact] |
| [Code standards] | [Tech Lead] | [Team discussion if controversial] |

### 7.2 Response Time Expectations

```yaml
critical:
  definition: "[e.g., Production down, security breach]"
  response_time: "[e.g., <1 hour]"

high:
  definition: "[e.g., Major bug, user-facing error]"
  response_time: "[e.g., <4 hours]"

normal:
  definition: "[e.g., Feature questions, minor bugs]"
  response_time: "[e.g., <24 hours]"

low:
  definition: "[e.g., Optimization ideas, refactoring]"
  response_time: "[e.g., <48 hours or next planning session]"
```

---

## VIII. ENVIRONMENT SETUP

### 8.1 Development Environment

```bash
# Prerequisites
[List required software: e.g., Python 3.11, Node.js 20, Docker]

# Setup steps
git clone [repository-url]
cd [project-directory]
[Installation commands]

# Environment variables
cp .env.example .env
# Edit .env with required values:
# - [VARIABLE_NAME]: [Description of what it does]

# Verify setup
[Command to verify everything works]
```

### 8.2 Common Commands

```bash
# === DEVELOPMENT ===
[Start dev server command]
[Run tests command]
[Format code command]
[Lint code command]

# === DATABASE ===
[Run migrations command]
[Seed database command]
[Database console command]

# === DEPLOYMENT ===
[Build command]
[Deploy command]
[Rollback command]
```

---

## IX. REFERENCE DATA

### 9.1 External Resources

```yaml
documentation:
  - "[Framework docs URL]"
  - "[API docs URL]"

tools:
  - "[CI/CD dashboard URL]"
  - "[Deployment dashboard URL]"
  - "[Analytics dashboard URL]"

community:
  - "[Slack/Discord channel]"
  - "[Issue tracker URL]"
```

### 9.2 Internal Documentation

```yaml
onboarding:
  - "[README.md]"
  - "[CONTRIBUTING.md]"

architecture:
  - "[Architecture diagram location]"
  - "[Database schema location]"

runbooks:
  - "[Deployment runbook location]"
  - "[Incident response runbook location]"
```

---

## X. DOCUMENT METADATA

```yaml
document:
  name: "CLAUDE.md"
  type: "AI Assistant Configuration"
  version: "1.0.0"
  status: "Active"

versioning:
  current: "1.0.0"
  changelog: "See git history"

ownership:
  author: "[Your name]"
  maintainer: "[Your name or team]"

review_schedule:
  frequency: "[As needed/Weekly/Monthly/Per phase]"
  triggers:
    - "[Major architectural change]"
    - "[Team structure change]"
    - "[Technology stack change]"
```

---

## CUSTOMIZATION GUIDE

**This template includes all possible sections. You should:**

1. **Delete irrelevant sections** - If you don't have ADRs yet, remove Section V
2. **Keep it minimal** - Start with Sections I-III, grow organically
3. **Update frequently** - This should reflect current reality, not aspirations
4. **Be specific** - Replace all `[placeholders]` with actual values
5. **Stay ruthless** - If information isn't actionable, delete it

**Typical evolution path:**
- **Week 1**: Sections I-II (Identity + Architecture)
- **Month 1**: Add Section III (Workflow)
- **Month 3**: Add Section IV-V (Policies + ADRs)
- **Production**: Add Section VI (Troubleshooting)

**End of Template**
