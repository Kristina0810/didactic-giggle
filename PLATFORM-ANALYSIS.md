# Course Platform: Buy vs Build Analysis

**Date:** 2025-11-20
**Prepared for:** CEO (Michael)
**Prepared by:** CTO (Orion)
**Purpose:** Inform platform decision for AI Influencer Course launch

---

## Executive Summary

**RECOMMENDATION: Start with Teachable Pro ($119/month)**

**Rationale:**
- **Time to Market:** 1-2 days vs 4+ months (custom build)
- **Revenue:** Week 11 vs Month 6+
- **Cost:** $1,428/year vs $70,300/year
- **Risk:** Proven platform vs unproven custom solution
- **Migration:** Easy migration path when we hit 500+ students

**Key Insight:** Our competitive advantage is CONTENT QUALITY and SPECIFIC USE CASE, not platform engineering. Every day spent building infrastructure is a day competitors could enter the market.

---

## Platform Definition Clarification

### What is "Self-Hosted"?

**In the context of my previous recommendation, "Self-hosted" meant:**

**WordPress + LearnDash** hosted on our own VPS/cloud server (DigitalOcean, AWS, etc.)

**NOT a fully custom-built platform from scratch.**

---

### What is "Custom Build"?

**Custom Build would mean:**
- Next.js + TypeScript frontend
- Custom backend (Node.js/Python)
- Custom payment processing integration
- Custom video hosting/streaming
- Custom student dashboard
- Custom analytics
- Custom email automation
- Custom CRM integration

**This is a 4-6 month engineering project**, which I'm adding to this analysis for completeness but **strongly recommend against** for our current phase.

---

## Platform Comparison Matrix

| **Criteria** | **Teachable Pro** | **Podia Shaker** | **WordPress + LearnDash** | **Custom Build (Next.js)** |
|---|---|---|---|---|
| **Setup Time** | 1-2 days | 1-2 days | 2-4 weeks | 4-6 months |
| **Monthly Cost** | $119 | $89 | ~$100 | $5,000+ (dev time) |
| **Transaction Fee** | 0% | 0% | 0% | 0% |
| **Year 1 Total Cost** | $1,428 | $1,068 | $1,208 | $70,300 |
| **Video Hosting** | Unlimited | Unlimited | Self-managed | Self-managed |
| **Student Limit** | Unlimited | Unlimited | Unlimited | Unlimited |
| **Email Marketing** | Built-in | Built-in | Requires plugin | Custom integration |
| **Payment Gateway** | Integrated | Integrated | Manual setup | Full custom |
| **Mobile App** | Yes | No | No | Custom dev |
| **White Label** | Custom domain | Custom domain | Full control | Full control |
| **Analytics** | Built-in | Built-in | Requires plugins | Custom build |
| **Course Certificates** | Yes | Yes | Plugin required | Custom dev |
| **Drip Content** | Yes | Yes | Yes | Custom dev |
| **Student Dashboard** | Professional | Professional | Basic | Custom dev |
| **Maintenance** | Zero | Zero | Medium | High |
| **UEX Quality** | Excellent | Excellent | Good | Unknown (unproven) |
| **Technical Debt** | Zero | Zero | Low | High |
| **Time to Revenue** | Week 11 | Week 11 | Week 13-15 | Month 6-7 |

---

## Detailed Analysis

### Option 1: Teachable Pro ($119/month)

**Pros:**
- Market leader with proven track record
- Zero setup time (1-2 days to launch)
- Professional UEX out of the box
- Built-in marketing tools (email, landing pages, upsells)
- Mobile app for students
- Excellent course builder (drag-and-drop)
- Strong analytics dashboard
- Integrated payment processing (Stripe, PayPal)
- Automatic tax handling (VAT, sales tax)
- Course certificates
- Student progress tracking
- Drip content scheduling
- Affiliate program support
- 24/7 support

**Cons:**
- Monthly fee ($119/month = $1,428/year)
- Less customization than fully custom solution
- Platform branding (mitigated with custom domain)

**Best For:**
- Fast time to market (our primary need)
- Professional appearance
- Focus on content creation (not platform engineering)

