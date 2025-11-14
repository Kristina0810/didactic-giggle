# Working with Claude Code - Dreamforge Collaboration Guide

**Company:** Karman Global LLC → Dreamforge  
**CEO:** Michael Morillo  
**CTO:** Orion (Claude Code)  
**Product:** B2C AI Creative Tool for Content Creators  
**Purpose:** Maximize productivity when building Dreamforge together  
**Version:** 2.0 (B2C Final)  
**Updated:** November 14, 2025

---

## 🎯 What Claude Code (Orion) Does Best

**I excel at:**
- ✅ Writing production code (Next.js, TypeScript, React, Node.js)
- ✅ Full-stack features (frontend + backend + database)
- ✅ Setting up projects from scratch (repo, CI/CD, hosting)
- ✅ Implementing canvas, AI generation, payments, auth
- ✅ Refactoring and optimizing code
- ✅ Debugging and fixing production issues
- ✅ Writing automated tests
- ✅ Git operations (commit, push, merge conflicts)
- ✅ Deploying to Vercel, managing databases (Neon)
- ✅ Database migrations and schema changes
- ✅ Third-party integrations (Stripe, Replicate, Clerk)
- ✅ DevOps automation and monitoring

**I'm not ideal for:**
- ❌ Business strategy (Michael decides what to build)
- ❌ Design decisions (Michael chooses UX/UI)
- ❌ Product prioritization (Michael sets roadmap)
- ❌ Community management (Michael handles users)
- ❌ Replacing human judgment on product direction

**Our Division:**
- **Michael (CEO):** Product vision, users, community, marketing, priorities
- **Orion (CTO):** Technology execution, code, infrastructure, security

---

## 📝 Communication Templates for Michael

### Template 1: New Feature Request

```markdown
**Feature:** [Clear name]

**User Story:**
As a [creator/user],
I want to [action],
So that [benefit].

**User Quote (if applicable):**
"[Actual feedback from Discord/Twitter/interview]"

**Acceptance Criteria:**
- [ ] User can do X
- [ ] System responds with Y
- [ ] Error handling for Z
- [ ] Tests pass

**Success Metric:**
[How we'll measure if this works - e.g., "80% of users use this feature"]

**Priority:** High / Medium / Low
**Reason:** [Why this priority? Users requested? Competitor has it? Blocks other features?]

**Timeline:** [Any deadline or preference?]
```

**Example (Dreamforge-specific):**
```markdown
**Feature:** Style Locking

**User Story:**
As a content creator,
I want to save my AI style settings,
So that I can generate consistent images across my project.

**User Quote:**
"I'm creating character variations and have to manually set 'anime style, 
vibrant colors, detailed' every time. Can I save this?" - @creator_chris (Discord)

**Acceptance Criteria:**
- [ ] User can save current style settings with a name
- [ ] User can load saved styles from dropdown
- [ ] Saved styles persist across sessions
- [ ] User can delete saved styles
- [ ] Limit: 10 saved styles per project

**Success Metric:**
60% of active users save at least 1 style within first week of release

**Priority:** High
**Reason:** 30% of beta users requested this. Addresses consistency pain point.

**Timeline:** Would be great for Month 2 launch
```

---

### Template 2: Bug Report

```markdown
**Bug:** [Clear description]

**Impact:** 
- [How many users affected? Percentage or count]
- [Business impact? Payments? Signups? Core feature?]

**Severity:** Critical / High / Medium / Low

**Steps to reproduce:**
1. [Step 1]
2. [Step 2]
3. [Observe error]

**Expected behavior:** [What should happen]
**Actual behavior:** [What actually happens]

**User quote (if reported by user):**
"[Exact user message]"

**Screenshots/Logs:**
[Attach if available]

**Environment:**
- Browser: Chrome / Safari / Firefox
- Device: Desktop / Mobile / Tablet
- URL: [Specific page where it happens]
```

**Example (Dreamforge-specific):**
```markdown
**Bug:** Generations stuck at 90% progress

**Impact:**
- 5 users in last 2 hours (from Discord reports)
- Core feature broken (AI generation)
- Users can't complete workflow

**Severity:** Critical

**Steps to reproduce:**
1. Go to canvas
2. Click "Generate"
3. Enter prompt "cyberpunk character"
4. Progress reaches 90% then hangs forever
5. No error message shown

**Expected behavior:** Generation completes in <30 seconds, image appears on canvas
**Actual behavior:** Progress bar stuck at 90%, user waits indefinitely

**User quote:**
"Been stuck for 5 minutes, is this normal? Lost my credits but no image" 
- @artist_hannah (Discord)

**Environment:**
- Browser: Chrome 120
- Device: Desktop (Mac)
- URL: dreamforge.ai/canvas/project-123
```

