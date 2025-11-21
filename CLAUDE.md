# CLAUDE.md

**Document Type**: AI Assistant Configuration & Project Specification
**Target Audience**: Claude Code (claude.ai/code) and compatible AI assistants
**Classification**: Internal - Technical Authority
**Last Updated**: 2025-11-21
**Version**: 2.0.0 (Nuclear Rewrite)

---

## I. EXECUTIVE CONTEXT

### 1.1 Project Identity

```yaml
project:
  name: "Dreamforge AI Character Creation System"
  repository: "Kristina0810/didactic-giggle"
  entity: "Karman Global LLC"
  dba: "Dreamforge"

structure:
  ceo:
    name: "Michael Morillo"
    authority: ["product", "business", "strategy", "final_approval"]
  cto:
    name: "Orion/Claude Code"
    authority: ["technical", "architecture", "security", "implementation"]
```

### 1.2 Business Model

```
Phase 1: AI Influencer Launch → Course Development (Current)
Phase 2: Course Sales → Revenue Validation (6-8 weeks)
Phase 3: SaaS Platform Development (12-18 months, conditional)

Trigger for Phase 3:
  - 500+ students enrolled
  - $150K+ revenue achieved
  - Specific unmet needs documented
```

### 1.3 Current Phase Status

```yaml
phase: "Course Building"
status: "Active Development"
focus: "Educational Product Creation"
infrastructure_status: "FROZEN - v6.0.0 Final"
script_development: "TERMINATED - Zero new versions"
```

**Critical Decision**: Script development phase permanently closed. v6.0.0 meets production standard. Opportunity cost analysis shows diminishing returns on further optimization vs revenue-generating activities.

---

## II. REPOSITORY ARCHITECTURE

### 2.1 File System Inventory

```
Total Assets: 34 files
├── Production Scripts: 3 files (1,730 lines, executable)
├── Legacy Scripts: 7 files (archived, reference only)
├── Documentation: 23 markdown files (~18,500 lines)
└── Configuration: 1 file (.gitignore)
```

### 2.2 Production Scripts (IMMUTABLE)

| File | Lines | Status | Purpose | Critical Notes |
|------|-------|--------|---------|----------------|
| `setup-comfyui-pro-v6.0.0.sh` | 652 | FINAL | ComfyUI installation & configuration | Idempotent, dual auto-start, 6-point health checks |
| `download-models-pro-v6.0.0.sh` | 488 | FINAL | Model acquisition (~15-20GB) | Retry logic, exponential backoff, 10min timeout |
| `setup-kohya-pro-v5.0.0.sh` | 590 | FINAL | Kohya_ss training environment | PyTorch 2.1.2 pinned, isolated venv |

**Modification Policy**: PROHIBITED without CEO approval. Exception: Critical security vulnerabilities (CVE severity ≥8.0).

### 2.3 Documentation Matrix

#### Student-Facing Materials (6 files)
```
00-RUNPOD-SETUP.md       → RunPod account configuration
00-QUICK-START.md        → 30-minute installation path
01-FIRST-CHARACTER.md    → LoRA training fundamentals (2-3h)
01-FIRST-PROJECT.md      → Complete project walkthrough
03-CONTENT-PIPELINE.md   → Batch generation workflow (30min)
04-INSTAGRAM-LAUNCH.md   → Monetization strategy (6-8 weeks)
```

#### Strategic Documents (3 files)
```
STRATEGIC-ROADMAP.md          → 12-week course building plan
PLATFORM-ANALYSIS.md          → Build vs Buy decision record
WEEK-9-EXECUTION-GUIDE.md     → Platform setup (day-by-day)
```

#### Technical Reference (6 files)
```
README.md                     → Project overview & quick start
README-v6.0.0.md              → v6.0.0 comprehensive spec
ADVANCED-REFERENCE.md         → Deep technical (190 pages, archived PLAYBOOK.md)
CHANGELOG.md                  → Version history & decision log
TECH-STACK-RECOMMENDATION.md  → Future SaaS architecture
TECH-ACRONYMS-REFERENCE.md    → Software engineering terminology
```

