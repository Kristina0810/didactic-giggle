# 🎨 YOUR FIRST CHARACTER PROJECT

**Prerequisites:** Completed `00-RUNPOD-SETUP.md` and all services running.

**Time Required:** 1-2 hours for setup, then 7 days for complete character  
**Outcome:** Your first S-tier AI character

---

## 🎯 **WHAT YOU'LL CREATE**

By the end of this guide, you'll have:
- ✓ Complete project structure
- ✓ Character concept defined
- ✓ Ready to start Day 1 (Patient Zero creation)

**This guide covers:** Day 0 only (Pre-production setup)  
**Next guide covers:** Days 1-7 execution

---

## 📋 **STEP 1: CREATE PROJECT**

### 1.1: Use the Orchestrator

The toolkit includes an interactive project creator:

```bash
cd /workspace/s-tier-character-creation
./tools/character-creation.sh
```

**You'll see:**
```
====================================================================
  S-TIER CHARACTER CREATION TOOLKIT
  Version 2.0 Ultimate Edition
====================================================================

Main Menu:

  1) Validate Setup (Run first time)
  2) Create New Character Project
  3) Resume Existing Project
  ...
```

### 1.2: Validate Setup (First Time Only)

Select option **1** to validate your system:

```
Select option (1-9): 1
```

**This checks:**
- GPU availability
- Python packages
- Disk space
- Running services
- Base models

**Wait:** ~30 seconds for validation

**Expected result:** "✓ System ready for character creation"

**If any failures:** Follow the instructions to fix issues, then revalidate.

---

## 📝 **STEP 2: CREATE NEW PROJECT**

### 2.1: Start Project Creation

From main menu, select option **2**:

```
Select option (1-9): 2
```

### 2.2: Name Your Character

```
Character name (e.g., Luna, Marcus, Aria): Luna
```

**Guidelines:**
- Use a real-sounding name
- Single word preferred
- Capitalized (Luna not LUNA)
- Avoid special characters

**The system creates:** `/workspace/projects/luna/`

### 2.3: Review Structure

The orchestrator creates this complete structure:

```
/workspace/projects/luna/
├── CHARACTER_BRIEF.md          # Character design spec
├── README.md                   # Project info
├── .progress                   # Progress tracker
├── refs/                       # Reference images
├── patient_zero/               # Day 1: Reference creation
│   ├── raw_generation/
│   ├── candidates/
│   ├── selection/
│   └── final/
├── dataset/                    # Days 2-3: Training data
│   ├── generation_raw/
│   ├── generation_curated/
│   ├── captioned/
│   └── final_training/
│       └── 10_luna/           # Training images here
├── training/                   # Day 4: LoRA training
│   ├── configs/
│   ├── logs/
│   ├── checkpoints/
│   └── reports/
├── testing/                    # Day 5: Quality assurance
├── workflows/                  # Day 6: Production workflows
└── outputs/                    # Day 7: Final deliverables
```

**✓ Checkpoint:** Project structure created at `/workspace/projects/luna/`

---

## 📖 **STEP 3: DEFINE YOUR CHARACTER**

### 3.1: Open Character Brief

```bash
cd /workspace/projects/luna
nano CHARACTER_BRIEF.md
```

**Or use Jupyter:**
- Open JupyterLab (use `titan url` to get link)
- Navigate to `/workspace/projects/luna/`
- Open `CHARACTER_BRIEF.md`

### 3.2: Fill Out the Template

The template has these sections:

**PROJECT INFORMATION**
- Character name
- Trigger word (unique identifier for training)
- Timeline

**CORE IDENTITY**
- Age, gender, ethnicity
- Primary use cases

**PHYSICAL CHARACTERISTICS**
- Face structure (detailed!)
- Hair (color, length, style)
- Skin (tone, texture)
- Build & height

**PERSONALITY & PRESENTATION**
- Default expression
- Expression range
- Style & aesthetic

**TECHNICAL SPECIFICATIONS**
- Quality targets (≥87% consistency)
- Training parameters

### 3.3: Example Character

Here's a complete example to guide you:

```markdown
# Character Design Brief

## PROJECT INFORMATION
**Character Name:** Luna  
**Trigger Word:** luna_stellar  
**Creation Date:** 2025-11-10  
**Target Completion:** 2025-11-17

## CORE IDENTITY

### Basic Information
- **Apparent Age:** 28
- **Gender Presentation:** Female
- **Ethnicity:** Mixed Asian-European
- **Archetype:** "Tech entrepreneur with artistic soul"

### Primary Use Cases
1. LinkedIn professional headshots
2. Tech startup marketing materials
3. Social media content creator persona

## PHYSICAL CHARACTERISTICS

### Face Structure
- **Face Shape:** Oval with soft angles
- **Facial Features:**
  - Eyes: Deep brown, almond-shaped with natural sparkle
  - Nose: Straight, medium-sized, refined
  - Lips: Medium fullness, natural rose tone
  - Jawline: Soft, defined but not sharp
  - Cheekbones: Prominent, elegant

### Hair
- **Color:** Dark brown with subtle auburn highlights
- **Length:** Shoulder-length
- **Texture:** Straight with slight wave, medium density
- **Default Style:** Loose, parted slightly off-center

### Skin
- **Tone:** Medium warm olive (Fitzpatrick Type IV)
- **Texture:** Smooth, even with natural healthy glow
- **Distinctive Features:** Small beauty mark above right lip

### Build & Height
- **Height Appearance:** Average to tall presence
- **Build:** Slender, toned, athletic but not muscular
- **Posture:** Confident, upright, shoulders back

## PERSONALITY & PRESENTATION

### Default Expression
Calm confidence with gentle warmth. Approachable yet professional. 
Slight hint of intelligence in the eyes.

### Key Expression Range
- Neutral: Composed, present, slightly warm
- Happy: Genuine smile reaching eyes, inviting
- Serious: Focused, determined, commanding presence
- Thoughtful: Contemplative, introspective, wise

### Style & Aesthetic
- **Fashion Style:** Modern minimalist with tech-forward edge
- **Color Palette:** Navy, charcoal, white, occasional deep burgundy
- **Accessories:** Minimal - small stud earrings, simple watch

### Personality Traits (for prompting)
- Confident
- Intelligent
- Approachable
- Professional
- Creative

## TECHNICAL SPECIFICATIONS

### Quality Targets
- **Consistency Target:** ≥87% (aiming for 90%+)
- **Technical Quality:** 9/10 minimum
- **Commercial Grade:** Yes
- **Production Ready:** Day 7

### Training Parameters (Initial)
- **Dataset Size:** 800 images
- **LoRA Rank:** 128
- **Learning Rate:** 1e-4
- **Epochs:** 10

**Status:** In Planning  
**Next Action:** Complete this brief, then run Day 0 setup
```

### 3.4: Key Guidelines

**BE SPECIFIC:**
- ❌ "Pretty eyes" 
- ✓ "Deep brown almond-shaped eyes"

**BE CONSISTENT:**
- Describe what you want EVERY time
- This becomes your reference

**BE REALISTIC:**
- Don't describe impossible features
- Avoid conflicting details

**✓ Checkpoint:** CHARACTER_BRIEF.md completed and saved

---

## 🎯 **STEP 4: CHOOSE TRIGGER WORD**

### What's a Trigger Word?

**Definition:** A unique word/phrase that activates your character in prompts.

**Example:** Instead of describing Luna every time, you just type "luna_stellar" and the AI knows who you mean.

### 4.1: Requirements

**Must be:**
- Unique (not a common word)
- Memorable
- Related to character (optional but helpful)
- 1-2 words max
- No spaces (use underscore)

**Examples:**
- `luna_stellar` (character name + descriptor)
- `aria_quantum` (name + vibe)
- `marcus_iron` (name + trait)
- `zara_neon` (name + aesthetic)

### 4.2: Bad Trigger Words

**Avoid:**
- Common words: `woman`, `person`, `girl`
- Generic: `character1`, `my_character`
- Too similar to existing: `superman`, `wonderwoman`

### 4.3: Set Your Trigger Word

Run the concept definition script:

```bash
cd /workspace/projects/luna
python3 /workspace/s-tier-character-creation/scripts/day0-setup/define_character_concept.py /workspace/projects/luna
```

**You'll be prompted:**
```
Enter trigger word: luna_stellar
```

**This saves:** `dataset/TRIGGER_WORD.txt`

**✓ Checkpoint:** Trigger word saved

---

## ✅ **STEP 5: COLLECT REFERENCE IMAGES**

### 5.1: What You Need

Gather 10-15 reference images that inspire your character:

**Sources:**
- Pinterest boards
- Stock photo sites (Unsplash, Pexels)
- Fashion photography
- Portrait photography
- AI-generated references (optional)

**Guidelines:**
- High quality (HD minimum)
- Clear faces
- Good lighting
- Similar to desired aesthetic

