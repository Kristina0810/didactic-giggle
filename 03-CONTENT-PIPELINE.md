# Content Pipeline: Generate 50 Images in 60 Minutes

**Goal:** Build a production workflow for batch-generating consistent AI character content.

**What You'll Learn:**
- Advanced ComfyUI workflow (IPAdapter + ControlNet + LoRA)
- Batch generation techniques
- Prompt engineering for variety
- Quality control filtering
- Post-processing for Instagram

**Time Estimate:** 30 minutes setup, then generate forever

---

## The World-Class Consistency Stack

**Three Layers of Character Consistency:**

1. **LoRA** (Layer 1: Face/Identity)
   - Trained on YOUR character's photos
   - Ensures consistent facial features

2. **IP-Adapter** (Layer 2: Style/Aesthetic)
   - Reference image input
   - Maintains style consistency across all outputs

3. **ControlNet** (Layer 3: Pose/Composition)
   - Pose control (OpenPose skeleton)
   - Ensures varied but natural poses

**Result:** Every image = YOUR character's face + consistent style + diverse poses

**This is how AI Tana, Lil Miquela, and top AI influencers maintain perfect consistency**

---

## Step 1: Setup Advanced ComfyUI Workflow (20 minutes)

### 1.1 Required Custom Nodes

**Verify installation** (should be installed from setup-comfyui-pro-v5.0.0.sh):
```bash
cd /workspace/runpod-slim/ComfyUI/custom_nodes
ls -1
```

**You should see:**
- ✅ ComfyUI-Manager
- ✅ ComfyUI_IPAdapter_plus
- ✅ comfyui_controlnet_aux
- ✅ ComfyUI-Impact-Pack
- ✅ (others)

### 1.2 Download Professional Workflow

**In RunPod terminal:**
```bash
cd /workspace/workflows
wget https://raw.githubusercontent.com/Kristina0810/didactic-giggle/main/workflows/character-consistency-pro.json
```

*(Note: This workflow will be added to the repo after this session)*

**Manual Workflow Build** *(if wget fails - see section 1.3 below)*

### 1.3 Build Workflow from Scratch

**In ComfyUI interface:**

**Core Nodes to Add:**
1. **Checkpoint Loader** (base model)
2. **Load LoRA** (your character)
3. **IPAdapter** (style consistency)
4. **ControlNet Loader** (pose control)
5. **ControlNet Apply** (apply pose)
6. **CLIP Text Encode** x2 (positive/negative prompts)
7. **KSampler** (generation engine)
8. **VAE Decode** (latent to image)
9. **Save Image** (output)

**Node Connection Flow:**
```
Checkpoint Loader ──→ Load LoRA ──→ IPAdapter ──→ KSampler ──→ VAE Decode ──→ Save Image
                                                       ↑
                                        ControlNet Apply ──┘
                                                 ↑
                                        ControlNet Loader
                                                 ↑
                                        OpenPose Preprocessor
                                                 ↑
                                        Load Image (reference pose)
```

**Detailed Configuration** *(screenshot references would be ideal for course)*:

**1. Checkpoint Loader:**
- Model: `Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors`

**2. Load LoRA:**
- LoRA: `character-001-lora.safetensors`
- Strength: `0.7-0.9` (adjust to taste)

**3. IPAdapter:**
- Preset: `PLUS (high strength)`
- Weight: `0.75`
- Reference Image: Upload your best character photo (1024x1024)

**4. ControlNet:**
- Model: `OpenPoseXL2.safetensors`
- Strength: `0.65`
- Preprocessor: `OpenPose Preprocessor`

**5. KSampler:**
- Steps: `25-30`
- CFG: `7.0-8.0`
- Sampler: `DPM++ 2M Karras` (high quality)
- Scheduler: `Karras`
- Denoise: `1.0` (full generation)

---

## Step 2: Prompt Engineering Library (30 minutes)

### 2.1 Prompt Structure

**Anatomy of a Pro Prompt:**
```
[character trigger] [subject], [main action/scene], [style keywords],
[quality tags], [lighting], [additional details]
```

**Example:**
```
ohwx woman, sitting at luxury cafe, elegant business casual outfit,
professional photography, golden hour lighting, bokeh background,
instagram aesthetic, high quality, detailed face
```

### 2.2 Prompt Categories for AI Influencer

**Create a prompt library** - save these as text files in `/workspace/prompts/`