#### Collaboration Protocols (5 files)
```
ROLES-AND-RESPONSIBILITIES.md          → Original collaboration framework
ROLES-AND-RESPONSIBILITIES-REFINED.md  → Current division of labor
GIT-WORKFLOW-GUIDE.md                  → Complete Git workflows
GIT-QUICK-REFERENCE.txt                → Command quick reference
WORKING-WITH-CLAUDE-CODE.md            → Communication templates
```

#### Templates (2 files)
```
PROJECT-BRIEF-TEMPLATE.md    → Standard project brief structure
PROJECT-BRIEF-EXEMPLAR.md    → Dreamforge SaaS plan (future)
```

#### Legacy/Archive (1 file)
```
A1.md → Manual setup instructions (superseded by v6.0.0 scripts)
```

### 2.4 Script Quality Standards (v6.0.0)

```yaml
required_features:
  - idempotency: "Safe to re-run without side effects"
  - error_handling: "Retry logic with exponential backoff (3 attempts)"
  - logging: "Timestamped, color-coded, persisted to /workspace/logs/"
  - auto_start: "Dual fallback (on_start.sh + cron @reboot)"
  - health_checks: "6-point verification on completion"
  - environment_config: "Explicit variables, .bashrc persistence"

ux_requirements:
  - color_coding: "Green (success), red (error), yellow (warning)"
  - progress_indicators: "Real-time status display"
  - url_detection: "RunPod public URL auto-detection (no localhost)"
  - error_messages: "Actionable, specific, with resolution steps"
```

---

## III. TECHNICAL ARCHITECTURE

### 3.1 Two-Pod System Design

**Pod 1: ComfyUI (Inference)**
```yaml
purpose: "Image generation, batch processing"
pytorch_version: "Latest stable (RunPod template default)"
entry_script: "setup-comfyui-pro-v6.0.0.sh"
port: 8188
auto_start: true
fallback_mechanisms: ["on_start.sh", "cron @reboot"]
custom_nodes: 9
health_check: "6-point verification"
```

**Pod 2: Kohya_ss (Training)**
```yaml
purpose: "LoRA model training"
pytorch_version: "2.1.2 (pinned)"
entry_script: "setup-kohya-pro-v5.0.0.sh"
port: 7860
auto_start: true
python_environment: "Isolated venv"
dependency_stability: "Critical - do not upgrade PyTorch"
```

**Architectural Decision**: Separate pods due to PyTorch version conflicts (ComfyUI: 2.4+, Kohya: 2.1.2). Cost efficiency: Independent start/stop ($20-30/month vs Midjourney Pro $60/month).

### 3.2 Storage Architecture

```
/workspace/ (PERSISTENT - survives pod restarts)
├── ComfyUI/
│   ├── models/
│   │   ├── checkpoints/        → SDXL base models
│   │   ├── vae/                → VAE models
│   │   ├── ipadapter/          → IP-Adapter models (character consistency)
│   │   ├── controlnet/         → ControlNet models (pose control)
│   │   └── upscale_models/     → Upscaler models
│   ├── custom_nodes/           → 9 auto-installed extensions
│   ├── input/                  → User input images
│   ├── output/                 → Generated images
│   └── main.py                 → Entry point
├── kohya_ss/
│   ├── venv/                   → Isolated Python environment
│   └── gui.py                  → Training interface
├── logs/
│   ├── comfyui-setup-*.log     → Setup logs (timestamped)
│   ├── kohya-setup-*.log       → Setup logs (timestamped)
│   ├── comfyui.log             → Runtime logs
│   └── kohya.log               → Runtime logs
├── on_start.sh                 → RunPod auto-start hook
└── activate-kohya.sh           → Manual activation helper
```

