# First Character: Train Your Personal LoRA

**Goal:** Create a LoRA model that generates consistent images of YOUR specific character.

**What You'll Learn:**
- Photo collection strategy (quality > quantity)
- Dataset preparation (naming, cropping, organization)
- Launch Kohya_ss training pod
- Train your first LoRA
- Test character consistency

**Time Estimate:** 2-3 hours (mostly training time - you can walk away)

---

## What is a LoRA?

**LoRA (Low-Rank Adaptation):**
- Small model file (50-200MB) that teaches base model YOUR specific character
- Trained on 50-100 photos of one person
- Enables consistent face, style, and appearance across all generated images
- **The secret to AI influencer consistency** (like AI Tana, Lil Miquela)

**Without LoRA:** Every image = random face
**With LoRA:** Every image = YOUR character's face

---

## Step 1: Photo Collection Strategy (30 minutes)

### 1.1 Quality Requirements

**Optimal Dataset:**
- ✅ **50-100 photos** (sweet spot: 75 photos)
- ✅ **High resolution:** 1024x1024 or larger
- ✅ **Well-lit:** Natural lighting preferred
- ✅ **Clear face:** Sharp focus, not blurry
- ✅ **Variety:** Different poses, angles, expressions, outfits

**Avoid:**
- ❌ Blurry/low-quality photos
- ❌ Heavy filters (Instagram filters corrupt training)
- ❌ Sunglasses/face obstructions (unless part of character brand)
- ❌ Group photos (face too small)
- ❌ Extreme angles (straight-down/straight-up shots)

### 1.2 Diversity Checklist

**Angles (aim for balance):**
- 40% front-facing (0-15° angle)
- 30% side profiles (45-90° angle)
- 20% three-quarter view (20-45° angle)
- 10% looking away/candid

**Expressions:**
- 50% neutral/slight smile (professional)
- 30% full smile (approachable)
- 20% serious/editorial (luxury vibe)

**Outfits/Settings:**
- Luxury lifestyle: designer clothes, elegant settings
- Casual chic: streetwear, coffee shops, travel
- Fitness: activewear, gym, outdoor
- Nightlife: clubs, restaurants, events

**Pro Tip:** If creating AI influencer from scratch (not using your own face), hire a model on Fiverr for $50-100 to shoot 100+ varied photos following this guide.

### 1.3 Where to Get Photos

**Option A: Your Own Photos**
- Raid your Instagram, camera roll
- Ask friends for candid photos they took of you
- Schedule a dedicated photoshoot (50-100 shots in one day)

**Option B: Hired Model (AI Influencer)**
- Fiverr: Search "model photoshoot" ($50-150 for 100+ photos)
- ModelMayhem: Hire TFP (Time for Prints) models
- Local photographers: Trade services or pay $100-200

**Option C: Licensed Stock Photos** *(use cautiously)*
- Legal only if you have commercial rights
- NOT recommended for AI influencer (ethical concerns)

---

## Step 2: Dataset Preparation (45 minutes)

### 2.1 Download Your Photos

Create a folder on your computer:
```
character-001/
  raw/
    IMG_001.jpg
    IMG_002.jpg
    ...
    IMG_100.jpg
```

### 2.2 Quality Filter (Remove Bad Photos)

**Quick Review Process:**
1. Open folder in gallery view
2. Delete any photo with:
   - Blurriness
   - Face obstructions (hands, hair covering face)
   - Poor lighting (too dark/overexposed)
   - Duplicate poses (keep best version)

**Goal:** 50-75 high-quality photos remaining

### 2.3 Crop and Resize

**Manual Method (Recommended for First Time):**

Use any photo editor (Photoshop, GIMP, Canva, even Preview on Mac):

1. **Crop to square** (1:1 aspect ratio)
2. **Center the face** (face should be 40-60% of frame)
3. **Resize to 1024x1024** pixels
4. **Save as JPG** (high quality, 90-100%)

**Example Good Crop:**
```
┌─────────────────┐
│                 │
│     👤         │  ← Face centered
│    (face)       │  ← Upper body visible
│                 │  ← Background minimal
└─────────────────┘
```

**Batch Processing Method** *(advanced - skip for now)*:
- Use Birme.net (free, no install)
- Upload all photos → Set 1024x1024 → Download zip

### 2.4 Rename Files Sequentially

Rename to simple sequential names:
```
001.jpg
002.jpg
003.jpg
...
075.jpg
```

**Why?** Kohya reads filenames for training - simple names prevent errors.

### 2.5 Upload to RunPod

**In RunPod Web Terminal:**

1. Create dataset directory:
```bash
mkdir -p /workspace/training/datasets/raw/character-001
```

2. **Upload files:**
   - In RunPod pod page, click **"Connect"** → **"Send Files to Pod"**
   - Select all your cropped/renamed photos
   - Upload to: `/workspace/training/datasets/raw/character-001`

**Verify upload:**
```bash
ls /workspace/training/datasets/raw/character-001 | wc -l
```

Should show your photo count (e.g., `75`)

---

