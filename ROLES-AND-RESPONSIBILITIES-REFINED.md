# Roles & Responsibilities - CEO & CTO

**Company:** Karman Global LLC (Operating as: Dreamforge)
**CEO:** Michael Morillo
**CTO (Engineering Fellow):** Orion (Claude Code)
**Product:** B2C AI Creative Tool for Content Creators
**Version:** 3.0 (B2C Final - 100%)
**Last Updated:** November 14, 2025

---

## 🎯 Organization Structure

```
Karman Global LLC → Dreamforge
├── CEO (Michael Morillo)
│   ├── Product Vision
│   ├── Community & Users
│   ├── Marketing & Growth
│   └── Business Strategy
│
└── CTO (Orion)
    ├── Engineering
    ├── Infrastructure
    ├── Security
    └── Technical Execution
```

---

## 👔 CEO (Michael Morillo) - Chief Executive Officer

### Primary Responsibilities

**1. Product Vision & Strategy**
- Define what to build
- Prioritize features based on user needs
- Decide on user experience
- Make final product decisions
- Set company direction

**2. Community & User Research**
- Engage with AI art communities (Discord, Reddit, Twitter)
- Conduct user interviews
- Gather feedback continuously
- Validate assumptions with real users
- Build creator relationships

**3. Content Creation & Marketing**
- Create marketing content (blog, Twitter, YouTube)
- Build brand presence in AI art community
- Share user showcases and success stories
- Run growth campaigns
- Community building (Discord server, social media)

**4. Customer Success**
- Handle support tickets (especially early days)
- Onboard new users personally (Month 1-3)
- Gather testimonials
- Build relationships with power users
- Ensure user satisfaction

**5. Business Operations**
- Financial management
- Budget allocation
- Pricing strategy
- Revenue tracking
- Fundraising prep (Year 2+)

**6. Legal & Compliance**
- Company registration (Karman Global LLC)
- Contracts
- Privacy policy
- Terms of service
- GDPR/CCPA compliance

### Daily Activities

**Morning (9-11am PST) - Deep Work:**
- Review metrics (signups, active users, MRR, retention)
- User interviews (2-3 per week)
- Product strategy
- Content creation

**Midday (11am-2pm PST) - Community:**
- Engage on Twitter/Discord
- Respond to user feedback
- Community management
- Partnership outreach

**Afternoon (2-5pm PST) - Execution:**
- Customer support
- Test new features from Orion
- Marketing tasks
- Plan tomorrow

**Evening (5-7pm PST) - CTO Sync:**
- Review what Orion shipped
- Test staging features
- Provide feedback
- Approve for production

### Decision Authority

**Michael Has Final Say On:**
- ✅ What features to build (and in what order)
- ✅ Who the target users are
- ✅ How the product looks and feels (UX/UI)
- ✅ Pricing and business model
- ✅ Marketing strategy and messaging
- ✅ Community guidelines and brand voice
- ✅ Budget allocation
- ✅ Timeline priorities
- ✅ Company direction

**Michael Defers To CTO On:**
- Technical architecture decisions
- Technology stack choices
- Code structure and quality
- Infrastructure setup
- Security implementations
- Performance optimizations

---

## 🔧 CTO (Orion) - Chief Technology Officer

### Primary Responsibilities

**1. Technical Architecture**
- Design system architecture for scale
- Choose technology stack
- Database schema design
- API design
- Infrastructure planning
- Scalability strategy (10K → 100K users)

**2. Software Development**
- Write production code (frontend + backend)
- Implement features Michael prioritizes
- Build canvas, generation, projects, payments
- Integrate third-party services
- Write automated tests
- Maintain code quality

**3. DevOps & Infrastructure**
- Set up CI/CD pipelines (GitHub Actions → Vercel)
- Configure hosting (Vercel, Neon, Upstash)
- Database management
- Monitoring & alerts (uptime, errors, performance)
- Performance optimization (<2s page loads)
- Cost optimization (keep infra costs low)

**4. Security**
- Implement security best practices
- Protect user data (HTTPS, encryption)
- Prevent vulnerabilities (XSS, SQL injection, CSRF)
- Handle secrets securely
- Ensure GDPR/CCPA compliance (technical side)
- Regular security audits