**Design Principle**: `/workspace/` is persistent. `/opt/` is ephemeral. All critical data MUST reside in `/workspace/`.

### 3.3 Model Specifications

| Model | Type | Size | Purpose | Download Time |
|-------|------|------|---------|---------------|
| Juggernaut XL v9 | Checkpoint | ~6.5GB | Base SDXL model | ~15-20 min |
| SDXL VAE | VAE | ~335MB | Image encoding/decoding | ~2 min |
| IP-Adapter SDXL | Adapter | ~689MB | Character consistency | ~5 min |
| ControlNet OpenPose XL | ControlNet | ~2.5GB | Pose control | ~10 min |
| RealESRGAN x4 | Upscaler | ~64MB | 4x upscaling | ~1 min |
| UltraSharp V2 | Upscaler | ~67MB | 4x upscaling (detail) | ~1 min |

**Total Storage**: ~15-20GB
**Total Download Time**: ~30-60 minutes (bandwidth dependent)

---

## IV. OPERATIONAL PROCEDURES

### 4.1 Setup Sequence

```bash
# Step 1: Clone repository
cd /workspace
git clone https://github.com/Kristina0810/didactic-giggle.git
cd didactic-giggle

# Step 2: Setup ComfyUI (10-15 minutes)
./setup-comfyui-pro-v6.0.0.sh

# Step 3: Download models (30-60 minutes)
./download-models-pro-v6.0.0.sh

# Step 4: Setup Kohya (separate pod, 15-20 minutes)
./setup-kohya-pro-v5.0.0.sh
```

### 4.2 Health Verification

Scripts execute 6-point automated verification:
1. Python/pip availability check
2. Git clone success verification
3. Requirements installation confirmation
4. Custom nodes installation validation
5. Directory structure integrity check
6. Service availability test (port binding)

### 4.3 Log Management

```bash
# View setup logs
tail -100 /workspace/logs/comfyui-setup-*.log
tail -100 /workspace/logs/kohya-setup-*.log

# Monitor runtime logs
tail -f /workspace/logs/comfyui.log
tail -f /workspace/logs/kohya.log

# Debug specific errors
grep -i "error" /workspace/logs/comfyui-setup-*.log
```

### 4.4 Service Management

```bash
# Restart ComfyUI
cd /workspace/ComfyUI && python main.py --listen 0.0.0.0 --port 8188

# Restart Kohya
cd /workspace/kohya_ss && source venv/bin/activate && python gui.py --listen 0.0.0.0 --server_port 7860

# Check running processes
ps aux | grep -E "(main.py|gui.py)"

# Check port binding
netstat -tlnp | grep -E "(8188|7860)"
```

---

## V. VERSION CONTROL PROTOCOL

### 5.1 Branch Strategy

```yaml
main:
  purpose: "Production-ready code only"
  protection: "Merge requires CEO approval"
  deployment: "Immediate to production"

feature_branches:
  pattern: "claude/[feature-name]-[session-id]"
  purpose: "Development work"
  lifespan: "Delete after merge"

pull_requests:
  required: true
  reviewer: "CEO (Michael Morillo)"
  merge_strategy: "Squash and merge (preferred)"
```

### 5.2 Commit Message Standard

```
[Type] Brief summary (≤50 chars)

Detailed explanation:
- What changed (bullet points)
- Why it changed (rationale)
- Impact/risk assessment (if applicable)

Technical details:
- Files modified: [list]
- Breaking changes: [yes/no]
- Testing performed: [description]

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Type Taxonomy**:
- `[FIX]` - Bug fixes
- `[FEAT]` - New features
- `[DOCS]` - Documentation updates
- `[REFACTOR]` - Code restructuring (no behavior change)
- `[TEST]` - Test additions/modifications
- `[CHORE]` - Maintenance tasks
- `[SECURITY]` - Security patches

### 5.3 Deployment Process

```
1. Feature Development
   └─> Create feature branch
   └─> Implement changes
   └─> Local testing

