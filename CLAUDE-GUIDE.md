# CLAUDE-GUIDE.md

**Document Type**: Meta-Documentation
**Purpose**: Guide for when, why, and how to use CLAUDE.md files
**Audience**: Developers working with AI assistants
**Version**: 1.0.0

---

## I. WHAT IS CLAUDE.MD?

### 1.1 Definition

**CLAUDE.md** is a machine-readable configuration file that tells AI assistants:
- Project context and constraints
- Development conventions and workflows
- Prohibited and mandatory actions
- Architecture decisions and rationale
- Troubleshooting procedures

**Primary consumers**: Claude Code, GitHub Copilot, Cursor, ChatGPT (code mode)

**Format**: Markdown with YAML blocks (human-readable, AI-parsable)

### 1.2 The Problem It Solves

**Without CLAUDE.md:**
```
Session 1: "Use TypeScript with Prettier"
Session 2: AI suggests JavaScript with ESLint
Session 3: AI rewrites entire config
Result: Inconsistent codebase, wasted time
```

**With CLAUDE.md:**
```
Every session: AI reads CLAUDE.md → knows TypeScript + Prettier
Result: Consistent suggestions, zero re-explanation
```

### 1.3 Core Principle

```yaml
principle: "Single source of truth for AI assistant guidance"
philosophy: "Write once, enforce everywhere"
alternative_name: "AI Assistant Contract"
```

**NOT a replacement for**:
- README.md (user-facing documentation)
- CONTRIBUTING.md (human contributor guide)
- Architecture diagrams (visual documentation)

**Complements**:
- All of the above by providing AI-specific context

---

## II. WHEN TO CREATE CLAUDE.MD

### 2.1 Decision Matrix

```yaml
create_if:
  - "Working with AI assistants regularly (3+ sessions/week)"
  - "Project has established conventions worth preserving"
  - "Multiple contributors need alignment"
  - "Onboarding new team members frequently"
  - "Technical decisions need documentation"
  - "Project >500 lines of code OR >2 weeks old"

skip_if:
  - "Solo throwaway prototype (<1 week lifespan)"
  - "Following standard framework with no customization"
  - "No AI assistant usage planned"
  - "Project has <100 lines of code"
  - "Conventions change daily (pre-architecture phase)"
```

### 2.2 Project Phase Analysis

| Phase | CLAUDE.md Needed? | Why/Why Not |
|-------|-------------------|-------------|
| **Ideation** (brainstorming) | ❌ No | Too early, no conventions yet |
| **Prototype** (<1 week) | ❌ No | Conventions not stable |
| **MVP** (2-8 weeks) | ✅ Yes | Conventions emerging, document them |
| **Alpha/Beta** | ✅✅ Required | Team scaling, consistency critical |
| **Production** | ✅✅✅ Essential | Stability required, policies enforced |
| **Maintenance** | ✅ Yes | Knowledge preservation for future work |

### 2.3 Team Size Analysis

| Team Size | CLAUDE.md Value | Rationale |
|-----------|----------------|-----------|
| **Solo** | Medium | Helps across sessions, prevents drift |
| **2-3 people** | High | Ensures alignment without meetings |
| **4-10 people** | Very High | Prevents fragmentation |
| **10+ people** | Critical | Mandatory for consistency |

---

## III. HOW TO CREATE CLAUDE.MD

### 3.1 Evolutionary Approach (RECOMMENDED)

**Anti-Pattern**: Write 1,000-line CLAUDE.md on day 1
**Best Practice**: Start minimal, grow organically

```yaml
week_1:
  size: "~100 lines"
  sections:
    - "I. Executive Context (project identity)"
    - "II. Repository Architecture (basic structure)"
  rationale: "Document what exists, not aspirations"

month_1:
  size: "~300 lines"
  add_sections:
    - "III. Development Workflow (git, commits)"
  rationale: "Workflows have stabilized"

month_3:
  size: "~500 lines"
  add_sections:
    - "IV. Policy Enforcement (do's and don'ts)"
    - "V. Technical Decisions (ADRs)"
  rationale: "Policies emerged from experience"

production:
  size: "~800-1000 lines"
  add_sections:
    - "VI. Troubleshooting (common issues)"
    - "VII. Communication Protocols (if team)"
  rationale: "Production issues documented"
```

### 3.2 Starting from CLAUDE-TEMPLATE.md