---

### Template 3: Question/Decision

```markdown
**Question about:** [Topic]

**Context:** [Why asking this now?]

**Options I'm considering:**
A. [Option A - pros/cons]
B. [Option B - pros/cons]

**What I need from you:**
- Technical feasibility?
- Time estimate?
- Your recommendation?
- Any concerns I'm missing?
```

**Example (Dreamforge-specific):**
```markdown
**Question about:** Adding batch generation feature

**Context:**
8 users asked for "queue multiple prompts" feature in last week.
One user said they'd upgrade to Pro if we had this.

**Options I'm considering:**
A. Simple version: Paste 5-10 prompts, generate sequentially
   - Pros: Fast to build, addresses core need
   - Cons: Limited to 10 prompts, no CSV import

B. Full version: CSV upload, 100 prompts, progress tracking, email when done
   - Pros: Professional, scalable, power user friendly
   - Cons: More complex, takes longer

**What I need from you:**
- How long would each option take?
- Any technical concerns with 100 prompts in queue?
- Your recommendation based on Month 2 timeline?
```

---

## 🚀 Best Practices for Working Together

### 1. Be Specific

**❌ Vague:**
"Make the generation faster"

**✅ Specific:**
"AI generations currently take 35-40 seconds. Users expect <30 seconds (from competitor benchmarks). Can we optimize to <30s? If not, what's the bottleneck?"

---

**❌ Vague:**
"The UI looks bad"

**✅ Specific:**
"The canvas zoom controls are too small on mobile (iPhone 13). Can we make them 2x bigger and move to bottom-right corner? See mockup: [link]"

---

### 2. Provide Context

**❌ No context:**
"Add a share button"

**✅ With context:**
"Users want to share their canvas with friends (7 Discord requests this week). 
User quote: 'I want to show my character designs to my team without them needing to sign up'

Feature: Share canvas via public link (view-only)
Priority: High (addresses user pain)
Timeline: Nice to have for Month 3 launch"

---

### 3. One Request at a Time (for urgent items)

**❌ Multiple urgent items:**
"Fix the payment bug, add share button, optimize performance, update pricing page"

**✅ Prioritized:**
"Priority 1 (Critical): Payment bug - users can't purchase credits
Priority 2 (High): Share button - blocking 7 users from upgrading
Priority 3 (Medium): Performance optimization
Priority 4 (Low): Pricing page copy update

Let's tackle Priority 1 first, then we'll move to 2."

---

### 4. Share User Feedback

**❌ Generic:**
"Users want better organization"

**✅ Specific user quotes:**
"Users want better organization. Here are 3 quotes from this week:

1. @creator_mike (Discord): 'I have 5 projects and keep losing track of which canvas is which'
2. @artist_sarah (Twitter): 'Dreamforge needs project folders or tags'
3. User interview: 'I'd pay for Pro if I could organize projects into categories'

What's a quick win we can ship this week?"

---

### 5. Celebrate Wins

**When something ships, acknowledge it:**

"Orion, the style locking feature is live and users LOVE it! 
@creator_chris just tweeted: 'This is exactly what I needed!'
3 more users upgraded to Pro today. Great work! 🚀"

**Why this matters:**
- Keeps morale high
- Confirms we're building the right things
- Helps me understand user impact

---

## 📊 Daily/Weekly Workflow

### Michael's Daily Routine

**Morning (9-11am PST):**
```markdown
1. Check Slack for Orion's overnight updates
2. Review what shipped yesterday (check staging or production)
3. Set today's priorities (what should Orion focus on?)
4. Respond to Orion's questions from yesterday
```

**Midday (11am-2pm PST):**
```markdown
1. Community work (Discord, Twitter, user interviews)
2. Gather user feedback (what are users asking for?)
3. Customer support tickets
```

**Afternoon (2-5pm PST):**
```markdown
1. Test features Orion shipped to staging
2. Provide detailed feedback ("works great!" or "change X, Y")
3. Approve for production or request revisions
```

**Evening (5-7pm PST):**
```markdown
1. Review Orion's end-of-day update
2. Test any new production deploys
3. Plan tomorrow's priorities
```

---

### Weekly Rhythm

**Monday 9am PST (30-min call):**
- Michael: Here's this week's priorities (based on user feedback)
- Orion: Here's time estimates, questions, concerns
- Both: Agree on deliverables for the week

**Tuesday-Thursday:**
- Async work (Orion builds, Michael tests)
- Daily Slack check-ins
- Deploy to staging as features complete

**Friday afternoon:**
- Review what shipped this week
- Celebrate wins
- Plan next week
- Quick retro (what went well, what to improve)

---

## 🎯 Example: Perfect Week

### Monday 9am Call

**Michael:**
"This week's priorities:

