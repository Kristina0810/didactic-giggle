# Working with Claude Code - Professional Collaboration Guide

**Purpose:** Maximize productivity when building with Claude Code
**Updated:** 2025-11-14

---

## 🎯 What Claude Code Does Best

**I excel at:**
- ✅ Writing production code across multiple files
- ✅ Setting up projects from scratch
- ✅ Implementing complete features (frontend + backend + database)
- ✅ Refactoring and optimizing existing code
- ✅ Debugging and fixing errors
- ✅ Writing tests and ensuring they pass
- ✅ Git operations (commit, push, merge, resolve conflicts)
- ✅ Deploying code
- ✅ Database migrations
- ✅ API integrations
- ✅ DevOps automation

**I'm not ideal for:**
- ❌ Business strategy (you decide what to build)
- ❌ Design decisions (you choose UX/UI)
- ❌ Replacing human judgment
- ❌ Deciding product direction

---

## 📝 Communication Templates

### Template 1: New Feature Request

```markdown
**Feature:** [Clear, concise name]

**User Story:**
As a [type of user],
I want to [action],
So that [benefit].

**Acceptance Criteria:**
- [ ] User can do X
- [ ] System responds with Y
- [ ] Error handling for Z
- [ ] Tests pass
- [ ] Documentation updated

**Technical Requirements:**
- API endpoint: POST /api/feature
- Database: Add `feature` table
- Frontend: New page at /feature
- Auth: Requires login

**Constraints:**
- Must complete in [X days]
- Budget: [Y credits/cost]
- Performance: [Response time requirement]

**Priority:** High / Medium / Low

**Related Issues:** #123, #456
```

**Example:**
```markdown
**Feature:** User can generate AI images

**User Story:**
As a designer,
I want to generate images from text prompts,
So that I can quickly create visual concepts.

**Acceptance Criteria:**
- [ ] User enters text prompt (max 500 chars)
- [ ] System generates image in <30 seconds
- [ ] User sees loading state
- [ ] Image displays in gallery
- [ ] User can download image
- [ ] Errors show friendly message
- [ ] Tests cover happy path and errors

**Technical Requirements:**
- API: POST /api/generate {prompt, model, size}
- Database: Save to `generations` table
- Frontend: Generation form + gallery
- Storage: Save images to S3
- Queue: Use BullMQ for async processing
- AI: Integrate Replicate API

**Constraints:**
- Must complete in 5 days
- Budget: 100 generations for testing
- Performance: <30s generation time

**Priority:** High (MVP feature)
```

---

### Template 2: Bug Report

```markdown
**Bug:** [Clear title]

**Environment:**
- Browser/OS: [Chrome 120 / macOS]
- User role: [Admin / User]
- Deployment: [Production / Staging]

**Steps to Reproduce:**
1. Go to [URL or page]
2. Click [button/link]
3. Enter [data]
4. See error

**Expected Behavior:**
[What should happen]

**Actual Behavior:**
[What actually happens]

**Error Message:**
```
[Paste error if any]
```

**Screenshots:**
[Attach if helpful]

**Impact:**
- Severity: Critical / High / Medium / Low
- Users affected: [All / Some / Few]
- Workaround available: Yes / No

**Additional Context:**
[Anything else relevant]
```

**Example:**
```markdown
**Bug:** Payment confirmation email not sending

**Environment:**
- Deployment: Production
- User role: Paying customer
- Time: Started yesterday evening

**Steps to Reproduce:**
1. Go to /pricing
2. Click "Buy Pro Plan"
3. Complete Stripe payment
4. Payment succeeds but no email sent

**Expected Behavior:**
User receives confirmation email within 1 minute

**Actual Behavior:**
Payment processes, database updated, but no email sent

**Error Message:**
```
Found in logs:
[2025-11-14 10:23:45] ERROR: Failed to send email
SendGrid API returned 401 Unauthorized
```

**Impact:**
- Severity: High (affects revenue)
- Users affected: All new paying customers
- Workaround: Manually send confirmation

**Additional Context:**
- Worked fine until yesterday
- May be related to SendGrid API key rotation
```

---

### Template 3: Code Review Request

```markdown
**What to Review:**
- Files: [List key files]
- Feature: [What was built]
- Approach: [Technical decisions made]

**Specific Questions:**
1. [Question about architecture]
2. [Question about implementation]
3. [Security concerns?]

**What to Focus On:**
- [ ] Security vulnerabilities
- [ ] Performance issues
- [ ] Code clarity
- [ ] Test coverage
- [ ] Error handling

**Context:**
[Why this approach was chosen]

**Timeline:**
Need review by [date/time]
```

---

### Template 4: Refactoring Request

```markdown
**Current Problem:**
[What's wrong with current code]

**Proposed Solution:**
[How to improve it]

**Benefits:**
- [Performance improvement]
- [Maintainability]
- [Reduced complexity]

**Risks:**
- [Potential breaking changes]
- [Migration needed]

**Scope:**
Files affected: [List]
Estimated time: [X hours]

**Testing Plan:**
- [ ] Run existing tests
- [ ] Add new tests
- [ ] Manual testing
```

