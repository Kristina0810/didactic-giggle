# Quick Start: Your First AI Character in 30 Minutes

**Goal:** Get from zero to your first AI-generated character image in 30 minutes.

**What You'll Learn:**
- RunPod account setup
- One-click environment installation
- Generate your first character image
- Verify everything works

**Time Estimate:** 20-30 minutes (including downloads)

---

## Prerequisites

**You Need:**
- ✅ Credit card (for RunPod - ~$0.50/hour GPU cost)
- ✅ 50-100 photos of yourself or your character subject
- ✅ Basic computer skills (file uploads, copy/paste)

**You DON'T Need:**
- ❌ Coding experience
- ❌ AI/ML knowledge
- ❌ Expensive local GPU

---

## Step 1: RunPod Account Setup (5 minutes)

### 1.1 Create Account

1. Go to [runpod.io](https://www.runpod.io)
2. Click **"Sign Up"**
3. Use Google/GitHub or email registration
4. Verify your email

### 1.2 Add Payment Method

1. Click your profile (top right) → **"Billing"**
2. Click **"Add Payment Method"**
3. Add credit card (prepaid cards work)
4. Add $10-20 credits (enough for 20-40 hours)

**Cost Breakdown:**
- GPU Pod (RTX 4090): ~$0.50/hour
- Storage: ~$0.10/GB/month
- **First character project: $2-5 total**

---

## Step 2: Launch Your First Pod (10 minutes)

### 2.1 Create ComfyUI Pod (Inference)

1. Click **"Pods"** → **"+ GPU Pod"**
2. Filter: **"On-Demand"** (instant availability)
3. Select GPU: **RTX 4090** or **RTX 3090** (best value)
4. Template: Search **"ComfyUI"** → Select **"RunPod ComfyUI"**
5. Storage: **50GB** (minimum for starter models)
6. Click **"Deploy On-Demand"**

**Wait 1-2 minutes for pod to start**

### 2.2 Access Your Pod

Once pod shows **"Running"**:

1. Click **"Connect"** → **"Start Web Terminal"**
2. A terminal window opens (this is your command center)

**You're now inside your AI development environment!**

---

## Step 3: Install Everything (One Command) (10 minutes)

### 3.1 Download Setup Scripts

In the web terminal, paste these commands:

```bash
cd /workspace
git clone https://github.com/Kristina0810/didactic-giggle.git
cd didactic-giggle
```

### 3.2 Run ComfyUI Setup

**One command does everything:**

```bash
./setup-comfyui-pro-v5.0.0.sh
```

**What This Does:**
- ✅ Installs ComfyUI base requirements
- ✅ Installs 9 essential custom nodes (character consistency tools)
- ✅ Sets up auto-start (survives pod restarts)
- ✅ Creates organized directory structure
- ✅ Runs health checks

**Expected Time:** 5-7 minutes

**You'll see progress indicators like:**
```
[INFO] Installing custom node 1/9...
[SUCCESS] ✓ ComfyUI-Manager installed
[INFO] Installing custom node 2/9...
[SUCCESS] ✓ IP-Adapter installed
...
```

### 3.3 Download Essential Models

After setup completes, run:

```bash
./download-models-pro-v5.0.0.sh
```

**Models Downloaded (~15GB):**
- ✅ Juggernaut XL v9 (photoreal character generation)
- ✅ SDXL VAE (image quality)
- ✅ RealESRGAN + UltraSharp (upscaling)
- ✅ IP-Adapter SDXL (style consistency - **critical**)
- ✅ ControlNet OpenPose (pose control)

**Expected Time:** 8-12 minutes (depends on connection speed)

**Press `y` when prompted to start download**

---

## Step 4: Start ComfyUI (2 minutes)

### 4.1 Launch ComfyUI Interface

```bash
cd /workspace/runpod-slim/ComfyUI
python main.py --listen 0.0.0.0 --port 8188
```

**You'll see:**
```
Starting server...
To see the GUI go to: http://0.0.0.0:8188
```

### 4.2 Access ComfyUI in Browser

1. In RunPod pod page, find **"Connect"** button
2. Click **"HTTP Service [Port 8188]"**
3. **ComfyUI interface opens in new tab!**

**Success Indicator:** You should see the ComfyUI node-based interface

---

## Step 5: Generate Your First Image (5 minutes)

### 5.1 Load Default Workflow

1. In ComfyUI, click **"Load Default"** (or it's already loaded)
2. You'll see connected nodes: **Checkpoint → KSampler → VAE Decode → Save Image**

### 5.2 Configure Basic Settings

**Find the "Checkpoint Loader" node:**
- Click dropdown → Select: **`Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors`**

**Find the "CLIP Text Encode (Prompt)" node (positive):**
- Replace text with:
  ```
  photo of a woman, professional photography, elegant, luxury lifestyle,
  high quality, detailed face, natural lighting, instagram aesthetic
  ```

**Find the "CLIP Text Encode (Prompt)" node (negative):**
- Replace text with:
  ```
  low quality, blurry, distorted, amateur, artificial, oversaturated
  ```

**Find the "Empty Latent Image" node:**
- Width: `1024`
- Height: `1024`

### 5.3 Generate!

1. Click **"Queue Prompt"** (top right)
2. Watch the progress bar (bottom)
3. **Wait 15-30 seconds**
4. Image appears in the preview!

**Right-click the generated image → "Save image"**

---

## Success Checklist ✅

By now you should have:

- ✅ RunPod account with credits
- ✅ ComfyUI pod running (~$0.50/hour)
- ✅ All essential models downloaded
- ✅ ComfyUI interface accessible
- ✅ Your first AI-generated image saved

**Congratulations! You've just generated your first AI image.**

---

## What Just Happened? (Understanding the Magic)

**ComfyUI:** Node-based interface for AI image generation (think Photoshop nodes)

**Checkpoint:** The "brain" - Juggernaut XL trained on millions of images

**Prompt:** Text description of what you want (positive = "include this", negative = "avoid this")

**KSampler:** The "artist" - iteratively creates image from noise

**VAE:** Final polish - converts latent space to actual pixels

---

## Next Steps

**You've completed the foundation!**

**Next Guide:** [01-FIRST-CHARACTER.md](./01-FIRST-CHARACTER.md)
- Create YOUR specific character
- Upload your photo dataset
- Train your first LoRA (character consistency model)
- Generate images that look like YOU (or your influencer character)

---

## Troubleshooting

### "Command not found: ./setup-comfyui-pro-v5.0.0.sh"

**Fix:**
```bash
chmod +x setup-comfyui-pro-v5.0.0.sh
./setup-comfyui-pro-v5.0.0.sh
```

### "Port 8188 not accessible"

**Fix:**
1. Check pod is **"Running"** (not "Exited")
2. Restart ComfyUI:
   ```bash
   cd /workspace/runpod-slim/ComfyUI
   python main.py --listen 0.0.0.0 --port 8188
   ```
3. Use RunPod's **"HTTP Service [Port 8188]"** link (not localhost)

### "Out of memory error"

**Fix:**
- Use smaller resolution (512x512 instead of 1024x1024)
- Close other applications in pod
- Upgrade to larger GPU (RTX 4090 recommended)

### "Model not found"

**Fix:**
```bash
cd /workspace/didactic-giggle
./download-models-pro-v5.0.0.sh
```

Re-run model download script

---

## Cost Management Tips

**Minimize Costs:**
- ✅ **Stop pod when not using** (Billing → Stop Pod)
- ✅ Use "On-Demand" (pay-per-hour, no commitment)
- ✅ Download models once, keep storage (cheaper than re-downloading)
- ❌ Don't leave pod running overnight ($12 wasted)

**Expected Monthly Cost (Hobbyist):**
- 10 hours GPU time: $5
- 50GB storage: $5
- **Total: ~$10/month**

**Expected Monthly Cost (Serious Creator):**
- 40 hours GPU time: $20
- 100GB storage: $10
- **Total: ~$30/month**

**Compare to:**
- Midjourney Pro: $60/month (limited to their models)
- ChatGPT Plus: $20/month (no image training)
- Your setup: $10-30/month (**full control, unlimited potential**)

---

## Quick Reference Commands

**Start ComfyUI:**
```bash
cd /workspace/runpod-slim/ComfyUI
python main.py --listen 0.0.0.0 --port 8188
```

**Check Disk Space:**
```bash
df -h /workspace
```

**Re-run Setup (if needed):**
```bash
cd /workspace/didactic-giggle
./setup-comfyui-pro-v5.0.0.sh
```

**Update Scripts:**
```bash
cd /workspace/didactic-giggle
git pull
```

---

## You're Ready!

You've just built a **world-class AI development environment** for less than the cost of a Netflix subscription.

**Time to create your character →** [01-FIRST-CHARACTER.md](./01-FIRST-CHARACTER.md)

---

**Questions?** Review logs at `/workspace/logs/` or re-run setup scripts (they're idempotent - safe to run multiple times).