**Category 1: Luxury Lifestyle**
```
ohwx woman in designer boutique, trying on luxury handbag, elegant outfit,
professional photography, bright natural lighting, high fashion, detailed

ohwx woman at 5-star hotel lobby, sitting on velvet sofa, designer dress,
editorial photography, architectural lighting, luxury lifestyle

ohwx woman by infinity pool, luxury resort, elegant swimwear, sunset,
travel photography, golden hour, dreamy aesthetic

ohwx woman in first class airplane seat, business attire, professional,
travel blogger aesthetic, natural window lighting
```

**Category 2: Fitness/Wellness**
```
ohwx woman at gym, activewear, yoga pose on mat, fitness lifestyle,
natural lighting, motivational aesthetic, high quality

ohwx woman running outdoors, park setting, athletic outfit, sunrise,
fitness influencer, dynamic pose, professional sports photography

ohwx woman holding green smoothie, healthy lifestyle, modern kitchen,
bright natural light, wellness aesthetic, clean composition
```

**Category 3: Fashion/Street Style**
```
ohwx woman walking city street, fashionable outfit, candid photography,
urban background, street style, natural lighting, blogger aesthetic

ohwx woman in trendy coffee shop, casual chic outfit, holding latte,
instagram aesthetic, bokeh lights, cozy atmosphere

ohwx woman at art gallery, sophisticated outfit, cultural setting,
editorial photography, museum lighting, artistic composition
```

**Category 4: Night Life/Events**
```
ohwx woman at upscale restaurant, elegant evening dress, dinner setting,
ambient candlelight, luxury dining, romantic atmosphere

ohwx woman at rooftop bar, cocktail in hand, city lights background,
nightlife photography, glamorous outfit, bokeh lights

ohwx woman at fashion event, red carpet setting, gala dress,
professional event photography, flash lighting, celebrity aesthetic
```

**Category 5: Home/Casual**
```
ohwx woman at home, comfortable loungewear, cozy living room,
lifestyle photography, morning sunlight, relatable content

ohwx woman reading book on couch, casual outfit, homey atmosphere,
natural window light, candid moment, peaceful aesthetic

ohwx woman cooking in modern kitchen, casual chic outfit, food blogger,
bright natural light, lifestyle content, approachable vibe
```

### 2.3 Negative Prompt (Universal)

**Use this for ALL generations:**
```
low quality, blurry, distorted, amateur, oversaturated, artificial,
multiple people, deformed face, extra fingers, bad hands, watermark,
text, signature, cartoon, anime, 3d render, painting, drawing
```

**Why Each Tag:**
- `low quality, blurry`: Obvious quality issues
- `multiple people`: Prevents background people
- `deformed face, extra fingers, bad hands`: Common AI artifacts
- `watermark, text`: Keeps images clean
- `cartoon, anime, 3d render`: Forces photoreal style

---

## Step 3: Batch Generation Workflow (30 minutes)

### 3.1 Pose Reference Library

**Create diverse pose library** (one-time setup):

**Method 1: Find Pose References Online**
- Pinterest: Search "female model poses", "instagram poses", "editorial poses"
- Download 50-100 reference images
- Upload to `/workspace/pose-references/`

**Method 2: Generate Pose Sketches**
- Use AI pose generators (Posemy.art, MagicPoser)
- Export 50 varied poses
- Save as PNG files

**Organize by Category:**
```
/workspace/pose-references/
  standing/
  sitting/
  walking/
  fitness/
  candid/
```

### 3.2 Batch Processing Setup

**ComfyUI Pro Tip:** Queue multiple generations

**Manual Batch Process:**
1. Load workflow
2. Set prompt from library (e.g., "luxury cafe")
3. Set pose reference image
4. Click **"Queue Prompt"**
5. **IMMEDIATELY** change prompt + pose reference
6. Click **"Queue Prompt"** again (adds to queue)
7. Repeat 10-20 times
8. Walk away - ComfyUI processes queue automatically

**Queue Output:**
```
Queue:
[1/20] Generating: luxury cafe scene...
[2/20] Generating: gym fitness scene...
[3/20] Generating: coffee shop scene...
...
```

**Expected Speed:**
- RTX 4090: ~25-30 seconds per image
- RTX 3090: ~40-45 seconds per image
- **50 images = 20-40 minutes** (depending on GPU)