## Step 3: Launch Kohya Training Pod (20 minutes)

### 3.1 Create New Pod for Training

**Important:** You need a SEPARATE pod for training (different PyTorch version)

1. In RunPod, click **"+ GPU Pod"**
2. GPU: **RTX 4090** (best for training) or **RTX 3090** (budget option)
3. Template: **"PyTorch 2.1"** *(critical - do NOT use 2.8)*
4. Storage: **30GB** minimum
5. Click **"Deploy On-Demand"**

**Why Separate Pod?**
- ComfyUI: PyTorch latest (best for inference)
- Kohya: PyTorch 2.1 (stable for training dependencies)

### 3.2 Install Kohya_ss

**In the new training pod terminal:**

```bash
cd /workspace
git clone https://github.com/Kristina0810/didactic-giggle.git
cd didactic-giggle
./setup-kohya-pro-v5.0.0.sh
```

**Expected Time:** 8-12 minutes

**What This Does:**
- ✅ Clones Kohya_ss repository
- ✅ Creates virtual environment
- ✅ Installs PyTorch 2.1 (pinned version)
- ✅ Installs training dependencies (xformers, bitsandbytes)
- ✅ Sets up auto-start
- ✅ Creates training directory structure

### 3.3 Start Kohya GUI

```bash
cd /workspace/kohya_ss
source venv/bin/activate
python gui.py --listen 0.0.0.0 --server_port 7860
```

**Access Kohya:**
- In RunPod pod page: **"HTTP Service [Port 7860]"**
- Kohya GUI opens in browser

---

## Step 4: Configure LoRA Training (15 minutes)

### 4.1 Kohya GUI Overview