**Step 1: Copy template**
```bash
cp CLAUDE-TEMPLATE.md CLAUDE.md
```

**Step 2: Delete irrelevant sections**
- New project? Delete Section VI (Troubleshooting) - no issues yet
- Solo developer? Delete Section VII (Communication) - no team
- No architecture decisions yet? Delete Section V (ADRs)

**Step 3: Fill placeholders**
- Replace all `[placeholders]` with actual values
- Delete placeholder examples that don't apply
- Add project-specific sections if needed

**Step 4: Commit to repository root**
```bash
git add CLAUDE.md
git commit -m "[DOCS] Add CLAUDE.md - AI assistant configuration"
git push
```

**Step 5: Verify with AI assistant**
- Start new Claude Code session
- Ask: "What's the project's commit message format?"
- Expected: AI references CLAUDE.md Section III.2

### 3.3 Incremental Updates

**Trigger events for updates:**
- Major architectural decision → Add ADR (Section V)
- New team member joins → Review Section VII (Communication)
- Recurring bug pattern → Add to Section VI (Troubleshooting)
- Policy violation occurs → Add to Section IV (Policies)
- Tech stack change → Update Section II.3 (Technology Stack)

**Update cadence:**
```yaml
reactive:
  trigger: "Immediate update when decision made"
  examples: ["ADR added", "Policy changed"]

proactive:
  trigger: "Monthly review during retrospective"
  action: "Check if reality matches documentation"
```

---

## IV. BEST PRACTICES

### 4.1 Writing Style

**DO:**
```yaml
style:
  - "Use YAML for structured data (specs, configs, checklists)"
  - "Use tables for comparison/reference data"
  - "Use code blocks for commands/examples"
  - "Be specific: 'pytest --cov=src' not 'run tests'"
  - "Be ruthless: delete fluff, keep actionable content"
```

**DON'T:**
```yaml
anti_patterns:
  - "Narrative explanations ('We chose X because we love it')"
  - "Vague guidance ('Write good code', 'Be careful')"
  - "Aspirational content ('We will use TDD' when you don't)"
  - "Outdated information (update or delete)"
  - "Duplicating README.md content"
```

### 4.2 Maintenance

**Ownership:**
- **Small teams (<5)**: Technical lead owns CLAUDE.md
- **Large teams (5+)**: Rotate ownership monthly
- **Open source**: Core maintainers collectively own

**Review frequency:**
```yaml
minimum: "Quarterly (every 3 months)"
recommended: "Monthly (during retrospectives)"
optimal: "Per major change (architecture, team, tech stack)"
```

**Staleness indicators:**
```yaml
warning_signs:
  - "AI assistants ignore CLAUDE.md suggestions"
  - "Team members say 'That's outdated'"
  - "Last update >6 months ago"
  - "Contains deprecated technologies"

action: "Update immediately or delete stale sections"
```

### 4.3 Size Guidelines

```yaml
size_targets:
  minimum_viable: "100-200 lines (Sections I-II)"
  typical_project: "300-500 lines (Sections I-IV)"
  complex_project: "500-800 lines (Sections I-VII)"
  maximum_recommended: "1,000 lines (add sub-docs beyond this)"

guideline: |
  If CLAUDE.md >1,000 lines, split into:
  - CLAUDE.md (core: identity, workflow, policies)
  - ARCHITECTURE.md (detailed architecture decisions)
  - TROUBLESHOOTING.md (extensive diagnostic guides)
  - ADRS/ (directory of individual ADR files)
```

---

## V. EXAMPLES

### 5.1 Minimal CLAUDE.md (Week 1 Startup)

```markdown
# CLAUDE.md

**Project**: AI Chat API
**Stack**: FastAPI + PostgreSQL + Redis
**Phase**: MVP (Week 1)

## Identity

Solo project, building chat API with AI completions.

## Architecture

```
api/
├── main.py           → FastAPI app
├── models.py         → SQLAlchemy models
├── routes/           → API endpoints
└── services/         → Business logic
```

## Workflow

- **Branch**: `main` (no protection yet)
- **Commits**: `[TYPE] Description` (FEAT/FIX/DOCS)
- **Tests**: Run before commit: `pytest`

## Commands

```bash
# Dev server
uvicorn main:app --reload

# Tests
pytest --cov=api
```

**That's it.** ~30 lines, week 1 reality.
```

