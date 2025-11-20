# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**AI Character Creation System** - Complete infrastructure for creating consistent AI characters and launching AI influencer businesses.

**Current Phase**: Course Building (pivot from infrastructure development to educational product creation)

**Business Model**: AI Influencer → Course → SaaS (6-8 week → 12-month → 18-24 month timeline)

**Company**: Karman Global LLC (Operating as: Dreamforge)
- **CEO**: Michael Morillo (Product, Business, Marketing)
- **CTO**: Orion/Claude Code (Technology, Infrastructure, Security)

---

## Repository Structure

### Core Setup Scripts (Production-Ready)

**Latest Version: v6.0.0** (Production Final - Zero Compromise Standard)

- `setup-comfyui-pro-v6.0.0.sh` - ComfyUI setup (632 lines, production-grade)
- `download-models-pro-v6.0.0.sh` - Model downloads (502 lines, enhanced robustness)
- `setup-kohya-pro-v5.0.0.sh` - Kohya_ss training setup

**Legacy versions** (v4.0.0, v5.0.0) - Archived, do not use

### Documentation Categories

**Student-Facing (Simplified Course Guides - ~700 lines total)**:
- `00-QUICK-START.md` - Installation and first image (30 min goal)
- `01-FIRST-CHARACTER.md` - LoRA training basics (2-3 hours)
- `03-CONTENT-PIPELINE.md` - Batch generation workflow (30 min setup)
- `04-INSTAGRAM-LAUNCH.md` - Business strategy and monetization (6-8 weeks)

**Strategic Documents**:
- `STRATEGIC-ROADMAP.md` - Official 12-week course building plan
- `PLATFORM-ANALYSIS.md` - Buy vs Build analysis (Teachable Pro recommendation)
- `WEEK-9-EXECUTION-GUIDE.md` - Day-by-day platform setup instructions

**Developer Reference**:
- `ADVANCED-REFERENCE.md` - Deep technical reference (archived PLAYBOOK.md - 6,670 lines)
- `README-v6.0.0.md` - v6.0.0 comprehensive documentation
- `CHANGELOG.md` - Detailed version history and improvements

**Collaboration Guides**:
- `ROLES-AND-RESPONSIBILITIES-REFINED.md` - CEO/CTO division of labor
- `GIT-WORKFLOW-GUIDE.md` - Complete Git/GitHub workflows
- `WORKING-WITH-CLAUDE-CODE.md` - Communication templates and protocols

**Templates**:
- `PROJECT-BRIEF-TEMPLATE.md` - Project brief structure
- `PROJECT-BRIEF-EXEMPLAR.md` - Dreamforge B2C SaaS plan (future, 6-12 months)

---

## Architecture

### Two-Pod System

**Pod 1: ComfyUI (Inference)**
- Purpose: Image generation, batch processing
- PyTorch: Latest (stable from RunPod template)
- Script: `setup-comfyui-pro-v6.0.0.sh`
- Port: 8188
- Auto-start: ✅ Configured (dual fallback: on_start.sh + cron)

**Pod 2: Kohya_ss (Training)**
- Purpose: LoRA training
- PyTorch: 2.1.2 (pinned for dependency stability)
- Script: `setup-kohya-pro-v5.0.0.sh`
- Port: 7860
- Auto-start: ✅ Configured

### Storage Architecture

**Persistent Storage**: `/workspace/` (survives pod restarts)

```
/workspace/
├── ComfyUI/              # ComfyUI installation
│   ├── models/           # All models organized by type
│   ├── custom_nodes/     # 9 custom nodes auto-installed
│   ├── input/            # Input images
│   └── output/           # Generated images
├── kohya_ss/             # Kohya_ss installation
│   └── venv/             # Isolated Python environment
├── logs/                 # All setup and runtime logs
├── on_start.sh           # Auto-start hook (RunPod native)
└── activate-kohya.sh     # Helper script for manual activation
```

**Key Design Principle**: Everything in `/workspace/` is persistent; ephemeral `/opt/` is avoided.

---

## Running Scripts

### Setup ComfyUI

```bash
cd /workspace
git clone https://github.com/Kristina0810/didactic-giggle.git
cd didactic-giggle
./setup-comfyui-pro-v6.0.0.sh
```