### 3.3 Automated Batch Script

**For advanced users** - create Python script:

```python
# /workspace/batch-generate.py
import json
import requests
import time

COMFYUI_URL = "http://127.0.0.1:8188"

prompts = [
    "ohwx woman at luxury cafe, elegant outfit, professional photography",
    "ohwx woman at gym, activewear, fitness lifestyle, natural lighting",
    # ... add 48 more prompts
]

for i, prompt in enumerate(prompts):
    workflow = {...}  # Load your workflow JSON
    workflow["positive_prompt"] = prompt

    response = requests.post(f"{COMFYUI_URL}/prompt", json={"prompt": workflow})
    print(f"Queued {i+1}/50: {prompt[:50]}...")
    time.sleep(1)  # Small delay between queue additions

print("All 50 images queued! Check ComfyUI for progress.")
```

**Run:**
```bash
cd /workspace
python batch-generate.py
```

---

## Step 4: Quality Control & Filtering (20 minutes)

### 4.1 Download Generated Images

**Images save to:**
```
/workspace/runpod-slim/ComfyUI/output/
```

**Download to your computer:**
- RunPod → **"Download Files from Pod"**
- Path: `/workspace/runpod-slim/ComfyUI/output/`
- Download entire folder as ZIP

### 4.2 Filter for Quality

**Review Criteria** (keep only 8/10+ quality):

**Keep if:**
- ✅ Face is clear, sharp, recognizable as your character
- ✅ No artifacts (extra fingers, weird hands, distorted features)
- ✅ Lighting is natural and flattering
- ✅ Composition is balanced
- ✅ Matches prompt intent

**Reject if:**
- ❌ Blurry face or body
- ❌ Distorted features (eyes, mouth, hands)
- ❌ Unnatural poses
- ❌ Poor lighting (too dark, overexposed)
- ❌ Doesn't match prompt

**Realistic Yield:**
- Generate 50 images → Keep 30-35 (60-70% success rate)
- Generate 100 images → Keep 60-70
- **For 30 Instagram posts/month: Generate ~50 images/month**

### 4.3 Organize Keepers

**Create folder structure:**
```
instagram-content/
  2024-11/
    luxury-lifestyle/
    fitness/
    fashion/
    nightlife/
    casual/
  2024-12/
    ...
```

Move filtered images into relevant categories.

---

## Step 5: Post-Processing for Instagram (30 minutes)

### 5.1 Upscaling (Optional but Recommended)

**Use ComfyUI Upscale Node:**

Add to workflow:
```
VAE Decode → Upscale Image (using model) → Save Image
```

**Upscale Settings:**
- Model: `4x-UltraSharpV2.pth` (installed by default)
- Scale: `2x` (1024x1024 → 2048x2048)
- **Why:** Higher resolution = more detail, Instagram compression looks better

**Batch upscale existing images:**
- Load image → Upscale → Save
- Queue 30 images → Walk away (10-15 minutes total)

### 5.2 Color Grading (Light Editing)

**Recommended Tools:**
- Lightroom Mobile (free, excellent presets)
- Snapseed (free, powerful)
- VSCO (free with paid premium filters)

**Pro Instagram Aesthetic:**
1. **Slightly** increase exposure (+0.2 to +0.5)
2. **Warm up** temperature (+5 to +15) - luxury vibe
3. **Subtle** saturation boost (+10 to +20)
4. **Sharpen** moderately (30-50%)
5. **Apply consistent preset** across all images (brand consistency)

**Warning:** Don't over-edit - AI images already high quality. Light touch only.

### 5.3 Final Export Settings

**Instagram Optimal Settings:**
- Format: JPG
- Resolution: 1080x1080 (square) or 1080x1350 (portrait 4:5)
- Quality: 90-95% (balance quality/file size)
- Color Space: sRGB

**Batch export from Lightroom:**
- Select all 30 images
- Export → Instagram preset
- Done in 30 seconds

---

## Step 6: Content Calendar Preparation (15 minutes)

### 6.1 Organize by Theme

**Weekly Posting Strategy:**

**Monday:** Motivation (fitness, wellness)
**Tuesday:** Lifestyle (casual, home, coffee)
**Wednesday:** Fashion (street style, shopping)
**Thursday:** Food/Travel (restaurants, destinations)
**Friday:** Nightlife (events, dining, social)
**Saturday:** Luxury (hotels, designer, high-end)
**Sunday:** Behind-the-scenes (relatable, candid)