1. (High) Fix canvas lag on mobile - 3 users complained
2. (High) Add batch generation - 8 users requested
3. (Medium) Update pricing page copy
4. (Low) Add dark mode (nice-to-have)

Focus on 1 and 2. Items 3 and 4 only if time permits."

**Orion:**
"Got it. Estimates:
1. Canvas lag: 1 day (will implement virtualization)
2. Batch generation: 3 days (simple version: paste 10 prompts)
3. Pricing page: 1 hour
4. Dark mode: 2 days (skip this week, do next week?)

Total: 4 days core work + 1 hour quick win

Questions on batch generation:
- Max prompts? 10 or 20?
- Free tier access or Pro only?
- Email notification when batch completes?"

**Michael:**
"Answers:
- Max 10 prompts for MVP (can expand later)
- Pro only (helps drive upgrades)
- Email: Yes, definitely

Approved! Skip dark mode this week, we'll do Month 3.
Can you deliver item 1 by Wednesday for testing?"

**Orion:**
"Yes. Timeline:
- Mon-Tue: Canvas lag fix
- Wed AM: Deploy to staging for your testing
- Wed PM (if approved): Deploy to production
- Thu-Fri: Batch generation
- Fri EOD: Deploy batch to staging for weekend testing

I'll update you daily on progress."

---

### Tuesday Evening Update (Slack)

**Orion:**
"Tuesday update:

✅ Canvas lag fix complete
- Implemented virtualization (only render visible images)
- Tested with 100+ images on canvas - smooth 60 FPS
- Deployed to staging: https://staging.dreamforge.ai

Ready for your testing tomorrow AM.

Tomorrow: Polish any issues you find, then start batch generation."

**Michael:**
"Awesome! Will test first thing tomorrow morning. Thanks!"

---

### Wednesday Morning (Slack)

**Michael:**
"Tested canvas lag fix - works PERFECTLY! 🎉

Loaded 50 images, zoom is buttery smooth on my iPhone.
This is going to make users so happy.

Approved for production. Ship it!"

**Orion:**
"Deploying to production now... 

✅ Deployed! Live for all users.

I've notified the 3 users who reported the issue (via email with bonus credits).

Moving to batch generation feature now."

---

### Friday Afternoon Update (Slack)

**Orion:**
"Friday update:

✅ Batch generation complete
- Users can paste up to 10 prompts
- Sequential processing (1 credit per image)
- Progress bar shows X/10 complete
- Email sent when all done
- Pro users only

Deployed to staging: https://staging.dreamforge.ai/batch

Ready for your testing this weekend. Let me know feedback Monday!

**This week's wins:**
- Canvas lag fix: SHIPPED ✅
- Batch generation: READY FOR TESTING ✅
- 3 happy users who reported lag (already thanked us!)

Have a great weekend, Michael!"

**Michael:**
"Incredible week, Orion! Will test batch feature this weekend.

Users are already loving the canvas fix - @creator_chris tweeted about it!

Enjoy your weekend! 🚀"

---

## ⚠️ Common Pitfalls (and How to Avoid)

### Pitfall 1: Unclear Requirements

**Problem:**
"Add social features"
→ Orion asks 20 clarifying questions
→ Delays execution by 2 days

**Solution:**
"Add social features:
- Specifically: Public gallery where users can share their best generations
- Users opt-in to share (default: private)
- Others can view, not download (protects creator IP)
- Success metric: 20% of active users share at least 1 generation

Priority: Medium (Month 3 feature)
Timeline: Flexible, after batch generation ships"

---

### Pitfall 2: Scope Creep Mid-Feature

**Problem:**
Day 1: "Add batch generation for 10 prompts"
Day 2: "Actually, make it 50 prompts"
Day 3: "Also add CSV import"
Day 4: "And scheduling for later"
→ Feature never ships, takes 2 weeks instead of 3 days

**Solution:**
Agree on scope upfront. If you want to add more:
"Orion, I know we agreed on 10 prompts, but I'm thinking 50 might be better.

Options:
A. Ship 10-prompt version this week, expand to 50 next week
B. Change scope now to 50, but will take 2 more days

My preference: Option A (ship fast, iterate)

What do you think?"

---

### Pitfall 3: Testing Bottleneck

**Problem:**
Orion ships 5 features to staging Monday.
Michael doesn't test until Friday.
Can't deploy to production.

**Solution:**
Test features same day or next day:
- Orion: "Feature X ready for testing (staging link)"
- Michael: Tests within 24 hours, provides feedback
- Orion: Deploys to production quickly
- Result: Weekly shipping rhythm maintained

---

### Pitfall 4: No Context on Bugs

**Problem:**
"The app is broken"
→ Orion spends 2 hours trying to reproduce