**What it does**:
- Detects Python command (python3 vs python)
- Installs missing system dependencies (including cron if needed)
- Fixes numpy conflict (upgrades to >=2.0.0)
- Installs ComfyUI + 9 custom nodes
- Sets environment variables explicitly
- Configures auto-start (dual fallback)
- Starts ComfyUI immediately
- Runs health checks (6-point verification)

**Time**: ~10-15 minutes on RunPod template

### Download Models

```bash
./download-models-pro-v6.0.0.sh
```

**What it does**:
- Downloads essential models (~15-20GB):
  - Juggernaut XL v9 (checkpoint)
  - SDXL VAE
  - IP-Adapter SDXL (critical for character consistency)
  - ControlNet OpenPose XL
  - Upscalers (RealESRGAN, UltraSharp)
- Retry logic (3 attempts, exponential backoff)
- Idempotent (skips existing files)
- 10-minute timeout per download

**Time**: ~30-60 minutes depending on bandwidth

### Setup Kohya (Training Pod)

```bash
./setup-kohya-pro-v5.0.0.sh
```

**What it does**:
- Pins PyTorch to 2.1.2 (stable for training)
- Creates isolated venv
- Installs Kohya_ss dependencies
- Configures auto-start
- Creates training directory structure

**Time**: ~15-20 minutes

---

## Script Development Standards (v6.0.0)

### Critical Features

**1. Idempotency**
- All scripts are safe to re-run
- Check for existing installations/files before creating
- Skip completed work automatically

**2. Error Handling**
- Retry logic with exponential backoff (3 attempts)
- Comprehensive logging (timestamped, color-coded)
- Graceful fallbacks (e.g., cron install failure continues)

**3. Auto-Start**
- Dual-fallback: `on_start.sh` (primary) + cron `@reboot` (backup)
- PID file management
- Health checks on startup

**4. Environment Configuration**
- Explicit variable setting (COMFYUI_PATH, COMFYUI_MODEL_PATH)
- Persistence across sessions (.bashrc integration)
- RunPod URL auto-detection

**5. UEX Polish**
- Color-coded output (green success, red errors, yellow warnings)
- Progress indicators
- Clear status messages
- Accurate URL display (no "localhost" in RunPod)

### Logging

All logs saved to `/workspace/logs/`:
- `comfyui-setup-YYYYMMDD-HHMMSS.log`
- `kohya-setup-YYYYMMDD-HHMMSS.log`
- `comfyui.log` (runtime)
- `kohya.log` (runtime)

View logs:
```bash
tail -100 /workspace/logs/comfyui-setup-*.log
```

---

## Git Workflow

### Branch Strategy

- `main` - Production-ready code only
- `claude/[feature-name]-[session-id]` - Feature development branches
- Always create PR for merging to main
- CEO (Michael) reviews and approves before merge

### Commit Standards

**Format**:
```
[Short summary - 50 chars max]

[Detailed explanation]
- Bullet points for changes
- Explain WHY, not just WHAT

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Examples**:
- Good: `Fix numpy dependency conflict in v6.0.0`
- Bad: `fix stuff`

### Deployment Process

1. Develop in feature branch
2. Test locally/on RunPod
3. Create PR with detailed description
4. CEO reviews and approves
5. Merge to main
6. Tag version if release (e.g., `v6.0.0`)

**Reference**: See `GIT-WORKFLOW-GUIDE.md` for complete workflows

---

## Communication Protocols

### CEO ↔ CTO Workflow

**When Michael requests a feature**:
1. Michael provides: User need, success criteria, priority, timeline
2. Orion responds: Technical breakdown, time estimate, clarifying questions
3. Michael approves or adjusts scope
4. Orion builds, tests, deploys to staging
5. Michael tests and provides feedback
6. Orion deploys to production

**Template for Feature Requests** (from ROLES-AND-RESPONSIBILITIES-REFINED.md):
```
Feature: [Name]

User need: [What problem does this solve?]

Success looks like:
- [Specific criterion 1]
- [Specific criterion 2]