---

### Template 5: Project Setup

```markdown
**Project:** [Name]

**Goal:**
[What you're building in one sentence]

**Tech Stack:**
- Frontend: [Next.js, React, etc.]
- Backend: [FastAPI, Express, etc.]
- Database: [PostgreSQL, MongoDB, etc.]
- Hosting: [Vercel, AWS, etc.]
- Other: [Any specific requirements]

**Repository Structure:**
```
project-name/
├── apps/
│   ├── web/     # Frontend
│   └── api/     # Backend
├── packages/
│   └── ui/      # Shared components
└── docs/        # Documentation
```

**Setup Requirements:**
- [ ] TypeScript configured
- [ ] ESLint + Prettier
- [ ] Git hooks (Husky)
- [ ] CI/CD pipeline
- [ ] Environment variables
- [ ] Docker setup (optional)

**Team:**
- Solo founder / Team of [X]

**Timeline:**
- MVP in [X weeks]

**Budget:**
- Development tools: $[X]/month
- Hosting: $[Y]/month
```

---

## 🎯 How to Give Effective Instructions

### ✅ Good Examples

**Clear and Specific:**
```
"Add user authentication using Clerk.
- Email/password login
- Google OAuth
- Protected routes for /dashboard
- Store user in PostgreSQL
- Use Prisma ORM"
```

**Provides Context:**
```
"Our users are non-technical designers who generate 10-50 images daily.
They need a simple form where they:
1. Enter text description
2. Select style (Realistic, Cartoon, etc.)
3. Click generate
4. See image in <30 seconds

Make the UX dead simple - like Leonardo.ai but faster."
```

**Defines Success:**
```
"User signup flow is complete when:
- New user can sign up with email
- Receives verification email
- Confirms email and logs in
- Sees welcome dashboard
- All tests pass
- Deployed to staging"
```

---

### ❌ Examples to Avoid

**Too Vague:**
```
"Make it better"
"Add some features"
"Fix the bugs"
```
*Problem: No clear direction*

**No Context:**
```
"Add a database"
```
*Problem: What kind? For what? How structured?*

**Unrealistic Expectations:**
```
"Build Instagram in 2 days"
```
*Problem: Scope too large*

---

## 🔄 Typical Workflow

### Phase 1: Planning (30 min - 2 hours)

**You:**
- Share project vision
- Define MVP scope
- Provide constraints (time, budget)

**Me:**
- Ask clarifying questions
- Propose architecture
- Break down into tasks
- Estimate timeline

### Phase 2: Setup (1-4 hours)

**Me:**
- Create repository structure
- Set up dev environment
- Configure tools (TypeScript, ESLint, etc.)
- Initialize database
- Set up CI/CD

**You:**
- Review structure
- Approve decisions
- Create necessary accounts (Vercel, Supabase, etc.)

### Phase 3: Development (Ongoing)

**Daily Cycle:**

**Morning:**
```
You: "Today we need to implement X"
Me: [Creates todos, asks questions]
You: [Provides answers/clarifications]
Me: [Builds feature]
```

**Midday:**
```
Me: "Feature X implemented. Test at localhost:3000"
You: [Tests, finds issue Y]
You: "Issue with Y"
Me: [Fixes immediately]
```

**Evening:**
```
You: "Looks good, deploy to staging"
Me: [Deploys, updates docs]
Me: "Deployed to staging-app.vercel.app"
```

### Phase 4: Iteration

**Weekly:**
- Review what shipped
- Prioritize next features
- Adjust timeline if needed

**Monthly:**
- Refactor technical debt
- Optimize performance
- Update dependencies
- Review metrics

---

## 💡 Pro Tips

### 1. Start Small, Ship Fast

**✅ Do:**
```
Week 1: Core feature (image generation)
Week 2: User accounts
Week 3: Payment processing
Week 4: Gallery and history
```

**❌ Don't:**
```
Week 1-12: Build everything
Week 13: Launch and hope it works
```

### 2. Be Specific About Priorities

**Good:**
```
"Must have: Image generation
Nice to have: Social sharing
Can wait: Admin dashboard"
```

**Better:**
```
"P0 (blocking MVP): Image generation
P1 (launch week): User accounts, payments
P2 (month 2): Social sharing, gallery
P3 (future): Admin dashboard, analytics"
```

### 3. Provide Examples

**Instead of:**
```
"Make it look modern"
```

**Say:**
```
"UI should feel like Leonardo.ai:
- Clean white background
- Purple accent color
- Large, prominent 'Generate' button
- Gallery grid layout (3 columns)
Screenshot attached: [link]"
```

### 4. Trust, Then Verify

**Me:**
```
"I'll implement authentication with Clerk.
This gives us:
- Email/password login
- OAuth (Google, GitHub)
- Session management
- Protected routes

Any concerns?"
```