### 5.2: Save References

```bash
cd /workspace/projects/luna/refs
```

**Upload your reference images here using:**
- JupyterLab file upload
- SCP/SFTP
- wget (if online)

**✓ Checkpoint:** 10-15 reference images in `refs/` folder

---

## 🔧 **STEP 6: VALIDATE PRE-PRODUCTION**

### 6.1: Run Prerequisites Check

```bash
cd /workspace/projects/luna
bash /workspace/s-tier-character-creation/scripts/day0-setup/verify_prerequisites.sh
```

**This verifies:**
- ✓ Project structure complete
- ✓ CHARACTER_BRIEF.md filled out
- ✓ Trigger word set
- ✓ GPU accessible
- ✓ ComfyUI running
- ✓ Sufficient disk space

**Expected output:**
```
====================================================================
  VERIFICATION SUMMARY
====================================================================

Errors: 0
Warnings: 0

✓ ALL PREREQUISITES MET

Ready to start Day 1: Patient Zero Creation
```

**If any errors:** Fix them before proceeding.

**✓ Checkpoint:** All prerequisites verified

---

## 📊 **STEP 7: UNDERSTAND THE 7-DAY PROCESS**

Before you start, here's what happens next:

### **Day 0: Pre-Production** ✓ (You just completed this!)
- Define character concept
- Set up project structure
- Gather references

### **Day 1: Patient Zero** (6 hours)
- Generate 120 test images
- Select perfect reference image
- This becomes your ground truth

### **Day 2: Dataset Generation** (8 hours)
- Generate 1000+ images systematically
- Cover all angles, expressions, lighting

### **Day 3: Dataset Refinement** (7 hours)
- Curate best 800 images
- Add captions to each
- Prepare final training dataset

### **Day 4: LoRA Training** (7 hours)
- Train character model
- 3-4 hours GPU time
- Creates 5 checkpoint models

### **Day 5: Quality Assurance** (7 hours)
- Test all checkpoints
- Measure consistency (target ≥87%)
- Select best model

### **Day 6: Production Workflows** (7 hours)
- Create ComfyUI workflows
- Test different use cases
- Validate production readiness

### **Day 7: Documentation & Delivery** (7 hours)
- Generate portfolio (40 images)
- Create documentation
- Package deliverables

**Total:** ~50 hours work across 7 days (can be done faster with automation)

---

## 🚀 **STEP 8: START DAY 1**

### 8.1: What You'll Do

Day 1 is about creating your "Patient Zero" - the perfect reference image.

**Process:**
1. Generate 120 images using master prompt
2. Organize into batches
3. Quality check each batch
4. Select top candidates
5. Choose/create the perfect one

### 8.2: Generate Master Prompt

```bash
cd /workspace/projects/luna
python3 /workspace/s-tier-character-creation/scripts/day1-patient-zero/generate_master_prompt.py /workspace/projects/luna
```

**This creates:** `patient_zero/MASTER_PROMPT.txt`

**Example output:**
```
28 year old female, mixed asian-european, oval face, 
deep brown almond-shaped eyes, shoulder-length dark brown hair 
in loose waves, medium warm olive skin, calm confidence with warmth, 
neutral expression, front facing, head and shoulders portrait, 
natural lighting, professional photography, detailed face, 
sharp focus, high quality, photorealistic, 8k uhd
```

### 8.3: Open ComfyUI

Get your URL:
```bash
titan url comfyui
```

**Click the URL** to open ComfyUI in browser.

### 8.4: Start Generation

**In ComfyUI:**
1. Load default workflow (or any SDXL workflow)
2. Copy master prompt into positive prompt
3. Negative prompt: "worst quality, low quality, blurry, deformed"
4. Settings:
   - Model: JuggernautXL_v9 (or your chosen checkpoint)
   - Steps: 28-30
   - CFG: 7.5
   - Sampler: DPM++ 2M Karras
   - Resolution: 1024x1024
   - Seed: Random (-1)
5. Generate 30 images
6. Repeat 4 times (total: 120 images)
7. Save all to `patient_zero/raw_generation/`

**Time estimate:** 10-15 minutes per batch of 30 (RTX 5090)

**✓ Checkpoint:** 120 images generated

---

## 📚 **STEP 9: CONTINUE WITH DAY 1**

From here, you'll use the Day 1 automation scripts:

```bash
# Organize batches
./scripts/day1-patient-zero/organize_batches.sh

# Review quality (for each batch)
python3 ./scripts/day1-patient-zero/qc_batch.py batch1
python3 ./scripts/day1-patient-zero/qc_batch.py batch2
python3 ./scripts/day1-patient-zero/qc_batch.py batch3
python3 ./scripts/day1-patient-zero/qc_batch.py batch4

# Select top candidates
python3 ./scripts/day1-patient-zero/selection_tool.py

# Review blending guide
bash ./scripts/day1-patient-zero/blending_guide.sh

# Create Patient Zero (manual in ComfyUI)

# Final validation
python3 ./scripts/day1-patient-zero/final_validation.py
```

**Full instructions:** See `docs/02-UNDERSTANDING-THE-PROCESS.md` for complete Day 1-7 details.

---

## 🎉 **CONGRATULATIONS!**

**You've completed Day 0!**

You now have:
- ✓ Complete project structure
- ✓ Character fully defined
- ✓ Trigger word set
- ✓ Reference images gathered
- ✓ System validated
- ✓ Ready to create Patient Zero

---

## 🔄 **PROJECT MANAGEMENT**

### Check Progress

```bash
./tools/character-creation.sh
```

Select option **3** to resume project and see progress.

### Track Status

The `.progress` file tracks your completion:

```bash
cd /workspace/projects/luna
cat .progress
```

### Update Progress Manually

When you complete a day:

```bash
# Example: Completed Day 1
sed -i 's/day1_patient_zero: pending/day1_patient_zero: complete/' .progress
```

---

## 💾 **BACKUP YOUR PROJECT**

After completing significant work, backup:

```bash
/workspace/s-tier-character-creation/infrastructure/runpod/titan-backup.sh
```

**This saves:**
- All projects
- Trained LoRAs
- Configs
- Workflows

**To:** `/workspace/backups/`

---

## ❓ **COMMON QUESTIONS**

### **Q: Can I create multiple characters?**

Yes! Run the orchestrator again and create a new project:
```bash
./tools/character-creation.sh
```
Select option 2, use different name.

### **Q: How long does one character take?**

**Minimum:** 3-4 days (aggressive)  
**Recommended:** 7 days (quality focus)  
**Professional:** 7-10 days (perfection)

### **Q: Can I skip days?**

No. Each day builds on previous work. Skipping reduces quality.

### **Q: What if I make a mistake?**

Most days can be redone:
- Day 1: Regenerate Patient Zero
- Days 2-3: Re-curate dataset
- Day 4: Retrain with different settings
- Days 5-7: Can iterate

### **Q: How much does it cost?**

**GPU time:** ~$10-20 for complete character (RTX 5090 @ $1.29/hr)  
**Storage:** ~$8/month for 100GB  
**Total:** ~$20-30 for first character

---

## 🆘 **TROUBLESHOOTING**

### **Problem: Can't save CHARACTER_BRIEF.md**

**Solution:** Check file permissions
```bash
cd /workspace/projects/luna
chmod 644 CHARACTER_BRIEF.md
```

### **Problem: Scripts won't run**

**Solution:** Make executable
```bash
cd /workspace/s-tier-character-creation
find scripts -name "*.py" -o -name "*.sh" | xargs chmod +x
```

### **Problem: ComfyUI generation is slow**

**Solutions:**
- Check GPU usage: `nvidia-smi`
- Reduce batch size
- Lower resolution
- Restart ComfyUI: `titan restart comfyui`

---

## ✅ **DAY 0 CHECKLIST**

Before moving to Day 1, verify:

- [ ] Project created at `/workspace/projects/[name]/`
- [ ] CHARACTER_BRIEF.md completed thoroughly
- [ ] Trigger word chosen and saved
- [ ] 10-15 reference images collected
- [ ] Prerequisites check passed
- [ ] Master prompt generated
- [ ] ComfyUI accessible and working
- [ ] Understand 7-day process
- [ ] Ready to commit time to Day 1

**All checked?** → You're ready for Day 1!

---

## 🎯 **NEXT STEPS**

1. **Read:** `docs/02-UNDERSTANDING-THE-PROCESS.md`
2. **Execute:** Day 1 (Patient Zero creation)
3. **Use:** All automation scripts in `scripts/day1-patient-zero/`

**Time commitment for Day 1:** 6 hours (including generation time)

---

**Good luck creating your first S-tier character!** 🎨

---

**Version:** 1.0  
**Part of:** S-Tier Character Creation Toolkit v2.0  
**Next:** `02-UNDERSTANDING-THE-PROCESS.md`