2. Quality Assurance
   └─> Test on RunPod ComfyUI Template
   └─> Test on RunPod PyTorch Template
   └─> Test on Ubuntu 22.04 (if applicable)

3. Code Review
   └─> Create pull request
   └─> CEO review and feedback
   └─> Address feedback

4. Deployment
   └─> CEO approval
   └─> Merge to main
   └─> Tag version (if release)
   └─> Delete feature branch

5. Post-Deployment
   └─> Monitor logs
   └─> Verify production functionality
   └─> Update documentation
```

---

## VI. COMMUNICATION PROTOCOLS

### 6.1 Decision Authority Matrix

| Domain | Authority | Escalation |
|--------|-----------|------------|
| Product features | CEO | N/A (final) |
| Business strategy | CEO | N/A (final) |
| Pricing/positioning | CEO | N/A (final) |
| Technical architecture | CTO | CEO (if budget/timeline impact) |
| Security implementation | CTO | CEO (if risk ≥ critical) |
| Infrastructure choices | CTO | CEO (if cost > $500/month) |
| Code standards | CTO | CEO (if velocity impact) |
| Git workflow | CTO | CEO (if process conflict) |

### 6.2 Response Time SLA

```yaml
urgent:
  definition: "Production down, revenue blocked, security breach"
  response_time: "<1 hour"

high_priority:
  definition: "Major bug, degraded functionality, user-facing error"
  response_time: "<4 hours"

normal:
  definition: "Feature questions, minor bugs, clarifications"
  response_time: "<24 hours"

low_priority:
  definition: "Optimization ideas, documentation, refactoring"
  response_time: "<48 hours"
```

### 6.3 Status Update Cadence

```yaml
daily:
  when: "End of day (before sign-off)"
  format: "Bullet points: completed, in-progress, blocked, next"

weekly:
  when: "Monday, 30 minutes"
  format: "Review metrics, plan week, identify risks"

monthly:
  when: "First Monday, 1 hour"
  format: "Strategy review, OKR progress, roadmap adjustment"
```

### 6.4 Feature Request Template

```yaml
feature: "[Feature Name]"

user_need: |
  [What problem does this solve?]
  [Who is affected?]
  [Current workaround/pain point?]

success_criteria:
  - "[Specific, measurable criterion 1]"
  - "[Specific, measurable criterion 2]"
  - "[Specific, measurable criterion 3]"

priority:
  level: "[Critical/High/Medium/Low]"
  rationale: "[Why this priority?]"

timeline:
  deadline: "[Hard deadline if any]"
  flexibility: "[Can this be negotiated?]"

constraints:
  - "[Budget/time/technical constraint 1]"
  - "[Budget/time/technical constraint 2]"
```

---

## VII. POLICY ENFORCEMENT

### 7.1 PROHIBITED ACTIONS

```yaml
script_modification:
  - action: "Create new script versions"
  - rationale: "v6.0.0 is final, development phase closed"
  - exception: "CVE severity ≥8.0 with CEO approval"

production_changes:
  - action: "Modify production scripts without approval"
  - rationale: "Risk to 100+ future students"
  - exception: "CEO explicit approval required"

git_violations:
  - action: "Direct commit to main branch"
  - rationale: "Bypass code review"
  - exception: "None (technical enforcement)"

security_violations:
  - action: "Commit API keys, tokens, credentials"
  - rationale: "Security breach risk"
  - exception: "None (use environment variables)"

data_loss:
  - action: "Delete logs without archiving"
  - rationale: "Debugging information loss"
  - exception: "Logs older than 90 days"

dependency_changes:
  - action: "Change PyTorch versions without testing"
  - rationale: "Break both pods simultaneously"
  - exception: "Tested on both pods + CEO approval"

code_degradation:
  - action: "Remove error handling for 'cleaner' code"
  - rationale: "Production reliability degradation"
  - exception: "None (error handling is non-negotiable)"