**Tabs You'll Use:**
- **"LoRA"**: Main training configuration
- **"Folders"**: Dataset paths
- **"Parameters"**: Advanced settings (we'll use defaults)
- **"Training"**: Start training

### 4.2 Configure Folders Tab

**Source Images:**
```
/workspace/training/datasets/raw/character-001
```

**Output:**
```
/workspace/training/outputs/lora
```

**Model Output Name:**
```
character-001-lora
```

**Logging:**
```
/workspace/training/logs
```

### 4.3 Configure Model Tab

**Pretrained Model:**
```
/workspace/ComfyUI/models/checkpoints/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors
```

*(Note: If Kohya pod doesn't have access to ComfyUI models, you'll need to download Juggernaut XL again in this pod - use wget command from download script)*

**VAE** *(optional but recommended)*:
```
/workspace/ComfyUI/models/vae/sdxl_vae.safetensors
```

### 4.4 Configure Training Parameters

**Basic Settings** *(use these for first LoRA)*:

| Parameter | Value | Why |
|-----------|-------|-----|
| **Max Epochs** | 10 | 10 passes through dataset (sweet spot) |
| **Learning Rate** | 0.0001 | Standard rate for character LoRA |
| **Network Dim** | 32 | LoRA complexity (32 = good balance) |
| **Network Alpha** | 16 | Half of dim (standard practice) |
| **Batch Size** | 1 | One image at a time (GPU memory safe) |
| **Resolution** | 1024,1024 | Matches your cropped photos |
| **Optimizer** | AdamW8bit | Memory-efficient, high-quality |

**Advanced (usually leave default):**
- Mixed Precision: `fp16`
- Save Precision: `fp16`
- Gradient Checkpointing: ✅ Enabled
- Shuffle Captions: ❌ Disabled (we're not using captions yet)

### 4.5 Start Training

1. Click **"Start Training"** button
2. Monitor progress in terminal output
3. **Walk away** - training takes 60-90 minutes

**What to Expect:**
```
Epoch 1/10: ████████████████ 100% | Loss: 0.12
Epoch 2/10: ████████████████ 100% | Loss: 0.09
Epoch 3/10: ████████████████ 100% | Loss: 0.07
...
Training complete! Model saved to /workspace/training/outputs/lora/character-001-lora.safetensors
```

**Loss Explained:**
- High loss (0.15+): Model still learning
- Medium loss (0.08-0.12): Good training progress
- Low loss (0.05-0.07): Model converging (almost done)
- Very low loss (<0.03): Risk of overfitting (model memorizing, not learning)

---

## Step 5: Test Your LoRA (10 minutes)

### 5.1 Download Your Trained LoRA

**In Kohya pod terminal:**
```bash
ls -lh /workspace/training/outputs/lora/
```

You should see:
```
character-001-lora.safetensors  (50-150MB)
```

**Download to your computer:**
- RunPod pod page → **"Connect"** → **"Download Files from Pod"**
- Path: `/workspace/training/outputs/lora/character-001-lora.safetensors`

### 5.2 Upload to ComfyUI Pod

**Switch to your ComfyUI pod** (the first one you created)

**Upload LoRA:**
- RunPod → **"Send Files to Pod"**
- Upload `character-001-lora.safetensors` to:
  ```
  /workspace/runpod-slim/ComfyUI/models/loras/
  ```

### 5.3 Load LoRA in ComfyUI

**In ComfyUI interface:**

1. Right-click empty space → **"Add Node"** → **"loaders"** → **"Load LoRA"**
2. Connect nodes:
   ```
   Checkpoint Loader → Load LoRA → CLIP Text Encode (Prompt)
                     ↓
   Load LoRA → KSampler
   ```
3. **Load LoRA node settings:**
   - Select your LoRA: `character-001-lora.safetensors`
   - Strength: `0.8` (0.0 = no effect, 1.0 = maximum effect)

### 5.4 Generate Test Images

**Prompt (positive):**
```
photo of ohwx woman, professional photography, elegant dress,
luxury lifestyle, instagram aesthetic, high quality, detailed face
```

**Note:** `ohwx woman` is a trigger word (Kohya default). Tells model to use YOUR character's face.

**Prompt (negative):**
```
low quality, blurry, distorted, amateur, multiple people
```

**Generate 5-10 images** with different prompts:
- "ohwx woman in a cafe, candid photo, natural lighting"
- "ohwx woman at the beach, sunset, elegant swimwear"
- "ohwx woman in luxury hotel, professional photography"

### 5.5 Evaluate Consistency

**Good LoRA Signs:**
- ✅ Face looks like your character across all images
- ✅ Same facial features (eyes, nose, mouth, bone structure)
- ✅ Responds to different prompts (different poses, outfits, settings)
- ✅ High quality, sharp details

**Bad LoRA Signs:**
- ❌ Face changes between images
- ❌ Distorted features (extra fingers, weird eyes)
- ❌ Ignores prompts (always same pose/outfit)
- ❌ Blurry or low quality

**If Bad:** Re-train with:
- More diverse photos (different angles, expressions)
- Lower learning rate (0.00005)
- More epochs (15-20)
- Better quality source photos

---

## Success Checklist ✅

You've completed this module when you have:

- ✅ 50-100 high-quality character photos collected
- ✅ Photos cropped, resized, and uploaded to RunPod
- ✅ Kohya_ss training pod configured
- ✅ First LoRA model trained (character-001-lora.safetensors)
- ✅ LoRA tested in ComfyUI with consistent results
- ✅ 5-10 test images generated showing YOUR character

---

## Next Steps

**You now have a character consistency model!**

**Next Guide:** [02-TRAIN-LORA-ADVANCED.md](./02-TRAIN-LORA-ADVANCED.md) *(coming soon)*
- Caption-based training (control clothing, poses, settings)
- Hyperparameter optimization
- Multi-concept LoRAs (character + style)

**Or Jump to Workflow:** [03-CONTENT-PIPELINE.md](./03-CONTENT-PIPELINE.md)
- Build automated content generation workflow
- ComfyUI + IPAdapter + ControlNet for maximum consistency
- Batch generation (10-50 images per run)

---

## Troubleshooting

### "Training failed: CUDA out of memory"

**Fix:**
- Reduce batch size to 1
- Enable gradient checkpointing
- Use smaller resolution (768x768)
- Upgrade to RTX 4090 pod

### "LoRA doesn't look like my character"

**Common Causes:**
1. **Not enough variety in dataset** → Add more angles/expressions
2. **Too many photos** (100+) with low quality → Reduce to 50-75 best photos
3. **Learning rate too high** → Lower to 0.00005
4. **Overtrained** → Reduce epochs to 6-8

**Fix:** Re-train with adjustments above

### "Generated images are blurry"

**Not a LoRA problem** - This is generation settings:
- Increase sampling steps (20 → 30)
- Use better scheduler (Euler A → DPM++ 2M Karras)
- Check VAE is loaded correctly

### "Error: Model not found"

**Fix:**
```bash
# In Kohya pod
cd /workspace
wget https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors \
  -O /workspace/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors
```

Use this path in Kohya config:
```
/workspace/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors
```

---

## Pro Tips

**Iteration Strategy:**
1. **Train v1** with basic dataset → Test
2. **Identify weaknesses** (face too young? Hair color off?)
3. **Add 10-15 photos** addressing weaknesses → Re-train v2
4. **Test v2** → Compare to v1
5. **Repeat** until perfect (usually 2-3 iterations)

**Dataset Evolution:**
- v1: 50 photos (quick test)
- v2: 75 photos (refined selection)
- v3: 100+ photos (production quality)

**Cost Optimization:**
- Train multiple LoRAs in one session (1 hour GPU = 2-3 LoRAs trained)
- Stop pod immediately after training completes
- Keep trained LoRA files in storage (cheap) vs re-training (expensive)

---

## Quick Reference

**Start Kohya:**
```bash
cd /workspace/kohya_ss
source venv/bin/activate
python gui.py --listen 0.0.0.0 --server_port 7860
```

**Check Training Progress:**
```bash
tail -f /workspace/training/logs/*.log
```

**Find Your LoRA:**
```bash
ls -lh /workspace/training/outputs/lora/
```

---

**You've just created your first AI character model. Time to build a content pipeline →** [03-CONTENT-PIPELINE.md](./03-CONTENT-PIPELINE.md)