**Year 1 Cost Breakdown:**
- Platform: $1,428
- Domain: $15
- Email marketing: $0 (built-in)
- **Total: $1,443**

---

### Option 2: Podia Shaker ($89/month)

**Pros:**
- $360/year cheaper than Teachable
- Zero transaction fees
- Unlimited courses, students, bandwidth
- Built-in email marketing
- Built-in affiliate program
- Clean, modern UEX
- Integrated payment processing
- Course certificates
- Student community features
- Drip content
- 24/7 support

**Cons:**
- Less brand recognition than Teachable
- No mobile app
- Slightly less robust analytics
- Smaller ecosystem (fewer integrations)

**Best For:**
- Budget-conscious launch
- All-in-one platform needs
- Community-focused courses

**Year 1 Cost Breakdown:**
- Platform: $1,068
- Domain: $15
- Email marketing: $0 (built-in)
- **Total: $1,083**

---

### Option 3: Self-Hosted WordPress + LearnDash

**Setup:**
- WordPress CMS
- LearnDash LMS plugin ($199/year)
- WooCommerce for payments
- VPS hosting (DigitalOcean: $48/month)
- SSL certificate
- Video hosting (Vimeo Pro: $84/month or AWS S3)
- Email marketing plugin (MailerLite: $9/month)

**Pros:**
- Full control over platform
- One-time plugin cost
- No transaction fees
- Extensive customization options
- Large plugin ecosystem
- Own your data completely

**Cons:**
- Setup time: 2-4 weeks (theme customization, plugin config)
- Maintenance burden (updates, security, backups)
- Server management required
- Video hosting costs
- Plugin compatibility issues
- Security responsibility
- Performance optimization needed

**Best For:**
- Teams with WordPress expertise
- Long-term cost optimization (2+ years)
- Maximum customization needs