scope_creep:
  - action: "Add features not in approved spec"
  - rationale: "Timeline/budget overrun"
  - exception: "CEO explicit approval required"
```

### 7.2 MANDATORY ACTIONS

```yaml
testing:
  - action: "Test scripts on RunPod before committing"
  - rationale: "Prevent student-facing failures"
  - verification: "3 environments minimum"

branching:
  - action: "Create feature branch for all changes"
  - rationale: "Enable code review"
  - pattern: "claude/[feature-name]-[session-id]"

documentation:
  - action: "Update docs when changing functionality"
  - rationale: "Prevent documentation drift"
  - affected: "README.md, CLAUDE.md, CHANGELOG.md"

commit_quality:
  - action: "Write detailed commit messages"
  - rationale: "Enable future debugging"
  - format: "See Section 5.2"

log_preservation:
  - action: "Append logs, never overwrite"
  - rationale: "Enable historical debugging"
  - location: "/workspace/logs/"

escalation:
  - action: "Ask Michael for product decisions"
  - rationale: "CEO has product authority"
  - examples: ["pricing", "features", "UX changes"]

risk_flagging:
  - action: "Flag technical risks early"
  - rationale: "Enable proactive mitigation"
  - threshold: "Any risk to timeline/budget/quality"

phase_focus:
  - action: "Focus on course building tasks"
  - rationale: "Current phase priority"
  - avoid: "Infrastructure optimization, new features"
```

### 7.3 Escalation Procedures

```yaml
technical_decision_conflict:
  - step_1: "CTO makes initial recommendation"
  - step_2: "Present trade-offs to CEO"
  - step_3: "CEO makes final decision"
  - step_4: "Document decision rationale"

timeline_conflict:
  - step_1: "Identify scope vs time trade-off"
  - step_2: "Present options with impact analysis"
  - step_3: "CEO negotiates scope or extends timeline"
  - step_4: "Update project plan"

critical_bug_production:
  - step_1: "Immediate notification to CEO (<1 hour)"
  - step_2: "Impact assessment"
  - step_3: "Hotfix or rollback decision"
  - step_4: "Root cause analysis"
  - step_5: "Prevention measures implemented"
```

---

## VIII. TECHNICAL DECISION RECORDS

### 8.1 ADR-001: v6.0.0 as Final Version

```yaml
status: "ACCEPTED"
date: "2025-11-17"
decision: "v6.0.0 is final production version, no further script development"

context:
  - v6.0.0 meets zero-compromise standard
  - 652+488+590 = 1,730 lines of production code
  - All critical features implemented
  - Further optimization shows diminishing returns

consequences:
  positive:
    - Focus shifts to revenue-generating activities (course building)
    - No risk of regression from unnecessary changes
    - Clear handoff to students (stable platform)
  negative:
    - Future improvements require CEO approval
    - Potential missed optimizations
  mitigation:
    - Exception process for critical security issues
    - Re-evaluate in Phase 3 (SaaS development)

rationale: |
  "Premature optimization is the root of all evil" (Donald Knuth)
  Opportunity cost: Every day on scripts ≠ revenue generation
  Market timing: AI influencer space growth requires speed
```

### 8.2 ADR-002: Teachable Pro vs Custom Platform

```yaml
status: "ACCEPTED"
date: "2025-11-15"
decision: "Use Teachable Pro, defer custom platform to Phase 3"

context:
  - 0 students currently (unvalidated market)
  - Custom build: 4-6 months, $70K cost
  - Teachable Pro: 1-2 days, $1,428/year

consequences:
  positive:
    - Immediate launch capability (1-2 days vs 4-6 months)
    - 99.7% cost reduction ($1,428 vs $70K)
    - Market validation before major investment
    - Focus on core competency (AI/ComfyUI expertise)
  negative:
    - Platform fees (10% + $119/month)
    - Less customization control
    - Potential migration effort later
  mitigation:
    - Clear migration trigger: 500 students AND $150K revenue
    - Document unmet needs for future custom build
    - Design course content as platform-agnostic

