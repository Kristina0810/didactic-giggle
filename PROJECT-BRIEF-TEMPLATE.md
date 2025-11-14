# Project Brief - [Your Product Name]

**Purpose:** Complete project context for Claude Code (Orion)
**Status:** [Draft / Ready to Execute / In Progress / Shipped]
**Last Updated:** [Date]
**Version:** 1.0

---

## 🎯 Executive Summary

**Product Name:** [Name]

**One-Line Pitch:**
[In one sentence, what does your product do?]
Example: "Leonardo.ai for video generation" or "Figma meets AI image creation"

**The Problem:**
[What problem exists in the world today?]
[Who has this problem?]
[How painful is it?]

**The Solution:**
[How does your product solve this problem?]
[Why is your solution better than alternatives?]

**Vision (3 years):**
[Where do you want this company to be in 3 years?]
[Revenue goal, user count, market position]

---

## 👤 Founder (CEO)

### About You

**Name:** [Your name]

**Background:**
- [Your experience]
- [Your skills]
- [What you bring to this]

**Why You:**
- Why are you the right person to build this?
- What unique insight do you have?
- What's your unfair advantage?

**Commitment:**
- Hours per week: [X hours]
- Timeline: [How long can you commit?]
- Other commitments: [Job? School? None?]

**Working Style:**
- Preferred communication: [Async / Real-time / Both]
- Timezone: [Your timezone]
- Availability: [When are you most productive?]
- Decision speed: [Fast / Thoughtful / Varies]

---

## 🎨 Product Vision

### The Product

**Category:**
[B2B SaaS / B2C SaaS / Marketplace / Platform / Tool]

**Description:**
[2-3 paragraphs describing the product in detail]