**Year 1 Cost Breakdown:**
- LearnDash: $199
- VPS Hosting: $576
- Video Hosting (Vimeo Pro): $1,008
- SSL: $0 (Let's Encrypt)
- Email marketing: $108
- Domain: $15
- **Total: $1,906**

**BUT: Requires 40-80 hours setup + ongoing maintenance**

---

### Option 4: Custom Build (Next.js + TypeScript)

**Tech Stack:**
- Frontend: Next.js 14, TypeScript, Tailwind CSS
- Backend: Node.js + Express OR Python + FastAPI
- Database: PostgreSQL
- Authentication: NextAuth.js or custom JWT
- Payment: Stripe API integration
- Video: AWS S3 + CloudFront OR Vimeo API
- Email: SendGrid or AWS SES
- Analytics: Custom dashboard
- Hosting: Vercel (frontend) + AWS/DigitalOcean (backend)

**Development Timeline:**
- Week 1-2: Architecture + database design
- Week 3-4: Authentication + user management
- Week 5-6: Payment processing integration
- Week 7-8: Course delivery system
- Week 9-10: Video player + progress tracking
- Week 11-12: Student dashboard
- Week 13-14: Admin dashboard + analytics
- Week 15-16: Email automation + marketing
- Week 17-18: Testing + bug fixes
- Week 19-20: Deployment + optimization

**Pros:**
- Perfect UEX tailored to our exact needs
- Zero platform fees (only infrastructure costs)
- Complete control over features
- Scalable architecture
- Competitive advantage (unique features)
- Own the entire stack

**Cons:**
- **4-6 months to launch** (massive delay)
- **High development cost** ($50K-70K if outsourced, 400-600 hours if internal)
- Ongoing maintenance burden
- Security responsibility
- Unproven platform (bugs, UEX issues)
- Delayed revenue (opportunity cost)
- Technical debt
- Distraction from content creation

**Year 1 Cost Breakdown (Assuming internal development):**

*Development (600 hours @ $100/hour equivalent):*
- Architecture & setup: $10,000
- Core features: $30,000
- Testing & optimization: $10,000
- **Development subtotal: $50,000**

*Infrastructure:*
- Hosting (Vercel + AWS): $1,200
- Video hosting (AWS S3 + CloudFront): $3,600
- Database (AWS RDS): $2,400
- Email service (SendGrid): $180
- SSL & domain: $15
- Monitoring & analytics: $600
- **Infrastructure subtotal: $7,995**

*Ongoing:*
- Maintenance (10 hours/month @ $100/hour): $12,000
- Security updates: Included in maintenance
- Feature additions: Variable

**Year 1 Total: $69,995 + opportunity cost**

---

## Time-to-Market Comparison

### Scenario: Teachable Pro (Current Plan)

**Timeline:**
- Week 9-10: Platform setup (2 days actual work)
- Week 11: Beta launch → $2,000 revenue (conservative: 10 students × $197)
- Week 12: Public launch → $15,000 revenue (conservative: 50 students × $297 avg)
- Month 4: $20,000 revenue
- **Total revenue by Day 120:** ~$37,000

---

### Scenario: Custom Build (Alternative)

**Timeline:**
- Week 9-28: Platform development (no revenue)
- Week 29: Beta launch → $2,000 revenue
- Week 30: Public launch → $15,000 revenue
- **Total revenue by Day 120:** $0 (still in development)

**Delayed Revenue:**
- Week 11-28: $37,000 lost
- Development cost: $70,000
- **Total opportunity cost: $107,000**

---

## Migration Strategy (Staged Platform Evolution)

### Stage 1: Launch Phase (Months 1-12)
**Platform:** Teachable Pro
**Goal:** Validate market, achieve product-market fit, generate revenue
**Student Target:** 0-500 students
**Revenue Target:** $0-$150,000

**Why Teachable:**
- Zero setup time
- Proven UEX
- Focus 100% on content quality
- Low risk, fast iteration
- Professional appearance from day 1

---

### Stage 2: Evaluation Phase (Month 12-15)
**Trigger Points for Migration:**
- 500+ active students
- $150K+ annual revenue
- Platform limitations impacting growth
- Specific feature needs unmet by Teachable

**Decision Criteria:**
- Is our content proven successful? (Course completion rate >60%)
- Do we have product-market fit? (Net Promoter Score >50)
- Are Teachable limitations actually blocking growth?
- Do we have budget for 6-month custom build? ($100K+)
- Can we afford to pause new student acquisition during migration?

**If YES to all above:** Proceed to Stage 3
**If NO to any:** Stay on Teachable, optimize content

---

### Stage 3: Migration Phase (Months 16-22)
**Platform:** Custom Next.js application
**Goal:** Scale to 1,000+ students, add unique features

**Migration Process:**
1. Build custom platform in parallel (don't stop Teachable)
2. Migrate course content module-by-module
3. Offer existing students free migration
4. Run both platforms for 3 months (overlap period)
5. Sunset Teachable when 90%+ students migrated

**Migration Cost:**
- Development: $80,000-$120,000
- Data migration: $5,000
- Student communication: $2,000
- Overlap period (both platforms): $1,200
- **Total: ~$90,000**

**Migration Risk:**
- Student confusion during transition
- Temporary UEX degradation
- Data loss risk
- Revenue disruption

**Risk Mitigation:**
- White-glove migration support
- Incentives for early adopters (free month, bonus content)
- Comprehensive testing before migration
- Gradual rollout (beta group first)

---

## Decision Matrix

| **Factor** | **Weight** | **Teachable** | **Podia** | **WordPress** | **Custom** |
|---|---|---|---|---|---|
| **Time to Market** | 30% | 10/10 | 10/10 | 6/10 | 2/10 |
| **Cost (Year 1)** | 20% | 8/10 | 9/10 | 7/10 | 1/10 |
| **UEX Quality** | 20% | 9/10 | 8/10 | 6/10 | 10/10* |
| **Maintenance** | 10% | 10/10 | 10/10 | 5/10 | 3/10 |
| **Scalability** | 10% | 8/10 | 7/10 | 6/10 | 10/10 |
| **Customization** | 10% | 6/10 | 6/10 | 8/10 | 10/10 |

**Weighted Scores:**
1. **Teachable: 8.5/10**
2. Podia: 8.2/10
3. WordPress: 6.3/10
4. Custom: 4.9/10

*Custom build UEX is theoretical (unproven)*

---

## Recommended Action Plan

### ✅ RECOMMENDATION: Start with Teachable Pro

**Immediate Actions (Week 9, Day 1-2):**

**Day 1 - Platform Setup:**
1. Sign up for Teachable Pro (14-day free trial)
2. Configure custom domain (comfyui-mastery.com or similar)
3. Set up payment gateway (Stripe)
4. Configure tax settings (automatic tax calculation)
5. Design landing page (use Teachable templates + customization)
6. Create course structure (6 modules, empty placeholders)
7. Upload course thumbnail/branding
8. Set up pricing tiers ($197, $497, $2,997)

**Day 2 - Marketing Foundation:**
1. Set up email marketing (Teachable built-in)
2. Create lead magnet landing page ("Free: 5-Minute AI Character Setup Guide")
3. Design welcome email sequence (5 emails)
4. Configure course completion certificates
5. Set up analytics tracking (Google Analytics integration)
6. Create affiliate program structure (20% commission)
7. **Begin Module 1 filming**

**Week 10-12: Content Production**
- Continue following Strategic Roadmap timeline
- Platform is ready, focus 100% on content

**Month 12: Evaluate Migration**
- Review student count, revenue, feedback
- Assess if Teachable limitations exist
- Make Stage 2 decision (stay or migrate)

---

## Why NOT Custom Build Now

**"Premature optimization is the root of all evil" - Donald Knuth**

### Reasons to avoid custom build in Phase 1:

1. **Unvalidated Market:**
   - We don't yet know if our course will succeed
   - Building custom platform before proving product-market fit is high risk
   - Better to validate with proven platform first

2. **Opportunity Cost:**
   - 4-6 months of development = 4-6 months competitors can enter market
   - $70K investment before $1 of revenue
   - 600 hours of engineering time NOT spent on content

3. **Distraction from Core Competency:**
   - Our advantage is AI/ComfyUI expertise, not LMS engineering
   - Platform engineering distracts from content quality
   - Every hour on platform is an hour NOT improving course content

4. **Technical Debt:**
   - Custom platform = custom bugs
   - Security vulnerabilities
   - Ongoing maintenance burden
   - Feature parity with Teachable takes months

5. **Unproven UEX:**
   - Teachable has years of UEX optimization
   - Our first custom version will have UEX issues
   - Students expect professional LMS experience

6. **Scale Assumption:**
   - Custom build optimizes for 1,000+ students
   - We currently have 0 students
   - Premature scaling before validation

---

## When Custom Build DOES Make Sense

Build custom platform when:

✅ **500+ active students** (proven demand)
✅ **$150K+ annual revenue** (proven business model)
✅ **60%+ course completion rate** (proven content quality)
✅ **Specific feature needs** unmet by Teachable:
   - AI-powered personalized learning paths
   - Custom student dashboard with ComfyUI integration
   - Advanced analytics/reporting beyond Teachable
   - White-label reseller program
   - API for third-party integrations

✅ **Budget available** for 6-month build ($100K+)
✅ **Team capacity** for ongoing maintenance
✅ **Willing to pause** new student acquisition during migration

**Until these conditions are met: Stay on Teachable.**

---

## Final Recommendation

### START WITH TEACHABLE PRO

**Execute Week 9 Day 1-2 action plan immediately upon approval.**

**Commit to:**
- No platform engineering in Phase 1
- 100% focus on content quality
- Evaluate migration at 500 students OR $150K revenue
- Trust the process: Velocity > Perfection in validation phase

**Expected Outcome:**
- Revenue in Week 11 (vs Month 6+ with custom build)
- Professional UEX from day 1
- Zero platform technical debt
- Clear migration path when scale justifies it

---

## Questions for CEO

Before proceeding, please confirm:

1. **Platform Decision:** Do you approve Teachable Pro as our launch platform?

2. **Migration Threshold:** Do you agree with 500 students / $150K revenue as evaluation point for custom build?

3. **Week 9 Execution:** Shall I proceed with Day 1-2 action plan (Teachable setup + begin Module 1 filming)?

4. **Budget Approval:** Confirm $119/month Teachable Pro budget (billed annually: $1,428)?

---

**Awaiting your decision to proceed.**

— Orion (CTO)