rationale: |
  Market validation must precede infrastructure investment
  Risk mitigation: Prove demand before scaling
  Premature scaling is a top startup failure cause
```

### 8.3 ADR-003: Two-Pod Architecture

```yaml
status: "ACCEPTED"
date: "2025-11-10"
decision: "Separate ComfyUI and Kohya pods instead of unified system"

context:
  - PyTorch version conflict (ComfyUI: 2.4+, Kohya: 2.1.2)
  - Dependency stability requirements
  - Cost optimization opportunity

consequences:
  positive:
    - No dependency conflicts
    - Independent start/stop (cost savings)
    - Clearer separation of concerns
    - Easier troubleshooting
  negative:
    - Two setup scripts to maintain
    - Storage duplication (minimal)
    - User must understand two-pod concept
  mitigation:
    - Clear documentation (00-RUNPOD-SETUP.md)
    - Automated setup scripts
    - Video walkthrough in course

cost_analysis:
  unified_pod: "$60-80/month (always running)"
  two_pod: "$20-30/month (start/stop independently)"
  savings: "$30-50/month, $360-600/year"

rationale: |
  Technical constraint (PyTorch versions) drives architectural decision
  Cost optimization aligns with lean startup principles
  Student clarity improved with dedicated purpose pods
```

---

## IX. TROUBLESHOOTING MATRIX

### 9.1 Common Issues & Resolutions

| Issue | Root Cause | Resolution | Prevention | File Reference |
|-------|-----------|------------|------------|----------------|
| "Python not found" | Script assumes `python` but system has `python3` | Auto-detection in v6.0.0 | Detect both commands | setup-comfyui-pro-v6.0.0.sh:47-62 |
| "crontab: command not found" | Missing cron package | Auto-install or graceful skip | Check package availability | setup-comfyui-pro-v6.0.0.sh:180-195 |
| "numpy dependency conflict" | Old numpy (1.26.4) incompatible with opencv | Explicit upgrade to ≥2.0.0 | Pre-upgrade before dependencies | setup-comfyui-pro-v6.0.0.sh:220-235 |
| "GUI never auto-starts" | Setup only configured hooks | Immediate launch + hooks | start_comfyui() function | setup-comfyui-pro-v6.0.0.sh:520-545 |
| "localhost:8188 shown" | Hard-coded URL | RunPod URL auto-detection | get_runpod_url() function | setup-comfyui-pro-v6.0.0.sh:85-105 |
| "Port already in use" | Previous process not killed | Kill existing process | PID file management | setup-comfyui-pro-v6.0.0.sh:550-560 |
| "Models not downloading" | Network timeout or HuggingFace rate limit | Retry with exponential backoff | 3 attempts, 10min timeout | download-models-pro-v6.0.0.sh:150-180 |

### 9.2 Diagnostic Procedures

```bash
# System health check
df -h /workspace                    # Check storage availability
ps aux | grep -E "(python|main.py)" # Check running processes
netstat -tlnp | grep 8188           # Check port binding

# ComfyUI diagnostics
tail -100 /workspace/logs/comfyui-setup-*.log | grep -i error
curl http://localhost:8188          # Check service response
ls -lh /workspace/ComfyUI/models/checkpoints/  # Verify models

# Kohya diagnostics
tail -100 /workspace/logs/kohya-setup-*.log | grep -i error
source /workspace/kohya_ss/venv/bin/activate && python --version
ls -lh /workspace/kohya_ss/         # Verify installation

# Network diagnostics
ping -c 3 huggingface.co            # Check HuggingFace connectivity
curl -I https://github.com          # Check GitHub connectivity
```

---

## X. COURSE BUILDING PHASE (CURRENT)

### 10.1 Phase Status

```yaml
status: "Active Development"
start_date: "2025-11-17"
duration: "12 weeks"
completion_target: "2025-02-07"