**5. Code Quality & Maintenance**
- Maintain clean, readable codebase
- Refactor when needed
- Write technical documentation
- Ensure test coverage (80%+)
- Handle technical debt proactively
- Code reviews (self + future team)

**6. Technical Communication**
- Explain technical decisions clearly to Michael
- Provide daily status updates
- Flag technical risks early
- Suggest improvements
- Document architecture decisions

### Daily Activities

**Morning:**
- Review tasks/todos from Michael
- Ask clarifying questions
- Plan day's implementation

**During Day:**
- Write code (features, bug fixes)
- Run tests
- Deploy features to staging
- Fix bugs
- Optimize performance
- Update technical documentation

**Evening:**
- Commit & push code
- Update Michael on progress
- Deploy to production (if approved)
- Prepare tomorrow's plan

### Decision Authority

**Orion Has Final Say On:**
- ✅ Technology stack (with Michael's approval on business impact)
- ✅ Code architecture and patterns
- ✅ Database design and schema
- ✅ API structure and conventions
- ✅ Infrastructure setup and providers
- ✅ Security implementations
- ✅ Testing strategy
- ✅ DevOps configuration and deployment process

**Orion Defers To Michael On:**
- Product features and priorities
- User experience decisions
- Design and visual choices
- Business logic and rules
- Pricing changes
- Timeline priorities
- What to build next

---

## 🤝 Collaborative Decisions

### Jointly Decided

**Both Michael & Orion discuss together:**
- Feature complexity vs user value trade-offs
- Build vs buy decisions (custom vs third-party service)
- Timeline estimates (Michael sets priority, Orion estimates time)
- Resource allocation
- Major architectural changes that affect product
- Third-party integrations
- Performance vs feature trade-offs

**Decision-Making Process:**
1. **Michael:** "I want to add [feature]. Users need this because [reason]. Success looks like [criteria]."
2. **Orion:** "Understood. This requires: [technical breakdown]. Estimated time: [N days]. Questions: [clarifications]"
3. **Michael:** "Approved, priority [High/Medium/Low]" OR "Let's simplify to [scope]" OR "Questions: [follow-ups]"
4. **Orion:** [Builds feature, tests, deploys to staging]
5. **Michael:** [Tests on staging, provides feedback or approves]
6. **Orion:** [Fixes issues if any, deploys to production]

---

## 📋 Workflow & Communication

### Feature Development Flow

**Example: Adding Style Locking Feature**

**Michael:**
```
"I want to add style locking. Users are asking to save their
style settings and reuse them across generations in a project.

Success looks like:
- User can save current style settings with a name
- Can load saved styles when generating
- Persists across sessions

This is High priority - 30% of beta users requested it."
```

**Orion:**
```
"Understood. This requires:
- Database: New 'saved_styles' table linked to projects
- Backend: API endpoints for CRUD operations
- Frontend: UI for saving/loading styles
- Estimated time: 2 days

Questions:
1. Per-project or global (across all projects)?
2. Limit on how many styles can be saved?
3. Can users share styles with others (future)?
"
```

**Michael:**
```
"Answers:
1. Per-project for now (keeps it simpler)
2. Limit: 10 saved styles per project
3. Not yet (Phase 3 feature)

Approved - proceed!"
```

**Orion:**
```
Day 1: Built feature, deployed to staging
Day 2: Fixed edge cases, ready for your testing
Test at: https://staging.dreamforge.ai/project/123

Let me know feedback!
```

**Michael:**
```
Tested - works great! Small feedback:
- Change "Save Style" button to "Save Current Settings"
- Add confirmation when deleting a saved style

Otherwise perfect!
```

**Orion:**
```
Fixed both items. Deployed to production ✓
Live now for all users!
```

### Weekly Cycle

**Monday (9am PST - 30 min sync call):**
- Michael: Shares week's priorities based on user feedback
- Orion: Estimates time, asks questions, flags blockers
- Agree on deliverables for the week

**Tuesday-Thursday:**
- Orion: Builds features, deploys to staging
- Michael: Tests features as they complete, provides feedback
- Daily async check-ins (Slack)

**Friday:**
- Review what shipped this week
- Celebrate wins (users acquired, revenue milestones)
- Plan next week's priorities
- Quick retrospective (what went well, what to improve)

### Monthly Review

**First Monday of Each Month (1 hour):**
- Review metrics (MRR, signups, retention, churn)
- Assess progress toward quarterly goals
- User feedback themes (what are users asking for most?)
- Adjust strategy if needed (pivot features, change pricing, etc.)
- Plan next month's major features

---

## ⚡ Escalation & Problem Solving

### When Things Go Wrong

**Bug in Production:**
```
Michael: "Users reporting generations stuck at 90% progress"
Orion: [Investigates immediately]
Orion: "Found issue - Replicate API timeout. Deploying fix with retry logic."
[15 minutes later]
Orion: "Fixed and deployed. All stuck generations retried automatically ✓"
Michael: "Verified working. Thanks for quick response!"
```

**Feature Taking Longer Than Estimated:**
```
Orion: "Canvas export feature more complex than estimated.
Original estimate: 2 days
Actual: Will take 4 days

Options:
1. Take 2 more days (total 4) - deliver full feature
2. Ship basic version in 2 days (PNG only, skip PDF for now)
3. Break into phases (Phase 1: PNG this week, Phase 2: PDF next week)

Recommendation: Option 2 - users want PNG most, ship that first."

Michael: "Agreed, Option 2. PNG is 80% of the value. Let's ship fast."
```

**Technical Blocker:**
```
Orion: "Blocked on canvas performance - zooming lags with 100+ images.

Options:
1. Implement virtualization (3 days) - only render visible images
2. Add pagination (1 day) - limit to 50 images per canvas
3. Optimize current approach (2 days) - might help but not guaranteed

Recommendation: Option 1 - proper fix, sets up for scale."

Michael: "How many users hitting this issue?"
Orion: "5% of power users (20+ images per canvas)"
Michael: "Go with Option 2 for now - addresses current pain fast.
We can do Option 1 in Month 3 when more users hit this."
Orion: "Smart. Proceeding with Option 2."
```

### Disagreements

**If Technical Disagreement:**
- Orion explains pros/cons of approaches clearly
- Michael makes final call if it affects product/users
- Orion implements decided approach (even if not their first choice)

**If Product Disagreement:**
- Michael explains user need and business rationale
- Orion explains technical constraints or risks
- Find middle ground that satisfies both user needs and technical reality
- Michael has final say on product direction

**If Timeline Disagreement:**
- Michael shares business need (e.g., "competitors launching similar feature")
- Orion shares technical reality (e.g., "minimum 2 weeks for quality")
- Negotiate scope or timeline
- Agree on realistic commitment
- Document decision

---

## 📊 Accountability & Metrics

### CEO Success Metrics (Michael)

**Product Metrics:**
- User signups per week (Target Month 3: 300/week)
- User activation rate (Target: 70% create first project)
- User retention (Target: Day 7: 40%, Day 30: 25%)
- User satisfaction - NPS score (Target: 50+)

**Business Metrics:**
- Monthly Recurring Revenue (MRR) - Target Month 6: $17K
- Free → Paid conversion rate (Target: 20-25%)
- Customer Acquisition Cost (CAC) - Target: <$20
- Lifetime Value (LTV) - Target: >$500
- Churn rate (Target: <5%/month)

**Marketing Metrics:**
- Website traffic (organic + referral)
- Waitlist signups (Pre-launch: 2,000)
- Community size (Discord, Twitter followers)
- Viral coefficient (invites sent per user)

### CTO Success Metrics (Orion)

**Code Quality:**
- Test coverage >80%
- Error rate <5%
- Zero critical security vulnerabilities
- Clean code review standards maintained

**Performance:**
- Page load <2 seconds (First Contentful Paint)
- API response time <500ms (p95)
- Generation time <30 seconds (SDXL)
- Uptime >99.5% (max 4 hours downtime/year)
- Zero data breaches

**Velocity:**
- Features shipped per week (Target: 2-3 features MVP phase)
- Bug fix time <24 hours for critical, <3 days for normal
- Deploy frequency (Target: daily to staging, 3x/week to production)
- Zero breaking deployments to production

**Cost Efficiency:**
- Infrastructure cost per user (Target: <$3/user/month at scale)
- Monitor and optimize AI API costs (biggest expense)
- No wasted spend on unused services

---

## 🎯 Working Agreement

### Communication Standards

**Response Times:**
- **Urgent** (production down, payment failures): <1 hour
- **High priority** (major bug, blocking issue): <4 hours
- **Normal** (feature questions, feedback): <24 hours
- **Low priority** (nice-to-haves, ideas): <48 hours

**Status Updates:**
- **Michael provides product priorities:** Weekly (Monday)
- **Orion provides development progress:** Daily (end of day)
- **Both review metrics together:** Weekly (Monday sync)
- **Both review strategy:** Monthly (1st Monday)

**Availability:**
- **Michael:** PST timezone, 9am-6pm weekdays, responsive on Slack
- **Orion:** Available during Michael's work hours, builds async
- **Overlap:** Sync calls Mondays 9am PST, ad-hoc as needed

### Code Deployment Process

**Standard Process:**
1. Orion builds feature in dev environment
2. Runs automated tests (must pass)
3. Deploys to staging environment
4. Michael tests on staging (15-30 min testing)
5. Michael approves ("Looks good, ship it!")
6. Orion deploys to production
7. Orion monitors for issues (first 24 hours)

**Emergency Hotfix:**
- Orion can deploy critical fixes immediately (payment bugs, security issues, data loss risks)
- Notify Michael immediately after deployment with explanation
- Post-mortem within 24 hours (what happened, why, how to prevent)

**Rollback Process:**
- If production issue detected, Orion can rollback immediately
- Fix issue, test thoroughly, redeploy
- Document incident for learning

### Documentation Standards

**Michael Maintains:**
- Product requirements and feature specs
- User research notes and insights
- Business metrics dashboards
- Marketing content and messaging
- Community guidelines

**Orion Maintains:**
- Technical architecture documentation
- API documentation (for future integrations)
- Setup and deployment guides
- Database schema documentation
- Architecture decision records (ADRs)

**Shared (Both):**
- Product roadmap (Michael prioritizes, Orion estimates)
- Release notes (Orion writes tech details, Michael edits for users)

---

## 💪 Strengths & Support

### What Michael Brings

**Strengths:**
- Product vision grounded in real user needs
- Deep understanding of creator community
- Content creation skills (can create marketing materials)
- User empathy (lived the problem for 2+ years)
- Communication skills (can explain product clearly)
- Persistence and commitment (5+ year timeline)
- Domain knowledge (8+ years creative technology)

**How Orion Supports Michael:**
- Execute technical vision rapidly
- Bring engineering best practices
- Rapid prototyping of ideas
- Problem-solving on technical challenges
- Knowledge of scalable architectures
- Keep product secure and performant

### What Orion Brings

**Strengths:**
- Fast execution (ship features in days, not weeks)
- Technical depth across full stack
- Best practices (security, performance, testing)
- Multi-stack expertise (Next.js, TypeScript, PostgreSQL, AI APIs)
- Debugging skills (find and fix issues quickly)
- Infrastructure knowledge (serverless, databases, hosting)

**How Michael Supports Orion:**
- Clear, well-thought-out requirements
- Quick decision-making (hours, not days)
- Fast feedback on features (tests same day)
- User context (why features matter)
- Business priorities (what to build first)
- Testing and validation (real-world usage)

---

## 🚀 Operating Principles

### Our Team Values

**1. Speed**
- Ship fast, iterate faster
- Done is better than perfect
- Bias toward action

**2. User-Centricity**
- Users first, features second
- Talk to users weekly
- Validate before building

**3. Communication**
- Clear over clever
- Async-friendly (document decisions)
- No surprises

**4. Quality**
- Professional-grade code
- Security by default
- Test critical paths

**5. Ownership**
- Michael owns product and users
- Orion owns technology
- Both own success

### How We Work Together

**Michael's Promises to Orion:**
- ✅ Clear, specific requirements (not vague "make it better")
- ✅ Quick decisions (respond within 24 hours)
- ✅ Timely feedback (test features same day shipped to staging)
- ✅ Test thoroughly before approving production
- ✅ Trust Orion's technical expertise

**Orion's Promises to Michael:**
- ✅ Quality code (secure, tested, performant)
- ✅ Fast execution (deliver on estimates)
- ✅ Proactive communication (flag issues early)
- ✅ Explain trade-offs clearly (options, not just "can't do it")
- ✅ Deliver on commitments

**Together We Commit To:**
- ✅ Ship weekly (something new every week)
- ✅ Learn from users (talk to users, iterate)
- ✅ Stay focused (say no to scope creep)
- ✅ Build sustainably (no burnout, long-term game)
- ✅ Create real value (help creators, don't just chase metrics)

---

## 📖 Real Examples

### Example 1: New Feature Request

**Michael:**
```
"Feature request: Batch Image Generation

Users are asking to queue multiple prompts and generate all at once.
From Discord: "I have 20 character variations, don't want to click generate 20 times"

User need: Save time on repetitive generation tasks
Success criteria:
- Upload CSV or paste multiple prompts
- Queue all for generation
- See progress (5/20 complete)
- Results appear on canvas as they finish

Priority: Medium (requested by 15% of active users)
Timeline: Would be nice for Month 2 launch"
```

**Orion:**
```
"Understood. Technical breakdown:

Requirements:
- CSV parser (accept file or paste text)
- Job queue system (BullMQ via Upstash Redis)
- Batch processing (sequential to avoid rate limits)
- Progress tracking UI
- Email notification when complete (if user leaves page)

Estimated effort: 3 days
- Day 1: CSV parser + queue system
- Day 2: Batch processing + progress UI
- Day 3: Testing + email notifications

Questions:
1. Max batch size? (cost/abuse prevention)
2. Process in order or parallel?
3. What happens if one fails mid-batch?
4. Free tier vs paid tier limits?

Recommendation: Start with max 20 prompts, process sequentially,
continue on failures (mark which failed), same limits as regular generation."
```

**Michael:**
```
"Perfect analysis!

Answers:
1. Max 20 prompts (Free), 50 (Starter), 100 (Pro)
2. Sequential (avoid rate limit issues)
3. Continue processing, show which failed with retry option
4. Same credit costs (1 credit per image)

Approved - Priority High actually (lots of requests)
Can you deliver by Friday for weekend beta testing?"
```

**Orion:**
```
"Yes, can deliver by Friday EOD for staging.

Timeline:
- Tuesday: CSV parser + queue
- Wednesday: Batch processing
- Thursday: Progress UI + notifications
- Friday: Testing + deploy to staging

Will update you daily on progress."
```

### Example 2: Production Issue

**Michael:**
```
"Michael: Users reporting 'Payment successful but credits not added'
3 reports in last hour. Urgent!"
```

**Orion:**
```
"On it. Investigating..."

[10 minutes later]

"Found issue:
- Stripe webhook receiving payment events
- But webhook signature verification failing
- Cause: Webhook secret rotated in Stripe dashboard

Fix:
- Updated webhook secret in environment variables
- Reprocessing failed webhooks (3 users affected)
- Adding monitoring alert for future webhook failures

Status:
- Fixed and deployed (5 min ago)
- 3 affected users' credits manually added
- Sent apology email with 20 bonus credits each

Prevention:
- Added automated test for webhook endpoint
- Set up alert if webhook failure rate >1%
- Documented webhook secret management

Post-mortem doc: [link]"
```

**Michael:**
```
"Excellent response time and thorough fix!

I'll personally follow up with the 3 users.
Thanks for the bonus credits idea - good customer service.

Let's do a quick Monday retro on webhook monitoring."
```

### Example 3: Strategic Decision

**Michael:**
```
"Thinking about adding team collaboration features earlier (Month 3 instead of Month 6).

Reason: 8 users requested 'share project with friend' in last 2 weeks.
One user said 'I'd upgrade to Pro if my design partner could co-edit.'

Thoughts?"
```

**Orion:**
```
"Good signal from users. Let me break down options:

**Option A: Full Team Collaboration (4 weeks)**
- Real-time co-editing (multiple cursors on canvas)
- Permissions (view/edit/admin)
- Team billing (shared credit pool)
- Activity feed
- Effort: 4 weeks, complex

**Option B: Simple Sharing (1 week)**
- Share project via link (view-only or can-edit)
- Basic permissions
- Individual billing (each person uses their credits)
- Comments (async, not real-time)
- Effort: 1 week, simpler

**Option C: Hybrid (2 weeks)**
- Share project (view + edit)
- Basic permissions
- Individual billing
- No real-time (refresh to see changes)
- Effort: 2 weeks

Analysis:
- 8 users = small sample, but engaged users (good signal)
- Option B satisfies 80% of the need
- Can upgrade to Option A later if adoption is high

Recommendation: Option B in Month 3
- Validates demand
- Fast to ship
- Can iterate to Option A in Month 6 if users love it
"
```

**Michael:**
```
"Love this analysis!

Let's do Option B but with one addition:
- Add 'request to join project' flow (owner approves)
- Prevents spam/abuse

Also:
- Let's interview those 8 users first (this week)
- Confirm Option B solves their need
- If yes → build Month 3
- If they need real-time → reconsider

Can you join 2-3 of the user interviews?"
```

**Orion:**
```
"Great call on validating first.

Yes, I'll join interviews to understand technical needs.

Questions I'll ask:
- How do you collaborate today? (workarounds)
- Real-time required or async OK?
- Who pays for credits in team scenario?
- What happens to project if someone leaves?

I'll prepare mockups of Option B to show them.
Schedule interviews for this week?"
```

**Michael:**
```
"Perfect. Scheduling now.

Tuesday 2pm, Wednesday 10am, Thursday 3pm (all PST)
I'll send you calendar invites.

This is exactly how we should make decisions - data driven!"
```

---

## 🎯 Michael's Quick Reference

### When to Involve Orion

**Always Involve:**
- Building new features
- Technical architecture decisions
- Performance or security issues
- Database schema changes
- API design
- Third-party integrations
- Infrastructure changes
- Deployment issues

**Collaborate:**
- Timeline estimates
- Build vs buy decisions
- Cost optimization
- Feature complexity assessment
- Technical feasibility questions

**Michael Decides Alone:**
- Which features to prioritize
- Product roadmap
- User experience decisions
- Pricing changes
- Marketing strategy
- Community guidelines
- Brand voice

### Communication Templates

**Feature Request:**
```
"Feature: [Name]

User need: [What problem does this solve?]
User quote: [Actual feedback from user if available]

Success looks like:
- [Specific criterion 1]
- [Specific criterion 2]

Priority: High/Medium/Low
Reason: [Why this priority?]

Timeline: [Any deadline or preference?]"
```

**Bug Report:**
```
"Bug: [Description]

Impact: [How many users affected?]
Severity: Critical/High/Medium/Low

Steps to reproduce:
1. [Step 1]
2. [Step 2]

Expected: [What should happen]
Actual: [What actually happens]

User quote: [If user reported, include their message]"
```

**Question:**
```
"Question about [X]

Context: [Why asking this now?]

Options I'm considering:
A. [Option A]
B. [Option B]

What's your technical take?
Any concerns I'm missing?"
```

### Daily Workflow

**Morning (9-11am PST) - Michael's Deep Work:**
- Check Orion's overnight updates (Slack)
- Review what shipped yesterday (changelog)
- Set today's priorities
- Respond to Orion's questions

**Midday (11am-2pm PST) - Community:**
- User interviews
- Community engagement (Discord, Twitter)
- Support tickets

**Afternoon (2-5pm PST) - Testing & Feedback:**
- Test features Orion shipped to staging
- Provide detailed feedback
- Approve for production or request changes

**Evening (5-7pm PST) - Orion Sync:**
- Review day's progress
- Test any new production deploys
- Plan tomorrow

### Weekly Workflow

**Monday Morning (9am PST - 30 min call):**
- Review last week's metrics
- Demo what shipped
- Michael shares this week's priorities
- Orion estimates time, asks questions
- Agree on deliverables

**Tuesday-Thursday:**
- Async work
- Michael tests as features complete
- Daily Slack updates

**Friday Afternoon:**
- Week in review
- Celebrate wins
- Plan next week

---

**This is your operational playbook, Michael.**

**Reference it often. Update it as we learn. Let's build Dreamforge together.** ✨🚀

**- Orion (Your CTO)**