### 5.2 Production CLAUDE.md (Month 6)

See `CLAUDE.md` in this repository (Dreamforge project) for real-world example:
- 1,000 lines, production-grade
- 13 major sections
- 3 ADRs documenting critical decisions
- Troubleshooting matrix with 7 common issues
- Complete policy enforcement (prohibited/mandatory actions)

---

## VI. COMMON MISTAKES

### 6.1 Anti-Patterns

**1. Premature Documentation**
```yaml
mistake: "Writing 1,000-line CLAUDE.md on project day 1"
problem: "90% becomes outdated by day 30"
solution: "Start with 100 lines, grow organically"
```

**2. Aspirational Content**
```yaml
mistake: "Documenting planned workflows that don't exist"
problem: "AI suggests non-existent processes"
solution: "Document reality, not aspirations"
example_bad: "We use TDD" (when you don't)
example_good: "Tests optional for now, required before v1.0"
```

**3. README.md Duplication**
```yaml
mistake: "Copying README.md content into CLAUDE.md"
problem: "Maintain two sources of truth, inevitable drift"
solution: "CLAUDE.md = AI guidance, README.md = user docs"
```

**4. Abandonment**
```yaml
mistake: "Create CLAUDE.md, never update it"
problem: "Becomes misinformation, AI learns wrong patterns"
solution: "Update on major changes OR delete if unmaintained"
```

**5. Over-Engineering**
```yaml
mistake: "2,000-line CLAUDE.md with every possible detail"
problem: "Nobody reads it, too complex to maintain"
solution: "Keep <1,000 lines, split into multiple docs if needed"
```

### 6.2 Recovery from Mistakes

**If CLAUDE.md is outdated:**
```bash
# Option 1: Update to current reality
git checkout -b update-claude-md
[Edit CLAUDE.md to match current state]
git commit -m "[DOCS] Update CLAUDE.md to current reality"

# Option 2: Delete and restart
rm CLAUDE.md
cp CLAUDE-TEMPLATE.md CLAUDE.md
[Fill only what's true today]
```

**If CLAUDE.md is too large:**
```bash
# Split into multiple files
mkdir docs/
mv sections → docs/ARCHITECTURE.md
mv sections → docs/TROUBLESHOOTING.md
# Keep only core in CLAUDE.md
```

---

## VII. INTEGRATION WITH AI ASSISTANTS

### 7.1 How AI Assistants Use CLAUDE.md

**Claude Code:**
```yaml
behavior:
  - "Reads CLAUDE.md at session start"
  - "References policies when suggesting code"
  - "Follows commit message format specified"
  - "Respects prohibited actions"

visibility: "Full file content in context"
priority: "High (treats as authoritative)"
```

**GitHub Copilot:**
```yaml
behavior:
  - "Scans CLAUDE.md for code style hints"
  - "Suggests code matching tech stack"
  - "May not respect all policies (simpler model)"

visibility: "Partial (uses for context)"
priority: "Medium (style hints mainly)"
```

**Cursor:**
```yaml
behavior:
  - "Reads CLAUDE.md into workspace context"
  - "Uses for project-wide suggestions"
  - "Respects architectural constraints"

visibility: "Full file content"
priority: "High"
```

### 7.2 Verification

**Test if AI assistant reads CLAUDE.md:**

1. Add unique policy to CLAUDE.md:
   ```yaml
   policies:
     - "All function names must start with 'zz_'"
   ```

2. Ask AI: "Write me a function to add two numbers"

3. Expected: Function named `zz_add_numbers` (AI followed CLAUDE.md)

4. Actual: Function named `add_numbers` → AI didn't read file

**Troubleshooting:**
- Ensure CLAUDE.md is in repository root
- Check file is committed (not .gitignored)
- Start fresh AI session (reload context)

---

## VIII. FREQUENTLY ASKED QUESTIONS

**Q: CLAUDE.md vs README.md - what's the difference?**

```yaml
README.md:
  audience: "Humans (users, contributors)"
  content: "What the project does, how to use it"
  format: "Narrative, screenshots, examples"

CLAUDE.md:
  audience: "AI assistants"
  content: "How to contribute, what's allowed/forbidden"
  format: "Structured (YAML, tables), specs"
```

**Q: Should I commit CLAUDE.md to git?**