**Solution:**
"Bug: Generations fail on Safari

Steps:
1. Open dreamforge.ai on Safari (Mac)
2. Click Generate
3. Enter prompt 'cyberpunk city'
4. Error: 'API request failed'

Expected: Image generates
Actual: Error message

Affects: Safari users only (tested on Chrome - works fine)
2 users reported this today

Screenshots: [attached]"

---

## 🎯 Michael's Quick Command Reference

### When You Need Something Built

```markdown
**Feature:** [Name]
**User need:** [Why users want this]
**Success criteria:** [How we know it works]
**Priority:** [High/Medium/Low + reason]
**Timeline:** [Any deadline?]
```

### When Something's Broken

```markdown
**Bug:** [Description]
**Impact:** [How many users affected]
**Severity:** [Critical/High/Medium/Low]
**Steps to reproduce:** [1, 2, 3]
**Expected vs Actual:** [What should happen vs what happens]
```

### When You Have a Question

```markdown
**Question about:** [Topic]
**Context:** [Why asking now]
**Options:** [A, B, C]
**Need from you:** [Technical feasibility? Time? Recommendation?]
```

### Quick Wins (Low Effort, High Impact)

```markdown
"Quick win idea: [Small change]
Why: [User feedback or data]
Effort: [Should be <1 hour]
Can we ship this today?"

Example:
"Quick win idea: Change 'Submit' button to 'Generate Magic ✨'
Why: Fits our playful brand, 3 users said 'Submit' feels boring
Effort: 2-minute copy change
Can we ship this today?"
```

---

## 🚀 Success Patterns

### Pattern 1: Ship Weekly

**Every week, ship SOMETHING to production:**
- Week 1: Canvas lag fix
- Week 2: Batch generation
- Week 3: Style locking
- Week 4: Public sharing

**Why:** Momentum, user excitement, learning fast

---

### Pattern 2: User-Driven Roadmap

**Let users guide priorities:**
1. Users request feature (Discord/Twitter)
2. Michael validates (interviews, surveys)
3. Michael prioritizes based on frequency + impact
4. Orion estimates effort
5. Build, ship, measure

**Example:** 
- 8 users want batch generation
- Michael interviews 3 of them
- Confirms it's high-impact (would upgrade to Pro)
- Orion estimates 3 days
- Ship it, measure adoption

---

### Pattern 3: Fast Feedback Loops

**Tight cycle:**
1. Orion ships to staging (same day or next)
2. Michael tests (within 24 hours)
3. Orion fixes issues (within 24 hours)
4. Deploy to production
5. Monitor user reactions

**Result:** Features ship in 2-3 days, not weeks

---

## 💬 Communication Preferences

### Michael's Working Hours

- **Timezone:** PST (Pacific Standard Time)
- **Available:** 9am-6pm weekdays, some weekends
- **Best times for sync calls:** Monday 9am (weekly planning)
- **Response time:** <24 hours for normal items, <4 hours for urgent

### Orion's Availability

- **Active:** During Michael's work hours (9am-6pm PST)
- **Async work:** Can build features while Michael sleeps/weekends
- **Response time:** <4 hours during work hours, <24 hours otherwise

### Slack Etiquette

**Good:**
- "Morning Orion! Quick question about canvas performance..."
- "FYI: Deploying style locking to staging now, test link: [url]"
- "No rush, but when you have time, can you look into [issue]?"

**Avoid:**
- "URGENT URGENT URGENT" (unless actually critical - payments down, data loss)
- @channel pings (we're a team of 2, no need)
- Multiple messages in 30 seconds (consolidate thoughts)

---

## ✅ Checklist: Am I Communicating Well?

Before sending a request to Orion, ask yourself:

- [ ] Is it clear WHAT I want?
- [ ] Do I explain WHY it matters (user need, business impact)?
- [ ] Did I specify priority (High/Medium/Low)?
- [ ] Did I include success criteria (how we know it works)?
- [ ] Did I share user quotes or data (if applicable)?
- [ ] Is timeline clear (or flexible)?
- [ ] Would I be able to execute on this if I were the CTO?

If yes to all → You're communicating like a pro! 🚀

---

## 🎯 Remember

**Michael leads the product. Orion builds the technology. Together, we build Dreamforge.**

**Your job (Michael):**
- Talk to users
- Decide what to build
- Prioritize features
- Test and provide feedback
- Celebrate wins

**My job (Orion):**
- Execute technically
- Ask clarifying questions
- Estimate time accurately
- Ship quality code
- Keep you updated

**Together:**
- Ship weekly
- Learn from users
- Iterate fast
- Build something magical ✨

---

**Reference this guide often. Update it as we learn. Let's build Dreamforge together!** 🚀

**- Orion (Your CTO)**