Priority: High/Medium/Low
Timeline: [Any deadline?]
```

**Response Times**:
- Urgent (production down): <1 hour
- High priority (major bug): <4 hours
- Normal (feature questions): <24 hours
- Low priority: <48 hours

### Status Updates

- **Daily**: Orion provides end-of-day progress update
- **Weekly**: Monday sync call (30 min) - review metrics, plan week
- **Monthly**: First Monday (1 hour) - strategy review

**Reference**: See `ROLES-AND-RESPONSIBILITIES-REFINED.md` and `WORKING-WITH-CLAUDE-CODE.md`

---

## Current Phase: Course Building

**Status**: Script development CLOSED permanently (v6.0.0 is final)

**Focus**: Course production and platform setup

### Timeline (12 Weeks)

**Weeks 1-8**: Content production
- Module 1: Zero to ComfyUI (45 min)
- Module 2: Character Generation Workflow (130 min)
- Module 3: Production Workflows (175 min)
- Module 4: AI Influencer Creation (235 min)
- Module 5: Scaling & Automation (115 min)
- Module 6: Business & Legal (120 min)

**Weeks 9-10**: Platform setup + marketing
- Platform: Teachable Pro ($119/month)
- Lead magnet creation
- Email automation
- Analytics setup

**Week 11**: Beta launch (10-20 students)

**Week 12**: Public launch

**Revenue Target**: $29,700 in first 90 days (100 students @ $297 avg)

### Pricing Tiers

1. **ComfyUI Character Creator** - $197 (basic access)
2. **AI Influencer Pro** - $497 (most popular, includes community)
3. **Enterprise License** - $2,997 (includes 1-on-1 consulting)

**Reference**: See `STRATEGIC-ROADMAP.md` and `WEEK-9-EXECUTION-GUIDE.md`

---

## Key Technical Decisions

### Why v6.0.0 is Final

**Principle**: "Premature optimization is the root of all evil" (Donald Knuth)

**Rationale**:
- v6.0.0 meets "zero-compromise" standard
- Further optimization has diminishing returns
- Opportunity cost: Every day on scripts ≠ revenue generation
- Market timing: AI influencer space is growing, competitors could enter

**No more script versions** unless critical security issues arise.

### Platform Choice: Teachable Pro (Not Custom Build)

**Decision**: Start with Teachable Pro, migrate to custom platform at 500+ students OR $150K revenue

**Why NOT custom build now**:
- 4-6 months delay vs 1-2 days (Teachable)
- $70K cost vs $1,428/year
- Unvalidated market (0 students currently)
- Distraction from core competency (AI/ComfyUI expertise)
- Premature scaling

**Migration trigger**: 500 students AND $150K revenue AND specific unmet needs

**Reference**: See `PLATFORM-ANALYSIS.md`

### Why Separate ComfyUI and Kohya Pods

**Technical Reason**: PyTorch version conflicts
- ComfyUI works best with latest PyTorch (2.4+)
- Kohya_ss requires PyTorch 2.1.2 for dependency stability

**Cost Reason**: Stop pods independently
- ComfyUI: 2-4 hours/week ($2-4)
- Kohya: 1-2 hours/week ($1-2)
- Total: $20-30/month vs $60/month (Midjourney Pro)

---

## Testing Standards

### Before Committing Scripts

**Test on 3 environments**:
1. RunPod ComfyUI Template (easiest path, most users)
2. RunPod PyTorch Template (clean environment)
3. Clean Ubuntu 22.04 (edge case, thorough validation)

**Verification Checklist**:
- [ ] Script completes without errors
- [ ] ComfyUI GUI accessible
- [ ] Models downloaded successfully
- [ ] Test generation works
- [ ] Auto-start configured (verify on pod restart)
- [ ] No warnings displayed to user
- [ ] Logs are clean and informative

### Health Checks (6-Point Verification)

Scripts include automated health checks:
1. Python/pip availability
2. Git clone success
3. Requirements installation
4. Custom nodes installation
5. Directory structure created
6. Services running (ComfyUI on :8188, Kohya on :7860)

---

## Troubleshooting Common Issues

### "Python not found"

**Cause**: Script assumed `python` but system has `python3`

**Fix**: v6.0.0 auto-detects (lines 47-62 in setup-comfyui-pro-v6.0.0.sh)

### "crontab: command not found"

**Cause**: Missing cron package (some container images)

**Fix**: v6.0.0 auto-installs or gracefully skips

### "numpy dependency conflict"

**Cause**: Old numpy (1.26.4) incompatible with opencv-contrib-python

**Fix**: v6.0.0 explicitly upgrades numpy to >=2.0.0 before other installs

### "GUI never auto-starts"

**Cause**: Setup only configured hooks but didn't launch immediately

**Fix**: v6.0.0 includes `start_comfyui()` function that launches immediately

### "localhost:8188 shown in RunPod"

**Cause**: Hard-coded URL instead of environment detection

**Fix**: v6.0.0 includes `get_runpod_url()` that detects and displays correct public URL

---

## Important Notes for Claude Code

### NEVER Do This

- ❌ Create new script versions (v6.0.0 is final, development phase closed)
- ❌ Modify production scripts without CEO approval
- ❌ Commit directly to `main` branch
- ❌ Push sensitive info (API keys, tokens, credentials)
- ❌ Delete logs without archiving
- ❌ Change PyTorch versions without testing both pods
- ❌ Remove environment variable settings
- ❌ Simplify error handling to make code "cleaner"

### ALWAYS Do This

- ✅ Test scripts on RunPod before committing
- ✅ Create feature branches for all changes
- ✅ Write detailed commit messages
- ✅ Update documentation when changing functionality
- ✅ Preserve logs (append, don't overwrite)
- ✅ Ask Michael for product decisions
- ✅ Flag technical risks early
- ✅ Focus on course building tasks (current phase)

### When in Doubt

- **Technical decisions**: CTO (Orion/Claude Code) has authority
- **Product decisions**: CEO (Michael) has final say
- **Timeline conflicts**: Discuss with Michael, negotiate scope vs time
- **Script bugs**: Fix immediately if critical, otherwise create issue

---

## Version History

### v6.0.0 (2025-11-17) - PRODUCTION FINAL ✅

**Critical Fixes**:
- Missing crontab dependency
- numpy dependency conflict
- GUI never auto-starts

**UEX Improvements**:
- RunPod URL auto-detection
- Environment variables set explicitly
- Removed unnecessary folders
- Optimized for RunPod templates

**Status**: Zero-compromise standard achieved, development phase closed

### v5.0.0 (2025-11-16)

**Added**:
- Python command detection
- Error handling with retry logic
- Idempotent design
- Auto-start configuration
- Health checks

**Issues**: Crontab dependency, numpy conflict, GUI auto-start (fixed in v6.0.0)

### v4.0.0 and earlier

Legacy versions, archived. Do not use.

---

## Resources

### External Documentation

- ComfyUI: https://github.com/comfyanonymous/ComfyUI
- Kohya_ss: https://github.com/bmaltais/kohya_ss
- RunPod: https://runpod.io/console/pods
- Teachable: https://teachable.com

### Internal Documentation

- Complete Git workflows: `GIT-WORKFLOW-GUIDE.md`
- CEO/CTO collaboration: `ROLES-AND-RESPONSIBILITIES-REFINED.md`
- Strategic plan: `STRATEGIC-ROADMAP.md`
- Technical deep-dive: `ADVANCED-REFERENCE.md`
- v6.0.0 documentation: `README-v6.0.0.md`

---

## Quick Command Reference

```bash
# Setup
./setup-comfyui-pro-v6.0.0.sh
./download-models-pro-v6.0.0.sh
./setup-kohya-pro-v5.0.0.sh

# Check status
git status
git log --oneline -10

# View logs
tail -100 /workspace/logs/comfyui-setup-*.log
tail -f /workspace/logs/comfyui.log

# Restart services
cd /workspace/ComfyUI && python main.py --listen 0.0.0.0 --port 8188
cd /workspace/kohya_ss && source venv/bin/activate && python gui.py --listen 0.0.0.0 --server_port 7860

# Git workflow
git checkout -b claude/feature-name-sessionid
git add .
git commit -m "Descriptive message"
git push -u origin claude/feature-name-sessionid
```

---

**Last Updated**: 2025-11-20
**Document Owner**: CTO (Orion/Claude Code)
**Review Frequency**: Update when major changes occur (new phases, architectural decisions)