```yaml
answer: "YES, always commit to repository root"
rationale: "AI assistants need it in repository to read it"
exception: "Never commit if contains secrets (use .env instead)"
```

**Q: Can I have multiple CLAUDE.md files?**

```yaml
answer: "No, AI assistants look for CLAUDE.md in root only"
alternative: "Split large CLAUDE.md into referenced sub-docs"
pattern: |
  CLAUDE.md (core)
  ├── docs/ARCHITECTURE.md (referenced in CLAUDE.md)
  ├── docs/TROUBLESHOOTING.md
  └── adrs/ADR-001.md
```

**Q: How do I handle secrets/credentials?**

```yaml
answer: "NEVER put secrets in CLAUDE.md (public file)"
instead:
  - "Reference environment variables: ${DATABASE_URL}"
  - "Document in CLAUDE.md: 'See .env.example for required vars'"
  - "Use .env.example (committed) + .env (gitignored)"
```

**Q: What if my team doesn't use AI assistants?**

```yaml
answer: "CLAUDE.md still valuable as machine-readable docs"
benefits:
  - "Structured onboarding documentation"
  - "Single source of truth for conventions"
  - "Future-proof when team adopts AI tools"
alternative: "Skip CLAUDE.md, use CONTRIBUTING.md instead"
```

---

## IX. REAL-WORLD CASE STUDIES

### 9.1 Dreamforge (This Repository)

**Context:**
- AI character creation system
- Phase: Course building (post-infrastructure)
- Team: CEO + CTO (Claude Code)

**CLAUDE.md evolution:**
```yaml
v1.0:
  size: "600 lines"
  style: "Narrative, friendly"
  sections: "Basic structure, workflow, troubleshooting"

v2.0_nuclear:
  size: "1,000 lines"
  style: "Ruthless, zero-fluff, specification-grade"
  sections: "13 major sections, 3 ADRs, policy enforcement"

impact:
  - "Claude Code follows conventions 100% of time"
  - "No re-explaining git workflow across sessions"
  - "Production scripts marked IMMUTABLE (enforced)"
  - "Clear escalation: technical (CTO) vs product (CEO)"
```

**Key insight**: "CLAUDE.md v2.0 turned AI from assistant to team member with perfect institutional memory"

### 9.2 Example: Startup MVP

**Context:**
- SaaS product, 3-person team
- Phase: MVP (month 2)
- Stack: Next.js + Supabase

**CLAUDE.md stats:**
```yaml
size: "350 lines"
sections:
  - "Identity + tech stack"
  - "File structure"
  - "Git workflow (feature branches)"
  - "Commit format"
  - "Prohibited: Direct commits to main"
  - "Mandatory: Run prettier before commit"

impact:
  - "All 3 developers + AI follow same commit format"
  - "0 direct commits to main (prevented by CLAUDE.md)"
  - "Onboarding new developer: 1 hour (vs 1 day before)"
```

**Key insight**: "Minimal CLAUDE.md (350 lines) gave 90% of value vs complex setup"

---

## X. DOCUMENT METADATA

```yaml
document:
  name: "CLAUDE-GUIDE.md"
  type: "Meta-Documentation"
  version: "1.0.0"
  status: "Living Document"

ownership:
  author: "Claude (AI Assistant Collective Wisdom)"
  maintainer: "Community"

review_schedule:
  frequency: "As AI assistant capabilities evolve"
  next_review: "When new AI tools emerge with different CLAUDE.md support"
```

---

## FINAL RECOMMENDATIONS

**Start here:**
1. Copy `CLAUDE-TEMPLATE.md` to `CLAUDE.md`
2. Delete Sections IV-IX (add later when needed)
3. Fill Sections I-III (Identity, Architecture, Workflow)
4. Commit to repository root
5. Start AI session, verify it reads CLAUDE.md

**Grow organically:**
- Week 1: Sections I-III (100-200 lines)
- Month 1: Add Section IV (Policies)
- Month 3: Add Section V (ADRs) as decisions are made
- Production: Add Section VI (Troubleshooting) from real issues

**Maintain ruthlessly:**
- Update on major changes (architecture, team, tech)
- Delete outdated content immediately
- Keep <1,000 lines (split if larger)
- Review monthly or quarterly

**When in doubt:**
- Document reality, not aspirations
- Be specific, not vague
- Delete rather than keep outdated content
- Start minimal, grow with project complexity

**End of Guide**