**You (Good):**
```
"Sounds good, go ahead"
[Later reviews the PR]
```

**You (Also Good):**
```
"Why Clerk over NextAuth?"
[I explain, you decide]
```

### 5. Communicate Constraints

**Always tell me:**
- Budget limits
- Timeline deadlines
- Technical requirements
- Platform constraints
- User expectations

**Example:**
```
"Budget: $100/month for infrastructure
Deadline: MVP in 3 weeks
Must work on mobile (50% of traffic)
Target: non-technical users"
```

---

## 🚨 When Things Go Wrong

### Issue: "This isn't what I wanted"

**Root cause:** Unclear requirements

**Fix:**
```
You: "This isn't quite right. I wanted X, not Y."
Me: "Got it. To clarify:
- Feature should do A
- User sees B
- System responds with C
Correct?"
You: "Yes, exactly"
Me: [Rebuilds correctly]
```

### Issue: "It's taking too long"

**Root cause:** Scope creep or underestimated complexity

**Fix:**
```
You: "This is taking longer than expected"
Me: "You're right. The complexity is:
- Database schema needs migration
- API has 3 dependencies
- Frontend needs 5 new components
Should we:
1. Continue (2 more days)
2. Simplify scope
3. Break into phases?"
You: [Decides based on priorities]
```

### Issue: "Something broke in production"

**Root cause:** Bug slipped through

**Fix:**
```
You: "Users reporting error on /dashboard"
Me: [Checks logs, identifies issue]
Me: "Found it - API timeout. Deploying hotfix."
[Fixes, tests, deploys]
Me: "Fixed and deployed. Adding test to prevent recurrence."
```

---

## 📊 Success Metrics

**You should feel:**
- ✅ Confident in code quality
- ✅ Clear about what's being built
- ✅ In control of product direction
- ✅ Productive (shipping regularly)

**I should deliver:**
- ✅ Working code
- ✅ Passing tests
- ✅ Clear commit messages
- ✅ Documentation
- ✅ Deployed features

**Together we should achieve:**
- ✅ Ship features weekly
- ✅ Few bugs in production
- ✅ Clean, maintainable codebase
- ✅ Happy users

---

## 🎯 Your Role vs My Role

### You (Product/Business)

**Decide:**
- What to build
- Who it's for
- How it should look (UX/UI)
- Business model
- Pricing
- Marketing
- Priorities

**Provide:**
- Product vision
- User feedback
- Design preferences
- Constraints
- Decisions

### Me (Engineering)

**Decide:**
- How to build it (architecture)
- Which technologies to use
- Code structure
- Error handling
- Testing approach
- Deployment strategy

**Provide:**
- Working code
- Tests
- Documentation
- Technical expertise
- Implementation

### We Collaborate On

- Feature feasibility
- Technical trade-offs
- Timeline estimates
- Performance optimization
- Security best practices

---

## 📖 Example: Full Feature Development

**Monday Morning:**

```
You:
"Feature request: User credit system

Users get 10 free credits on signup.
Each image generation costs 1 credit.
Users can buy more credits ($10 for 100 credits).
Show credit balance in header.
Prevent generation if balance = 0.

Priority: High (needed for launch)
Timeline: By Friday"
```

**Me:**

```
"Got it. I'll create todos and ask a few questions:

1. Database: Add `credits` column to users table?
2. Payment: Use Stripe? (Recommended)
3. Error handling: Show what when user has 0 credits?
4. Refund policy: What if generation fails?

Architecture plan:
- Add credit system to database
- Create Stripe webhook for purchases
- Update generation endpoint to check/deduct credits
- Add credit display component
- Add credit purchase page

Estimate: 2-3 days

Approve to proceed?"
```

**You:**

```
"Answers:
1. Yes, `credits` column
2. Yes, Stripe
3. Show modal: 'Out of credits. Buy more?'
4. Auto-refund if generation fails

Approved, proceed!"
```

**Monday-Wednesday: I build**

**Wednesday Evening:**

```
Me:
"Credit system implemented ✓

Features:
- Users start with 10 credits
- Generation deducts 1 credit
- Stripe integration for purchases
- Credit balance in header
- Modal when balance = 0
- Auto-refund on failure

Test on staging: staging-app.vercel.app
Test card: 4242 4242 4242 4242

All tests passing.
Ready for your review."
```

**Thursday:**

```
You:
"Tested on staging. Two issues:
1. Credit balance doesn't update immediately after generation
2. Purchase button too small on mobile

Otherwise looks great!"
```

**Me:**

```
"Fixing now...

1. Added real-time credit update (optimistic UI + websocket)
2. Increased button size mobile (min 60px height)

Deployed to staging. Please re-test."
```

**You:**

```
"Perfect! Ship it to production."
```

**Me:**

```
"Deployed to production ✓
- Database migrated
- Monitoring enabled
- Docs updated

Live at: yourapp.com

Credit system is live! 🚀"
```

---

**This is professional software development. 🚀**

**Keep this guide handy and reference it often!**