milestones:
  weeks_1_8: "Content production (6 modules, 720 minutes)"
  weeks_9_10: "Platform setup + marketing"
  week_11: "Beta launch (10-20 students)"
  week_12: "Public launch (target 100 students)"

revenue_target:
  first_90_days: "$29,700"
  average_sale: "$297"
  students_required: 100
```

### 10.2 Module Structure

```yaml
module_1:
  title: "Zero to ComfyUI"
  duration: "45 minutes"
  content: ["Installation", "First image generation", "UI navigation"]

module_2:
  title: "Character Generation Workflow"
  duration: "130 minutes"
  content: ["Prompting techniques", "IP-Adapter usage", "Consistency methods"]

module_3:
  title: "Production Workflows"
  duration: "175 minutes"
  content: ["Batch generation", "Quality control", "Asset management"]

module_4:
  title: "AI Influencer Creation"
  duration: "235 minutes"
  content: ["LoRA training", "Character consistency", "Style development"]

module_5:
  title: "Scaling & Automation"
  duration: "115 minutes"
  content: ["Workflow automation", "API integration", "Batch processing"]

module_6:
  title: "Business & Legal"
  duration: "120 minutes"
  content: ["Monetization", "Copyright", "Platform strategies"]
```

### 10.3 Pricing Strategy

```yaml
tier_1:
  name: "ComfyUI Character Creator"
  price: "$197"
  positioning: "Entry level, basic access"

tier_2:
  name: "AI Influencer Pro"
  price: "$497"
  positioning: "Most popular, includes community"
  target: "70% of sales"

tier_3:
  name: "Enterprise License"
  price: "$2,997"
  positioning: "Includes 1-on-1 consulting"
  target: "5% of sales (high value)"
```

### 10.4 Platform: Teachable Pro

```yaml
cost: "$119/month + 10% transaction fee"
setup_time: "1-2 days"
features:
  - "Unlimited students"
  - "Custom domain"
  - "No Teachable branding"
  - "Advanced analytics"
  - "Email marketing integration"

setup_guide: "WEEK-9-EXECUTION-GUIDE.md"
decision_rationale: "See ADR-002 (Section 8.2)"
```

---

## XI. QUALITY ASSURANCE

### 11.1 Pre-Commit Checklist

```yaml
code_changes:
  - [ ] Feature branch created (pattern: claude/[name]-[id])
  - [ ] Code implements approved specification only
  - [ ] No hardcoded credentials or API keys
  - [ ] Error handling implemented
  - [ ] Logging added (appropriate level)
  - [ ] Comments added for complex logic

testing:
  - [ ] Tested on RunPod ComfyUI Template
  - [ ] Tested on RunPod PyTorch Template
  - [ ] Tested on Ubuntu 22.04 (if applicable)
  - [ ] All health checks pass
  - [ ] No warnings displayed to user
  - [ ] Logs are clean and informative

documentation:
  - [ ] README.md updated (if user-facing change)
  - [ ] CLAUDE.md updated (if process change)
  - [ ] CHANGELOG.md updated (if version bump)
  - [ ] Code comments added (if complex logic)

git:
  - [ ] Commit message follows standard (Section 5.2)
  - [ ] All changes staged (git add)
  - [ ] No unrelated changes included
  - [ ] Branch pushed to remote

review:
  - [ ] Pull request created
  - [ ] Description includes rationale
  - [ ] CEO notified for review
```

### 11.2 Health Check Specifications

```yaml
check_1_python:
  command: "python --version || python3 --version"
  success: "Exit code 0, version ≥3.8"
  failure: "Install Python 3.8+"

check_2_git:
  command: "git clone https://github.com/comfyanonymous/ComfyUI.git"
  success: "Exit code 0, directory created"
  failure: "Check network, GitHub access"

check_3_requirements:
  command: "pip install -r requirements.txt"
  success: "Exit code 0, no errors"
  failure: "Check pip, Python version, disk space"

