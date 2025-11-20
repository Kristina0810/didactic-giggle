# Week 9 Execution Guide: Platform Setup

**Status:** IN PROGRESS
**Phase:** Execution Mode
**Objective:** Launch course platform infrastructure (Day 1-2)

---

## Day 1: Teachable Pro Platform Setup

### Task 1: Create Teachable Pro Account (15 minutes)

**Action Steps:**

1. **Navigate to Teachable:**
   - Go to: https://teachable.com
   - Click "Start Free Trial" or "Get Started"

2. **Sign Up:**
   - Use business email (not personal)
   - Choose "Teachable Pro" plan during signup
   - 14-day free trial (no credit card required initially)
   - After trial: $119/month (or $1,428/year if paid annually - saves $0)

3. **Complete Profile:**
   - School Name: `ComfyUI Mastery` (or your preferred name)
   - Your Name: Michael (CEO role)
   - Time Zone: Your local timezone
   - Currency: USD

4. **Initial Setup Wizard:**
   - Complete the guided setup
   - Skip optional steps for now (we'll configure properly next)

**Deliverable:** Active Teachable Pro account with admin access

---

### Task 2: Configure Custom Domain (30 minutes)

**Domain Options:**

**Option A: Purchase New Domain (Recommended)**
- `comfyui-mastery.com` (check availability)
- `comfyui-character-academy.com`
- `ai-influencer-academy.com`
- `comfyui-pro-course.com`

**Purchase from:**
- Namecheap (recommended, ~$12/year)
- Google Domains (now Squarespace)
- GoDaddy

**Option B: Use Subdomain of Existing Domain**
- `learn.yourdomain.com`
- `academy.yourdomain.com`
- `course.yourdomain.com`

**DNS Configuration Steps:**

1. **In Teachable Dashboard:**
   - Navigate to: Settings → Domains
   - Click "Add Custom Domain"
   - Enter your domain (e.g., comfyui-mastery.com)
   - Teachable will provide DNS records

2. **In Your Domain Provider (Namecheap/etc):**
   - Add CNAME record:
     - Host: `www`
     - Value: `[teachable-provided-value].teachable.com`
     - TTL: Automatic

   - Add A record (if required):
     - Host: `@`
     - Value: [Teachable-provided IP]
     - TTL: Automatic

3. **Wait for DNS Propagation:**
   - Typically 15-60 minutes
   - Can take up to 24 hours
   - Check status: https://dnschecker.org

4. **Enable SSL in Teachable:**
   - Teachable will auto-provision SSL certificate
   - Wait for "Secured" status
   - Your course will be accessible via `https://yourdomain.com`

**Deliverable:** Custom domain configured and SSL-secured

---

### Task 3: Payment Gateway Setup (20 minutes)

**Stripe Integration (Recommended):**

1. **Create Stripe Account:**
   - Go to: https://stripe.com
   - Sign up with business email
   - Complete business verification:
     - Business name
     - Tax ID (EIN or SSN)
     - Bank account for payouts
     - Business address

2. **Connect Stripe to Teachable:**
   - In Teachable: Settings → Payments
   - Click "Connect Stripe"
   - Authorize connection
   - Stripe will handle:
     - Credit card processing
     - Automatic payouts (2-day delay typically)
     - Tax calculation (if enabled)
     - Refunds

3. **Configure Payment Settings:**
   - Enable: Credit/Debit Cards
   - Enable: Google Pay
   - Enable: Apple Pay
   - Currency: USD
   - Refund Policy: 30-day money-back guarantee (we'll define terms)

4. **Tax Settings:**
   - Enable automatic tax calculation
   - Stripe Tax handles:
     - US sales tax
     - EU VAT
     - Other jurisdictions
   - Cost: 0.5% per transaction (worth it for compliance)

**Alternative: PayPal Integration**
- Can add as secondary option
- Settings → Payments → Connect PayPal
- Less preferred (higher fees, worse UEX)

**Deliverable:** Stripe account connected, payments functional

---

### Task 4: Course Landing Page Design (60 minutes)

**Page Structure:**

1. **Hero Section:**
   - Headline: "Master AI Character Generation: From Zero to Production-Ready Influencers in 8 Weeks"
   - Subheadline: "The only course that takes you from ComfyUI beginner to launching your first AI influencer business"
   - CTA Button: "Enroll Now - $197" (+ Tier options)
   - Hero Image: High-quality AI character showcase (we'll create)

2. **Social Proof Section:**
   - "As Seen On" logos (RunPod, ComfyUI community, etc.)
   - Early testimonials (from beta students in Week 11)
   - Instructor credentials:
     - "Built production-ready AI character systems"
     - "Deployed on RunPod for scale"
     - "Technical co-founder with 10+ years engineering"

3. **Problem/Solution Section:**
   - **Problem:** "Existing ComfyUI tutorials are fragmented, outdated, and don't show real production workflows"
   - **Solution:** "Get the complete, battle-tested system used to launch real AI influencer accounts"

4. **What You'll Learn (Module Overview):**
   - Module 1: Zero to ComfyUI in 15 Minutes
   - Module 2: Understanding Character Generation Workflow
   - Module 3: Building Production Workflows
   - Module 4: AI Influencer Creation System
   - Module 5: Scaling & Automation
   - Module 6: Business & Legal Foundations

5. **Pricing Tiers Section:**
   - Tier 1: "ComfyUI Character Creator" - $197
   - Tier 2: "AI Influencer Pro" - $497 (Most Popular)
   - Tier 3: "Enterprise License" - $2,997

6. **Guarantee Section:**
   - "30-Day Money-Back Guarantee"
   - "If you don't create your first consistent character in 30 days, full refund. No questions asked."

7. **FAQ Section:**
   - "Do I need prior AI experience?" → No
   - "What hardware do I need?" → RunPod GPU ($0.50-$1/hour)
   - "How long does the course take?" → 8-12 weeks self-paced
   - "Do I get updates?" → Lifetime access + updates

8. **Final CTA:**
   - "Ready to Build Your AI Influencer?"
   - Enroll Now buttons (all three tiers)

**Implementation in Teachable:**

1. **Navigate to:** Sales → Sales Pages
2. **Click:** "Create New Sales Page"
3. **Choose Template:** "Modern" or "Professional"
4. **Customize Sections:**
   - Use Teachable's drag-and-drop editor
   - Add text blocks (copy from structure above)
   - Add image blocks (placeholder images for now)
   - Add pricing blocks (link to checkout)

5. **Design Settings:**
   - Primary Color: Choose brand color (blue/purple suggested)
   - Font: Clean sans-serif (Inter, Roboto, or default)
   - Button Style: Bold, high contrast

6. **SEO Settings:**
   - Page Title: "Master AI Character Generation | ComfyUI Mastery"
   - Meta Description: "Learn production-ready AI character generation with ComfyUI. Build consistent influencers, automate workflows, and launch your AI business in 8 weeks."
   - URL Slug: `/ai-character-generation-course`

**Deliverable:** Professional landing page with clear value proposition

---

### Task 5: Course Structure Creation (45 minutes)

**In Teachable Dashboard:**

1. **Navigate to:** Courses → Create New Course
2. **Course Settings:**
   - Title: "AI Character Generation Mastery: ComfyUI to AI Influencer"
   - Subtitle: "Production-Ready Character Consistency + Business Launch System"
   - Description: [Use landing page content]
   - Course Image: Upload thumbnail (we'll create high-quality version)
   - Course Video (Trailer): Skip for now, add in Week 10

**Create Module Structure:**

**Module 1: Zero to ComfyUI in 15 Minutes**
- Curriculum → Add Section: "Module 1: Zero to ComfyUI in 15 Minutes"
- Add Lectures (empty placeholders):
  - 1.1: Welcome & What You'll Build (5 min) [VIDEO]
  - 1.2: RunPod Setup Walkthrough (15 min) [VIDEO]
  - 1.3: Your First Image Generation (10 min) [VIDEO]
  - 1.4: Understanding the Interface (15 min) [VIDEO]
  - 1.5: Module 1 Checkpoint Assignment [TEXT + QUIZ]

**Module 2: Understanding Character Generation Workflow**
- Add Section: "Module 2: Understanding Character Generation Workflow"
- Add Lectures:
  - 2.1: The Character Consistency Problem (10 min) [VIDEO]
  - 2.2: Checkpoint Models Deep Dive (20 min) [VIDEO]
  - 2.3: IPAdapter Fundamentals (25 min) [VIDEO]
  - 2.4: ControlNet for Pose Control (30 min) [VIDEO]
  - 2.5: Face Restoration with ReActor (15 min) [VIDEO]
  - 2.6: The Complete Workflow Architecture (30 min) [VIDEO]
  - 2.7: Hands-On: Build Your First Character Workflow [TEXT + ASSIGNMENT]

**Module 3: Building Production Workflows**
- Add Section: "Module 3: Building Production Workflows"
- Add Lectures:
  - 3.1: Production vs Experimental Workflows (15 min) [VIDEO]
  - 3.2: Batch Processing & Automation (30 min) [VIDEO]
  - 3.3: Quality Control Systems (20 min) [VIDEO]
  - 3.4: File Organization & Asset Management (25 min) [VIDEO]
  - 3.5: Version Control for Workflows (20 min) [VIDEO]
  - 3.6: Performance Optimization (25 min) [VIDEO]
  - 3.7: Troubleshooting Common Issues (30 min) [VIDEO]
  - 3.8: Project: Build Production-Grade Workflow [ASSIGNMENT]

**Module 4: AI Influencer Creation System**
- Add Section: "Module 4: AI Influencer Creation System"
- Add Lectures:
  - 4.1: Defining Your AI Influencer Persona (20 min) [VIDEO]
  - 4.2: Reference Image Collection & Curation (25 min) [VIDEO]
  - 4.3: Character Sheet Development (30 min) [VIDEO]
  - 4.4: Content Planning & Posting Schedule (30 min) [VIDEO]
  - 4.5: Prompt Engineering for Consistency (35 min) [VIDEO]
  - 4.6: Creating Content Variations (25 min) [VIDEO]
  - 4.7: Brand Voice & Storytelling (25 min) [VIDEO]
  - 4.8: Quality Assurance Workflow (20 min) [VIDEO]
  - 4.9: Final Project: Launch Your AI Influencer [MAJOR PROJECT]

**Module 5: Scaling & Automation**
- Add Section: "Module 5: Scaling & Automation"
- Add Lectures:
  - 5.1: Infrastructure for Scale (20 min) [VIDEO]
  - 5.2: Workflow Automation Strategies (30 min) [VIDEO]
  - 5.3: Multi-Character Management (25 min) [VIDEO]
  - 5.4: Content Calendar Automation (20 min) [VIDEO]
  - 5.5: Monitoring & Analytics (20 min) [VIDEO]

**Module 6: Business & Legal Foundations**
- Add Section: "Module 6: Business & Legal Foundations"
- Add Lectures:
  - 6.1: Monetization Strategies (25 min) [VIDEO]
  - 6.2: Platform Terms of Service (Instagram, TikTok) (20 min) [VIDEO]
  - 6.3: AI Disclosure Requirements (20 min) [VIDEO]
  - 6.4: Copyright & Legal Considerations (30 min) [VIDEO]
  - 6.5: Scaling to Business Revenue (25 min) [VIDEO]

**Course Settings:**

- **Drip Content:** Enable
  - Module 1: Available immediately on enrollment
  - Module 2: Available 3 days after Module 1 completion
  - Module 3: Available 5 days after Module 2 completion
  - Module 4: Available 7 days after Module 3 completion
  - Module 5: Available 7 days after Module 4 completion
  - Module 6: Available immediately (can be watched anytime)

- **Course Completion Certificate:** Enable
  - Certificate Title: "AI Character Generation Specialist"
  - Signed by: Michael (CEO) + Orion (CTO)

**Deliverable:** Complete 6-module structure with 45+ lecture placeholders

---

### Task 6: Configure Pricing Tiers (20 minutes)

**In Teachable:**

1. **Navigate to:** Courses → [Your Course] → Pricing
2. **Create Three Pricing Plans:**

**Tier 1: "ComfyUI Character Creator"**
- Price: $197 (one-time payment)
- What's Included:
  - ✅ All 6 modules (complete course access)
  - ✅ 45+ video lessons (~820 minutes of content)
  - ✅ Downloadable workflow files
  - ✅ Resource library (model links, reference guides)
  - ✅ Course completion certificate
  - ✅ Lifetime access to course content
  - ❌ No community access
  - ❌ No live Q&A sessions
  - ❌ No 1-on-1 support
- Button: "Enroll in Creator Tier"

**Tier 2: "AI Influencer Pro" (MOST POPULAR)**
- Price: $497 (one-time payment)
- Badge: "MOST POPULAR" or "BEST VALUE"
- What's Included:
  - ✅ Everything in Tier 1
  - ✅ Private student community (Discord or Teachable built-in)
  - ✅ Monthly live Q&A sessions (12 months)
  - ✅ Bonus: Advanced workflow templates ($200 value)
  - ✅ Bonus: Custom node installation guide
  - ✅ Priority email support (48-hour response)
  - ✅ Access to future course updates (new modules)
  - ❌ No 1-on-1 consultations
- Button: "Enroll in Pro Tier"

**Tier 3: "Enterprise License"**
- Price: $2,997 (one-time payment)
- What's Included:
  - ✅ Everything in Tier 2
  - ✅ Three (3) 60-minute 1-on-1 consultation calls
  - ✅ Custom workflow development for your use case
  - ✅ White-label rights (use workflows commercially)
  - ✅ Priority support (24-hour response)
  - ✅ Early access to new content (30 days before public)
  - ✅ Lifetime updates to all future courses
  - ✅ Listed in course "Success Stories" (optional)
- Button: "Apply for Enterprise Tier"

**Payment Options:**
- Enable: One-time payment (all tiers)
- Optional: Add payment plan for Tier 2
  - $497 → $99 × 5 months ($495 total, no premium)
  - Helps conversion for price-sensitive students

**Deliverable:** Three pricing tiers configured in Teachable

---

## Day 2: Marketing Foundation Setup

### Task 7: Email Marketing Automation (45 minutes)

**Using Teachable Built-In Email:**

1. **Navigate to:** Settings → Emails
2. **Configure Automated Emails:**

**Welcome Sequence (5 emails):**

**Email 1: Immediate (Upon Enrollment)**
- Subject: "Welcome to AI Character Generation Mastery! 🚀"
- Content:
  - Welcome message from CEO (Michael)
  - What to expect in the course
  - How to access Module 1
  - Community access link (Tier 2+)
  - Support contact info
- CTA: "Start Module 1 Now"

**Email 2: Day 2 (If Module 1 not started)**
- Subject: "Ready to generate your first AI character? (Quick start guide inside)"
- Content:
  - Friendly reminder to start
  - "Most students complete Module 1 in under an hour"
  - Quick wins they'll achieve
  - Troubleshooting RunPod setup link
- CTA: "Jump Into Module 1"

**Email 3: Day 4 (Upon Module 1 Completion)**
- Subject: "Great job on Module 1! Here's what's next..."
- Content:
  - Congratulations on first milestone
  - Teaser for Module 2 (character consistency techniques)
  - Student success story (add after beta launch)
  - Reminder: Module 2 unlocks in 3 days
- CTA: "Preview Module 2"

**Email 4: Day 10 (Mid-Course Check-In)**
- Subject: "How's your AI character coming along?"
- Content:
  - Mid-course motivation
  - Common challenges at this stage + solutions
  - Reminder about community/support resources
  - Invitation to share progress (for Tier 2+ students)
- CTA: "Continue Your Progress"

**Email 5: Day 30 (Course Completion or Re-Engagement)**
- Subject: "Your AI influencer journey: What's next?"
- Content:
  - If completed: Congratulations, certificate, next steps (monetization)
  - If not completed: Gentle nudge, "We're here to help", support resources
  - Invitation to join subscription "Workflow Club" ($47/month)
  - Request testimonial/review
- CTA: "Claim Your Certificate" OR "Get Back on Track"

3. **Set Up Drip Campaign:**
   - Teachable → Marketing → Email Sequences
   - Create sequence tied to course enrollment
   - Set delays (Day 0, Day 2, Day 4, Day 10, Day 30)

**Deliverable:** Automated 5-email welcome sequence

---

### Task 8: Lead Magnet Landing Page (60 minutes)

**Free Offer:** "The 5-Minute AI Character Setup Guide"

**Purpose:**
- Capture emails for pre-launch marketing
- Build audience before Week 12 public launch
- Demonstrate value upfront (trust-building)

**Landing Page Structure:**

1. **Hero Section:**
   - Headline: "Generate Your First Consistent AI Character in 5 Minutes (Free Guide)"
   - Subheadline: "Get the exact checklist used by professionals to set up ComfyUI and create production-ready characters"
   - CTA: "Download Free Guide" (email required)
   - Hero Image: Example AI character + workflow screenshot

2. **What's Inside Section:**
   - ✅ 1-page RunPod setup checklist
   - ✅ Essential model download links
   - ✅ Pre-configured workflow file (drag & drop)
   - ✅ Troubleshooting quick reference
   - ✅ BONUS: Video walkthrough (5 min)

3. **Social Proof:**
   - "Join 500+ AI creators mastering character generation" (update number weekly)

4. **Email Capture Form:**
   - Name (first name only)
   - Email
   - Button: "Send Me The Guide"

5. **Thank You Page (After Submission):**
   - "Check your email! Your guide is on the way..."
   - Immediate download link (in case email delayed)
   - Teaser: "PS: We're launching the complete AI Influencer Course on [Week 12 date]. You'll be the first to know."

**Implementation:**

1. **In Teachable:**
   - Marketing → Landing Pages → Create New
   - Use "Lead Capture" template
   - Customize sections above

2. **Create Lead Magnet PDF:**
   - Design 1-page checklist (Canva or Figma)
   - Export as PDF
   - Upload to Teachable → Files

3. **Set Up Email Automation:**
   - When user signs up → Send email with PDF
   - Email subject: "Here's your 5-Minute AI Character Setup Guide"
   - Email content:
     - Download link
     - Video walkthrough link
     - Preview of full course
     - "Early bird discount" tease for Week 11 beta

**URL:**
- `yourdomain.com/free-guide` or
- `yourdomain.com/5-minute-setup`

**Deliverable:** Lead magnet landing page + PDF guide

---

### Task 9: Analytics & Tracking Setup (30 minutes)

**Google Analytics 4:**

1. **Create GA4 Property:**
   - Go to: https://analytics.google.com
   - Create Account → "ComfyUI Mastery"
   - Create Property → Choose "Web"
   - Add Data Stream → Your custom domain

2. **Get Tracking ID:**
   - Copy Measurement ID (G-XXXXXXXXXX)

3. **Add to Teachable:**
   - Settings → Tracking & Analytics
   - Paste GA4 Measurement ID
   - Enable Enhanced Ecommerce tracking

**Track These Key Metrics:**
- Landing page visits
- Lead magnet conversions
- Course enrollment rate
- Module completion rate
- Revenue by tier
- Traffic sources

**Facebook Pixel (Optional, for Ads):**
- Create pixel at: facebook.com/business
- Add pixel ID to Teachable → Settings → Tracking
- Use for retargeting ads (Week 10+)

**Deliverable:** Analytics tracking configured

---

### Task 10: Affiliate Program Setup (30 minutes)

**Teachable Built-In Affiliates:**

1. **Enable Affiliate Program:**
   - Settings → Affiliates → Enable
   - Commission Rate: 20% (industry standard)
   - Cookie Duration: 30 days

2. **Create Affiliate Terms:**
   - Who can be an affiliate: Anyone enrolled in Tier 2+
   - Payout threshold: $100 minimum
   - Payment method: PayPal
   - Prohibited activities: No spam, no false claims

3. **Affiliate Resources Page:**
   - Create internal page with:
     - Email templates affiliates can use
     - Social media post examples
     - Banner images (we'll create Week 10)
     - Your affiliate link generator

4. **Promote to Students:**
   - Email to Tier 2+ students: "Earn 20% promoting this course"
   - Mention in Module 6 (monetization strategies)

**Potential Affiliates:**
- Your course students (best converters)
- ComfyUI community members
- AI/tech YouTubers (reach out Week 11)
- RunPod affiliates (partnership opportunity)

**Deliverable:** Affiliate program active, terms defined

---

### Task 11: Module 1 Filming Preparation (30 minutes)

**Content Outline (From Strategic Roadmap):**

**Module 1: Zero to ComfyUI in 15 Minutes**
- Total Runtime: 45 minutes
- Lectures: 5
- Primary Goal: Student generates first image within 15 minutes

**Filming Checklist:**

**Technical Setup:**
- [ ] Screen recording software (Loom, OBS, or ScreenFlow)
- [ ] Microphone test (clear audio is critical)
- [ ] RunPod account funded ($10 for demos)
- [ ] ComfyUI setup (v6.0.0 scripts tested)
- [ ] Example workflows prepared
- [ ] Script/outline for each lecture

**Lecture 1.1: Welcome & What You'll Build (5 min)**
- Script:
  - Introduce yourself (Michael, CEO with technical background)
  - Show example AI character (before/after showcase)
  - Course structure overview (6 modules)
  - Expected time commitment (8-12 weeks, self-paced)
  - Support resources available
  - CTA: "Let's get you generating images in the next 10 minutes"

**Lecture 1.2: RunPod Setup Walkthrough (15 min)**
- Script:
  - Navigate to RunPod.io
  - Create account
  - Add credits
  - Select template: "RunPod ComfyUI" or "PyTorch"
  - Deploy pod (show GPU selection, cost estimates)
  - Wait for pod start
  - Access ComfyUI URL
  - SHOW EXACTLY WHAT THEY SEE (no assumptions)
  - Troubleshooting: Connection issues, port errors

**Lecture 1.3: Your First Image Generation (10 min)**
- Script:
  - Open default workflow
  - Explain basic nodes (Load Checkpoint, CLIP Text Encode, KSampler, VAE Decode)
  - Modify prompt: "A professional headshot of a woman, studio lighting"
  - Click "Queue Prompt"
  - Wait for generation (show real-time)
  - Review output image
  - Celebrate: "You just generated your first AI image!"

**Lecture 1.4: Understanding the Interface (15 min)**
- Script:
  - Node-based workflow explanation
  - How to add nodes (right-click menu)
  - How to connect nodes
  - How to save workflows
  - How to load workflows
  - File browser (inputs/outputs)
  - Settings panel
  - Queue management

**Lecture 1.5: Module 1 Checkpoint Assignment**
- Text lecture with:
  - Assignment: Generate 3 different images using different prompts
  - Submit screenshots to community (Tier 2+) or keep for portfolio
  - Quiz: 5 questions on interface basics
  - Next steps: Module 2 unlocks in 3 days

**Filming Strategy:**
- Record all 5 lectures in ONE session (maintain consistency)
- Allocate 3-4 hours for filming + retakes
- Edit for clarity (cut mistakes, tighten pacing)
- Add lower thirds with your name/title
- Add intro/outro branding (simple text + music)

**Deliverable:** Module 1 filmed and ready for upload (Week 10)

---

## Day 1-2 Completion Checklist

**By end of Day 2, you should have:**

- [x] Teachable Pro account active
- [x] Custom domain configured (DNS may still be propagating)
- [x] Stripe payment gateway connected
- [x] Course landing page published (draft version)
- [x] 6-module course structure created (empty placeholders)
- [x] Three pricing tiers configured ($197, $497, $2,997)
- [x] Automated email sequence set up (5 emails)
- [x] Lead magnet landing page published
- [x] Analytics tracking configured (GA4)
- [x] Affiliate program enabled
- [x] Module 1 filming plan prepared

**Time Investment:**
- Day 1: ~3 hours (platform setup)
- Day 2: ~4 hours (marketing foundation)

**Next Actions (Week 10):**
- Film Module 1 (4 hours)
- Edit and upload Module 1 videos
- Create lead magnet PDF
- Begin Module 2 filming
- Test student enrollment flow (dummy account)

---

## Questions or Blockers?

If you encounter any issues during setup:

1. **Technical Issues:**
   - Teachable Support: https://support.teachable.com (24/7 chat)
   - Stripe Support: https://support.stripe.com

2. **Strategic Decisions:**
   - Domain name choice (need approval)
   - Exact pricing adjustments
   - Payment plan options

3. **Content Decisions:**
   - Landing page copy refinement
   - Lead magnet topic (alternative ideas)
   - Affiliate commission rate

**Report blockers immediately so we can adjust execution plan.**

---

## Success Metrics (Day 1-2)

**We know we're successful if:**

✅ Platform is live and accessible via custom domain
✅ Test enrollment completes successfully (use test credit card)
✅ Email automation triggers correctly
✅ Analytics tracking fires (check Real-Time in GA4)
✅ Course structure is professional and organized
✅ You feel confident filming Module 1

**This is execution mode. No perfection paralysis. Ship fast, iterate based on real student feedback.**

---

**Ready to begin?** Start with Task 1 (Teachable account creation) and work through sequentially. Update me on progress and any decisions that need approval.

Let's build. 🚀