**Match your generated images to schedule:**
- Week 1: Assign 7 images to each day
- Week 2: Assign next 7 images
- Week 3: Assign next 7
- Week 4: Assign remaining 9 images (2 on high-engagement days)

### 6.2 Batch Upload to Scheduling Tool

**Recommended Tools:**
- **Later** (free for 30 posts/month) - drag & drop calendar
- **Planoly** (free plan available) - visual Instagram grid
- **Buffer** (free for 10 posts) - multi-platform

**Process:**
1. Upload all 30 images
2. Drag to calendar slots (matching your theme strategy)
3. Pre-write captions (see 04-INSTAGRAM-LAUNCH.md for caption templates)
4. Schedule for optimal times (research your audience)
5. **Done for the month!**

---

## Success Checklist ✅

You've mastered the content pipeline when you have:

- ✅ Advanced ComfyUI workflow (LoRA + IPAdapter + ControlNet)
- ✅ Prompt library (50+ categorized prompts)
- ✅ Pose reference library (50+ varied poses)
- ✅ Generated first batch (50+ images)
- ✅ Filtered to 30-35 high-quality images
- ✅ Post-processed and exported for Instagram
- ✅ Uploaded to scheduling tool for month ahead

---

## Next Steps

**You now have a production content pipeline!**

**Next Guide:** [04-INSTAGRAM-LAUNCH.md](./04-INSTAGRAM-LAUNCH.md)
- Account setup and optimization
- Caption formulas that convert
- Hashtag strategy for growth
- Posting schedule optimization
- Analytics and iteration

**Or Scale Up:** Generate 100+ images per session, build 3-month content backlog

---

## Troubleshooting

### "Faces don't look consistent across images"

**Fix:**
1. Increase LoRA strength (0.7 → 0.85)
2. Increase IPAdapter weight (0.75 → 0.85)
3. Use same reference image for all generations
4. Check LoRA quality (retrain if needed)

### "Hands look weird/distorted"

**Common AI problem** - fixes:
1. Use ControlNet pose references with clear hands
2. Add to negative prompt: `bad hands, extra fingers, deformed hands, missing fingers`
3. Generate more images, filter out bad hands (60-70% will be good)
4. Use ComfyUI-Impact-Pack for hand fixing (advanced)

### "Images too similar, need more variety"

**Fix:**
1. Vary prompts more (different locations, outfits, actions)
2. Vary pose references (don't reuse same 5 poses)
3. Lower CFG (8.0 → 6.5) for more creative variation
4. Change seed (random seed each generation)

### "Batch generation is slow"

**Optimization:**
1. Upgrade to RTX 4090 pod (2x faster than 3090)
2. Lower resolution during generation (768x768), upscale after
3. Reduce sampling steps (30 → 25)
4. Use faster sampler (DPM++ 2M Karras → Euler A)

---

## Pro Tips

**Efficiency Hacks:**
1. **Generate in bulk sessions** (1-2 hours every 2 weeks = 100+ images)
2. **Build prompt library** (save time not rewriting prompts)
3. **Reuse best poses** (80/20 rule: 20% of poses = 80% of best images)
4. **Batch upscale** (all images at end, not one-by-one)

**Quality Over Quantity:**
- Generating 100 images → keep 60 best = BETTER than generating 50 → keep 30
- Always overshoot, filter ruthlessly

**Consistency is King:**
- Use same LoRA version across all content
- Use same IPAdapter reference image
- Use same color grading preset
- **Result:** Cohesive Instagram grid that looks professional

---

## Quick Reference

**Start ComfyUI:**
```bash
cd /workspace/runpod-slim/ComfyUI
python main.py --listen 0.0.0.0 --port 8188
```

**Check Output:**
```bash
ls -lh /workspace/runpod-slim/ComfyUI/output/
```

**Batch Upscale Command** *(if using CLI tools)*:
```bash
# Using RealESRGAN CLI
cd /workspace/runpod-slim/ComfyUI/output
for img in *.png; do
    realesrgan-ncnn-vulkan -i "$img" -o "upscaled_$img" -s 2
done
```

---

**Ready to launch your AI influencer →** [04-INSTAGRAM-LAUNCH.md](./04-INSTAGRAM-LAUNCH.md)