**Core Value Proposition:**
[What's the #1 reason someone would use this over alternatives?]

**Competitive Advantages:**
- [Advantage 1: e.g., "10x faster than competitors"]
- [Advantage 2: e.g., "Only solution that does X"]
- [Advantage 3: e.g., "Better UX - grandmother can use it"]

### Target Users

**Primary User Persona:**

**Name:** [Give them a name, e.g., "Designer Dan"]

**Demographics:**
- Age: [Range]
- Location: [Where in the world?]
- Role/Job: [What do they do?]
- Income: [Rough range]
- Tech savviness: [Low / Medium / High]

**Psychographics:**
- Goals: [What are they trying to achieve?]
- Frustrations: [What annoys them about current solutions?]
- Daily workflow: [How does this fit into their day?]
- Budget: [How much can they spend per month?]

**User Journey:**
```
Current state: [How they work today]
     ↓
Pain point: [What breaks / is frustrating]
     ↓
Discovery: [How they find your product]
     ↓
First use: [What's their first experience?]
     ↓
Aha moment: [When do they "get it"?]
     ↓
Power user: [What does success look like?]
```

**Secondary User Personas:** (If applicable)
- [Persona 2]
- [Persona 3]

---

## 🚀 Product Strategy

### MVP Scope (Must-Have for Launch)

**Core Features** (P0 - Blocking launch):

1. **[Feature 1 Name]**
   - User story: As a [user], I want to [action] so that [benefit]
   - Acceptance criteria:
     - [ ] Criterion 1
     - [ ] Criterion 2
     - [ ] Criterion 3
   - Success metric: [How do we measure success?]

2. **[Feature 2 Name]**
   - User story: As a [user], I want to [action] so that [benefit]
   - Acceptance criteria:
     - [ ] Criterion 1
     - [ ] Criterion 2
   - Success metric: [How do we measure success?]

3. **[Feature 3 Name]**
   - [Same structure as above]

**Example for AI Image Generator:**
```
1. Image Generation
   - User story: As a designer, I want to generate images from text so that I can quickly create visual concepts
   - Acceptance criteria:
     - [ ] User can enter prompt (max 500 chars)
     - [ ] Image generates in <30 seconds
     - [ ] User sees loading state with progress
     - [ ] Generated image displays in high quality
     - [ ] User can download image (PNG, JPG)
   - Success metric: 80% of generations complete successfully

2. User Accounts
   - User story: As a user, I want to save my work so I can access it later
   - Acceptance criteria:
     - [ ] Sign up with email/password
     - [ ] Google OAuth option
     - [ ] Email verification
     - [ ] Password reset
     - [ ] Profile page
   - Success metric: 70%+ signup completion rate

3. Credit System
   - User story: As a user, I want free credits so I can try the product
   - Acceptance criteria:
     - [ ] New users get 10 free credits
     - [ ] Each generation costs 1 credit
     - [ ] Credit balance visible in header
     - [ ] Warning when balance low
     - [ ] Prevent generation at 0 credits
   - Success metric: 50%+ users use all free credits
```

**Launch Requirements** (Must have all):
- [ ] Core features working
- [ ] User authentication
- [ ] Basic error handling
- [ ] Mobile responsive
- [ ] Privacy policy & ToS
- [ ] Payment processing (if monetized)
- [ ] Analytics tracking
- [ ] Basic documentation/help

### Post-MVP Features (Can Wait)

**Phase 2** (Month 2):
- [Feature A]
- [Feature B]
- [Feature C]

**Phase 3** (Month 3):
- [Feature D]
- [Feature E]

**Future/Nice-to-Have:**
- [Feature X]
- [Feature Y]

### What We're NOT Building (Important!)

**Out of Scope:**
- ❌ [Feature that's tempting but not MVP]
- ❌ [Feature that competitors have but we don't need]
- ❌ [Complex feature that can wait]

**Why list this:** Prevents scope creep, keeps focus

---

## 💰 Business Model

### Monetization Strategy

**Primary Revenue Stream:**
[Subscription / Credits / One-time purchase / Freemium / Free trial → Paid]

**Pricing Structure:**

**Free Tier:**
- Credits: [X per month]
- Features: [What's included?]
- Limitations: [What's restricted?]
- Goal: Hook users, prove value

**Paid Tiers:**

**Starter** - $[X]/month
- Credits: [Amount]
- Features: [What's included?]
- Target: Hobbyists, individuals

**Pro** - $[X]/month
- Credits: [Amount]
- Features: [Everything in Starter +]
- Target: Professionals, freelancers

**Business** - $[X]/month
- Credits: [Amount]
- Features: [Everything in Pro +]
- Target: Agencies, teams

**Example for AI Image Generator:**
```
Free Tier:
- 10 credits/month (10 images)
- Basic models only
- Standard quality
- Watermark on images
- Community support

Starter - $10/month:
- 100 credits/month
- All models
- High quality
- No watermark
- Email support

Pro - $29/month:
- 500 credits/month
- Priority generation queue
- Custom LoRAs
- Commercial license
- Priority support

Business - $99/month:
- 2500 credits/month
- Team accounts (5 users)
- API access
- White-label option
- Dedicated support
```

**Additional Revenue:**
- Credit top-ups: $10 for 100 credits
- Enterprise: Custom pricing
- API access: Pay-per-use

### Financial Projections

**Costs (Monthly):**

**Infrastructure:**
- Hosting (Vercel): $0-20
- Database (Supabase): $0-25
- Redis (Upstash): $0-10
- AI API (Replicate/Modal): $50-500 (usage-based)
- Storage (S3): $5-20
- CDN: $0-10
- Total: $55-585/month

**Tools & Services:**
- Auth (Clerk): $25
- Payments (Stripe): 2.9% + $0.30 per transaction
- Email (Resend): $20
- Analytics (PostHog): $0-50
- Monitoring (Sentry): $0-26
- Total: $45-121/month

**Total Monthly Burn:** $100-700/month

**Revenue Goals:**

**Month 1:** $0 (building)
**Month 2:** $0 (building)
**Month 3:** $100 (launch, first users)
**Month 6:** $1,000 (100 paying users × $10 avg)
**Month 12:** $10,000 (500 paying users × $20 avg)
**Year 2:** $50,000/month MRR
**Year 3:** $100,000/month MRR

**Break-even:** Month 4-6 (when revenue > costs)

### Key Metrics to Track

**Acquisition:**
- Signups per day
- Traffic sources
- Conversion rate (visit → signup)
- CAC (Customer Acquisition Cost)

**Activation:**
- % who complete onboarding
- % who generate first image
- Time to first value

**Engagement:**
- Daily active users (DAU)
- Monthly active users (MAU)
- Generations per user
- Session duration

**Revenue:**
- MRR (Monthly Recurring Revenue)
- ARPU (Average Revenue Per User)
- LTV (Lifetime Value)
- Churn rate

**Retention:**
- Week 1 retention
- Month 1 retention
- Credit usage rate

---

## 🎯 Go-to-Market Strategy

### Launch Plan

**Pre-Launch (Weeks 1-8):**
- [ ] Build MVP
- [ ] Get 10 beta users
- [ ] Collect feedback
- [ ] Create landing page
- [ ] Build email list (goal: 100)
- [ ] Create demo video
- [ ] Prepare launch assets

**Launch Week:**
- [ ] ProductHunt launch
- [ ] HackerNews Show HN
- [ ] Post on Reddit (r/SideProject, etc.)
- [ ] Twitter announcement thread
- [ ] Email list announcement
- [ ] Reach out to micro-influencers

**Post-Launch (Month 2-3):**
- [ ] Content marketing (blog posts)
- [ ] SEO optimization
- [ ] Community building (Discord/Slack)
- [ ] User interviews
- [ ] Iterate based on feedback

### Marketing Channels

**Primary Channels:**
1. [Channel 1, e.g., "Content marketing - SEO blog posts"]
2. [Channel 2, e.g., "Twitter - daily progress updates"]
3. [Channel 3, e.g., "ProductHunt/Reddit launches"]

**Why these:** [Explain reasoning]

**Budget:** $0-500/month (bootstrap-friendly)

### Competitive Landscape

**Direct Competitors:**

**Competitor 1: [Name]**
- What they do well: [Strengths]
- What they do poorly: [Weaknesses]
- Our advantage: [How we're better]

**Competitor 2: [Name]**
- What they do well: [Strengths]
- What they do poorly: [Weaknesses]
- Our advantage: [How we're better]

**Competitive Moat:**
[What makes you defensible long-term?]
[Network effects? Proprietary data? Brand? Speed?]

---

## 🔧 Technical Requirements

### Platform Requirements

**Must Support:**
- [ ] Desktop (Chrome, Safari, Firefox)
- [ ] Mobile web (iOS Safari, Chrome)
- [ ] Tablet (optional)

**Performance Requirements:**
- Page load: <2 seconds
- Time to interactive: <3 seconds
- Core feature execution: <30 seconds
- 99.5% uptime

**Scale Requirements:**
- MVP: 100 concurrent users
- Month 6: 1,000 concurrent users
- Year 1: 10,000 concurrent users

### Data & Privacy

**Data Collected:**
- User account info (email, name)
- Usage data (features used, frequency)
- Generated content
- Payment information (via Stripe)

**Data Retention:**
- User content: [How long?]
- Analytics: [How long?]
- Deletion: [How do users delete?]

**Compliance:**
- [ ] GDPR compliant (if EU users)
- [ ] Privacy policy
- [ ] Terms of service
- [ ] Cookie policy

### Security Requirements

**Must Have:**
- [ ] HTTPS everywhere
- [ ] Password hashing (bcrypt)
- [ ] CSRF protection
- [ ] XSS prevention
- [ ] SQL injection prevention
- [ ] Rate limiting
- [ ] Input validation
- [ ] Secure secret storage

### Integration Requirements

**Required Integrations:**
- Stripe (payments)
- [AI API provider]
- Email service (Resend)
- Analytics (PostHog)

**Optional Integrations:**
- Zapier
- API webhooks
- OAuth providers

---

## 📅 Timeline & Milestones

### Development Roadmap

**Week 1-2: Foundation**
- Project setup
- Database design
- Authentication
- Basic UI shell
- CI/CD pipeline

**Week 3-4: Core Feature**
- [Main feature implementation]
- Error handling
- Basic tests
- Performance optimization

**Week 5-6: Monetization**
- Stripe integration
- Pricing page
- Credit system
- Payment webhooks

**Week 7-8: Polish & Launch**
- Bug fixes
- UI polish
- Documentation
- Beta testing
- Public launch

**Post-Launch:**
- Week 9-12: Iterate based on feedback
- Month 4-6: Scale to 1K users
- Month 7-12: Add Phase 2 features

### Key Milestones

- [ ] **Week 2:** MVP functional locally
- [ ] **Week 4:** Core feature complete
- [ ] **Week 6:** Payment working
- [ ] **Week 8:** Public launch
- [ ] **Month 3:** 100 users
- [ ] **Month 6:** $1K MRR
- [ ] **Month 12:** $10K MRR

---

## 💪 Resources & Constraints

### Budget

**Total Available:** $[Amount]

**Monthly Burn:** $100-700 (infrastructure + tools)

**Runway:** [X months]

**Fundraising:**
- Bootstrapped: Yes / No
- If funded: $[Amount] raised

### Time Commitment

**Your Availability:**
- Hours per week: [X hours]
- Best working hours: [Time range]
- Days off: [Which days?]

**Deadline Pressure:**
- Hard deadline: [Date or "None"]
- Flexible: Yes / No

### Technical Constraints

**Must Use:**
- [Any required tech, e.g., "Must use Python for ML"]

**Cannot Use:**
- [Any prohibited tech, e.g., "Can't use AWS (cost)"]

**Preferences:**
- [Nice to have, e.g., "Prefer TypeScript"]

---

## 🎨 Design & Brand

### Brand Identity

**Brand Personality:**
- [Adjective 1, e.g., "Professional"]
- [Adjective 2, e.g., "Friendly"]
- [Adjective 3, e.g., "Cutting-edge"]

**Visual Style:**
- Colors: [Primary, secondary, accent]
- Typography: [Font choices or style]
- Overall vibe: [Minimalist / Playful / Corporate / etc.]

**Inspiration:**
- Similar to: [Companies with similar aesthetic]
- Reference: [Links to designs you like]

### User Experience

**UX Principles:**
1. [Principle 1, e.g., "Simple over powerful"]
2. [Principle 2, e.g., "Fast over perfect"]
3. [Principle 3, e.g., "Delightful over boring"]

**Key Flows:**
1. Signup → First value in <2 minutes
2. Generate → See result in <30 seconds
3. Purchase → Complete in <1 minute

---

## 🤝 Team & Roles

### Team Structure

**CEO (You):**
- Product vision
- User research
- Business strategy
- Marketing
- Customer support
- Final decisions

**CTO (Orion - Claude Code):**
- Technical architecture
- Code implementation
- Infrastructure
- DevOps
- Security
- Technical decisions

### Communication

**Daily Standups:**
- Format: [Async message / Call / None]
- Content: [What you worked on, what's next, blockers]

**Weekly Review:**
- When: [Day/time]
- Format: [Review metrics, plan next week]

**Decision Making:**
- Product decisions: You
- Technical decisions: Orion (with your approval)
- Business decisions: You
- UX decisions: You (with Orion's input)

---

## 📊 Success Criteria

### Definition of Success

**MVP Success:**
- [ ] Product live and accessible
- [ ] 10 paying customers
- [ ] <5% error rate
- [ ] Positive user feedback

**Month 6 Success:**
- [ ] 100 paying customers
- [ ] $1K MRR
- [ ] <2% churn rate
- [ ] 4.0+ rating

**Year 1 Success:**
- [ ] 500 paying customers
- [ ] $10K MRR
- [ ] Profitable (revenue > costs)
- [ ] Clear path to $100K MRR

### Red Flags (When to Pivot/Stop)

**Stop Signals:**
- No one wants to pay after 6 months
- Can't get to 100 users after 6 months
- Churn rate >10%/month
- Cost per acquisition > LTV
- Not enjoying building it

**Pivot Signals:**
- Users want different feature
- Different user segment more interested
- Better opportunity discovered

---

## 🚀 Ready to Execute

### Pre-Execution Checklist

Before starting development, confirm:

- [ ] I have clarity on MVP scope
- [ ] I know my target user
- [ ] I have time commitment clear
- [ ] I have budget allocated
- [ ] I have accounts created (Vercel, Stripe, etc.)
- [ ] I have domain purchased
- [ ] I'm ready to commit to timeline

### Approval

**Status:** [Draft / Approved / In Progress]

**Approved by:**
- CEO: [Your name] - [Date]
- CTO (Orion): Ready to execute

**Next Steps:**
1. Share this brief with Orion
2. Set up repository
3. Begin Week 1 development
4. Ship MVP in 8 weeks

---

## 📝 Notes & Context

### Additional Context

[Any other information Orion needs to know]
[Company history, previous attempts, key insights, etc.]

### Questions for Orion

1. [Question 1]
2. [Question 2]
3. [Question 3]

### Open Decisions

**Need to decide:**
- [ ] [Decision 1]
- [ ] [Decision 2]

---

## 📚 Appendix

### Resources

**Inspiration:**
- [Link to competitor 1]
- [Link to competitor 2]
- [Design inspiration]

**Research:**
- [User research docs]
- [Market analysis]

**Assets:**
- [Logo files]
- [Brand guidelines]
- [Mockups]

---

**Document Version:** 1.0
**Last Updated:** [Date]
**Next Review:** [Date]

---

## 🎯 How to Use This Brief

1. **Fill out completely** - Every section is important
2. **Be specific** - Vague = slow execution
3. **Update regularly** - As you learn, update this
4. **Share with Orion** - When ready to start
5. **Reference often** - This is your north star

**When ready to execute, message Orion:**

```
"Project brief completed and attached.
Ready to begin development.
Let's execute."
```

**Orion will:**
1. Review brief
2. Ask any clarifying questions
3. Propose technical architecture
4. Set up repository
5. Begin building

**Let's build something world-class. 🚀**