check_4_custom_nodes:
  command: "git clone [custom node repo]"
  success: "9/9 nodes cloned successfully"
  failure: "Check network, disk space"

check_5_directories:
  command: "ls -ld /workspace/{ComfyUI,logs}"
  success: "Both directories exist"
  failure: "Check permissions, disk space"

check_6_service:
  command: "curl http://localhost:8188"
  success: "HTTP 200 response"
  failure: "Check port binding, process running, firewall"
```

---

## XII. REFERENCE DATA

### 12.1 External Resources

```yaml
comfyui:
  repository: "https://github.com/comfyanonymous/ComfyUI"
  documentation: "https://github.com/comfyanonymous/ComfyUI/wiki"

kohya_ss:
  repository: "https://github.com/bmaltais/kohya_ss"
  documentation: "https://github.com/bmaltais/kohya_ss/wiki"

runpod:
  console: "https://runpod.io/console/pods"
  documentation: "https://docs.runpod.io/"

teachable:
  platform: "https://teachable.com"
  documentation: "https://support.teachable.com/"
```

### 12.2 Internal Documentation Index

```yaml
quick_start:
  - "README.md"
  - "00-QUICK-START.md"
  - "00-RUNPOD-SETUP.md"

technical_deep_dive:
  - "README-v6.0.0.md"
  - "ADVANCED-REFERENCE.md"
  - "TECH-STACK-RECOMMENDATION.md"
  - "TECH-ACRONYMS-REFERENCE.md"

workflow_guides:
  - "GIT-WORKFLOW-GUIDE.md"
  - "GIT-QUICK-REFERENCE.txt"
  - "WORKING-WITH-CLAUDE-CODE.md"

strategic_documents:
  - "STRATEGIC-ROADMAP.md"
  - "PLATFORM-ANALYSIS.md"
  - "WEEK-9-EXECUTION-GUIDE.md"

collaboration:
  - "ROLES-AND-RESPONSIBILITIES-REFINED.md"
  - "PROJECT-BRIEF-TEMPLATE.md"
  - "PROJECT-BRIEF-EXEMPLAR.md"

version_history:
  - "CHANGELOG.md"
```

### 12.3 Command Quick Reference

```bash
# === SETUP ===
./setup-comfyui-pro-v6.0.0.sh
./download-models-pro-v6.0.0.sh
./setup-kohya-pro-v5.0.0.sh

# === GIT ===
git status
git log --oneline -10
git checkout -b claude/[feature]-[id]
git add .
git commit -m "[Type] Brief summary"
git push -u origin claude/[feature]-[id]

# === LOGS ===
tail -100 /workspace/logs/comfyui-setup-*.log
tail -f /workspace/logs/comfyui.log
grep -i error /workspace/logs/*.log

# === SERVICES ===
cd /workspace/ComfyUI && python main.py --listen 0.0.0.0 --port 8188
cd /workspace/kohya_ss && source venv/bin/activate && python gui.py --listen 0.0.0.0 --server_port 7860

# === DIAGNOSTICS ===
ps aux | grep -E "(main.py|gui.py)"
netstat -tlnp | grep -E "(8188|7860)"
df -h /workspace
```

---

## XIII. DOCUMENT METADATA

```yaml
document:
  name: "CLAUDE.md"
  type: "AI Assistant Configuration"
  version: "2.0.0"
  status: "Active"

versioning:
  current: "2.0.0 (Nuclear Rewrite)"
  previous: "1.x (Archived)"
  next_update: "On major phase change or critical decision"

ownership:
  author: "CTO (Orion/Claude Code)"
  approver: "CEO (Michael Morillo)"
  maintainer: "CTO"

review_schedule:
  frequency: "As needed (event-driven)"
  triggers:
    - "Phase transition"
    - "Major architectural decision"
    - "Process change"
    - "Policy update"

compliance:
  standards: ["YAML specification", "Markdown CommonMark"]
  accessibility: "Internal team only"
  classification: "Technical Authority"
```

**End of Document**
