# 🚀 ABSOLUTE BEGINNER: RunPod Setup Guide

**Start Here if:** You've never used RunPod, cloud GPUs, or Linux before.

**Time Required:** 30-45 minutes  
**Cost:** ~$0.50-1.00/hour (RTX 5090)  
**Outcome:** Fully functional S-Tier character creation environment

---

## 📋 **WHAT YOU'LL NEED**

### Prerequisites (Must Have)
- [ ] RunPod account (sign up at runpod.io)
- [ ] $10-20 in RunPod credits
- [ ] Modern web browser (Chrome, Firefox, Edge)
- [ ] Stable internet connection

### Nice to Have
- Basic terminal familiarity (we'll teach you)
- Text editor knowledge (nano/vim basics)

**Don't worry if you're completely new - we'll guide you through everything.**

---

## 🎯 **OVERVIEW: WHAT WE'RE BUILDING**

We're creating a cloud-based AI workstation with:
- **ComfyUI** - Visual interface for image generation
- **Kohya_ss** - LoRA training software
- **JupyterLab** - Interactive coding environment
- **All TITAN automation** - Scripts that make everything easy

**Think of it like:** Renting a super-powered computer in the cloud that specializes in AI art.

---

## 📖 **STEP-BY-STEP SETUP**

### **STEP 1: Create RunPod Account**

1. Go to https://runpod.io
2. Click "Sign Up"
3. Create account (email + password)
4. Verify email
5. Add payment method
6. Add $10-20 in credits

**✓ Checkpoint:** You should see your credit balance in the dashboard.

---

### **STEP 2: Deploy Your GPU Pod**

**What's a "pod"?** Think of it as your personal cloud computer that you rent by the hour.

#### 2.1: Select GPU Template

1. Click **"Pods"** in left sidebar
2. Click **"+ GPU Pods"** button
3. You'll see GPU options - we need **RTX 5090**

#### 2.2: Configure Pod Settings

**GPU Selection:**
- Search for: "RTX 5090"
- Select: **1x RTX 5090 (32GB VRAM)**
- **Cost:** ~$1.29/hour (varies by provider)

**Template:**
- Click "Select Template"
- Search: "PyTorch"
- Select: **"RunPod PyTorch 2.8.0"**
  - Full name: `runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404`

**Storage:**
- Volume Disk: **100 GB** minimum
- Volume Mount Path: `/workspace` (default)

**Ports (IMPORTANT):**
Enable these ports:
- 8188 (ComfyUI)
- 7860 (Kohya)
- 8888 (JupyterLab)
- 22 (SSH - optional)

#### 2.3: Deploy Pod

1. Click **"Deploy"** button
2. Wait 2-5 minutes for pod to start
3. Pod status will change to "Running"

**✓ Checkpoint:** You should see a running pod with a green "Running" status.

---

### **STEP 3: Access Your Pod**

Once your pod is running, you'll see buttons:

#### Option A: Web Terminal (Easiest)
1. Click **"Connect"** button
2. Select **"Start Web Terminal"**
3. Browser terminal opens - you're in!

#### Option B: SSH (Advanced)
1. Copy SSH command shown
2. Open local terminal
3. Paste and run command

**✓ Checkpoint:** You should see a terminal prompt like:
```bash
root@[pod-id]:~#
```

---

### **STEP 4: Verify Environment**

Let's make sure everything is ready. Copy and paste these commands:

#### 4.1: Check GPU
```bash
nvidia-smi
```
**You should see:** RTX 5090 with 32GB VRAM listed

#### 4.2: Check Python
```bash
python3 --version
```
**You should see:** Python 3.10+ (likely 3.12)

#### 4.3: Check PyTorch + CUDA
```bash
python3 << 'EOF'
import torch
print(f"PyTorch: {torch.__version__}")
print(f"CUDA Available: {torch.cuda.is_available()}")
print(f"CUDA Version: {torch.version.cuda}")
EOF
```
**You should see:** 
- PyTorch 2.8+
- CUDA Available: True
- CUDA Version: 12.8+

#### 4.4: Check Workspace
```bash
df -h /workspace
```
**You should see:** 100GB or more available

**✓ Checkpoint:** All checks passed = Environment is ready!

---

### **STEP 5: Download S-Tier Toolkit**

Now we'll get the character creation toolkit.

#### 5.1: Navigate to Workspace
```bash
cd /workspace
```

#### 5.2: Download Toolkit
```bash
# Option A: If you have the package locally, upload it via RunPod UI

# Option B: Download from URL (if hosted)
wget https://your-url/s-tier-character-creation-v2.0-FINAL.tar.gz

# Option C: Clone from GitHub (once released)
git clone https://github.com/your-username/s-tier-character-creation.git
```

#### 5.3: Extract (if using tar.gz)
```bash
tar -xzf s-tier-character-creation-v2.0-FINAL.tar.gz
cd s-tier-character-creation
```

**✓ Checkpoint:** You should see the toolkit files:
```bash
ls -la
```

---

### **STEP 6: Run TITAN Master Setup**

This is the big one - it installs everything.

#### 6.1: Make Setup Script Executable
```bash
cd /workspace
chmod +x s-tier-character-creation/infrastructure/runpod/titan-master-setup.sh
```

#### 6.2: Run Setup
```bash
./s-tier-character-creation/infrastructure/runpod/titan-master-setup.sh
```

**What happens:**
- Installs system dependencies (2-3 min)
- Creates virtual environment (2-3 min)
- Installs Python packages (10-15 min)
- Clones ComfyUI (3-5 min)
- Clones Kohya_ss (2-3 min)
- Installs custom nodes (5-7 min)
- Configures services (1-2 min)

**Total time:** 30-40 minutes

**Important:** Don't close the terminal during installation!

#### 6.3: Monitor Progress
You'll see phases:
- Phase 1: System Verification ✓
- Phase 2: System Dependencies ✓
- Phase 3: Virtual Environment ✓
- Phase 4: Python Packages ✓
- Phase 5: ComfyUI Installation ✓
- Phase 6: Kohya Installation ✓
- Phase 7: Custom Nodes ✓
- Phase 8: JupyterLab ✓
- Phase 9: TITAN Command Center ✓
- Phase 10: Performance Optimization ✓

**✓ Checkpoint:** You should see "Installation Complete" message.

---

### **STEP 7: Activate TITAN Environment**

After installation completes:

```bash
source /workspace/.titanrc
```

You should see:
```
TITAN v2.1 ready (venv: /workspace/titan_env)
```

**✓ Checkpoint:** Run `titan status` - should work without errors.

---

### **STEP 8: Download AI Models**

Before creating characters, we need base models.

```bash
/workspace/s-tier-character-creation/infrastructure/runpod/titan-download-models.sh
```

**What to download:**
1. **Checkpoint** (Choose one):
   - Juggernaut XL v9 (recommended for photorealism)
   - DreamShaper XL (versatile)
   - RealVisXL V4 (ultra-realistic)

2. **VAE** (Required):
   - SDXL VAE (auto-downloads)

3. **ControlNet** (Recommended):
   - Canny (for poses)
   - Depth (for composition)

4. **Upscalers** (Recommended):
   - RealESRGAN x4
   - 4x NMKD Siax

**Total download:** 10-20GB (15-30 minutes)

**✓ Checkpoint:** Models downloaded to `/workspace/ComfyUI/models/`

---

### **STEP 9: Start Services**

Now let's start ComfyUI and Kohya:

```bash
titan start all
```

**This starts:**
- ComfyUI on port 8188
- Kohya_ss on port 7860
- JupyterLab on port 8888

**Wait:** 30-60 seconds for services to start

**Check status:**
```bash
titan status
```

**You should see:**
```
ComfyUI:  ✓ Running (PID: xxxxx)
Kohya:    ✓ Running (PID: xxxxx)
Jupyter:  ✓ Running (PID: xxxxx)
```

**✓ Checkpoint:** All services running.

---

### **STEP 10: Access Services**

Get your access URLs:

```bash
titan url
```

**You'll see:**
```
ComfyUI:  https://[pod-id]-8188.proxy.runpod.net
Kohya:    https://[pod-id]-7860.proxy.runpod.net
Jupyter:  https://[pod-id]-8888.proxy.runpod.net
```

**Click URLs** to open in browser!

**✓ Checkpoint:** ComfyUI interface loads successfully.

---

### **STEP 11: Run System Diagnostics**

Let's verify everything is perfect:

```bash
/workspace/s-tier-character-creation/infrastructure/runpod/titan-diagnose.sh
```

**This checks:**
- GPU status ✓
- Python environment ✓
- PyTorch + CUDA ✓
- Disk space ✓
- Installation status ✓
- Service status ✓
- Port accessibility ✓
- Model availability ✓

**All checks should pass.**

**✓ Checkpoint:** Diagnostics show "All systems operational"

---

## 🎉 **SETUP COMPLETE!**

**Congratulations!** You now have a fully functional S-Tier character creation environment.

---

## 🔄 **AFTER POD RESTART (CRITICAL)**

RunPod pods restart when you stop/start them. Here's what to do:

### **When You Restart Your Pod:**

#### Step 1: Reconnect to Terminal
- Click "Connect" → "Start Web Terminal"

#### Step 2: Activate Environment
```bash
source /workspace/.titanrc
```

#### Step 3: Start Services
```bash
titan start all
```

#### Step 4: Verify
```bash
titan status
titan url
```

**That's it! Everything persists.**

---

## ❓ **TROUBLESHOOTING**

### **Problem: "titan: command not found"**

**Solution:**
```bash
source /workspace/.titanrc
```

**Why:** Environment wasn't activated. This activates it.

---

### **Problem: "ComfyUI won't start"**

**Solution:**
```bash
# Stop all services
titan stop all

# Check what's using the port
lsof -i :8188

# Kill if something's there
killall -9 python3

# Start again
titan start comfyui
```

---

### **Problem: "Out of VRAM"**

**Solution:**
- Close unused browser tabs
- Restart ComfyUI: `titan restart comfyui`
- Reduce batch size in generation
- Use lower resolution (768 instead of 1024)

---

### **Problem: "Modules missing after restart"**

**Solution:**
```bash
# Reactivate environment
source /workspace/.titanrc

# Verify Python packages
pip list | grep torch

# If missing, reinstall
pip install --upgrade torch torchvision
```

---

## 📚 **WHAT'S NEXT**

Now that your environment is set up:

1. **Read:** `/workspace/s-tier-character-creation/docs/QUICKSTART.md`
2. **Create:** Your first character (Day 0-7 process)
3. **Explore:** ComfyUI workflows
4. **Train:** Your first LoRA

**Go to:** `docs/QUICKSTART.md` for your first project!

---

## 💰 **COST MANAGEMENT**

### **Hourly Costs:**
- RTX 5090: ~$1.29/hour
- Idle pod (stopped): $0.00/hour
- Storage (100GB): ~$8/month

### **Cost Saving Tips:**
1. **Stop pod when not in use** (saves hourly cost)
2. **Use "Pause" not "Terminate"** (keeps your data)
3. **Back up important files** (use titan-backup.sh)
4. **Only run services you need**

### **Stopping Your Pod:**
```bash
# Save your work first!
titan stop all

# Then stop pod in RunPod UI
```

**Your data in `/workspace` persists even when stopped.**

---

## 🆘 **GETTING HELP**

### **Resources:**
1. Read documentation in `/workspace/s-tier-character-creation/docs/`
2. Run diagnostics: `titan-diagnose.sh`
3. Check logs: `titan logs [service]`
4. RunPod Discord: community support
5. GitHub Issues (when released)

### **Common Issues:**
- Environment not activated → `source /workspace/.titanrc`
- Services not starting → `titan restart all`
- Port conflicts → `titan stop all && titan start all`

---

## ✅ **SETUP VERIFICATION CHECKLIST**

Before proceeding to character creation:

- [ ] Pod is running (RunPod dashboard shows "Running")
- [ ] GPU accessible (`nvidia-smi` works)
- [ ] TITAN environment active (`titan status` works)
- [ ] Services running (ComfyUI, Kohya, Jupyter all green)
- [ ] Models downloaded (at least one checkpoint)
- [ ] URLs accessible (can open ComfyUI in browser)
- [ ] Diagnostics passing (`titan-diagnose.sh` shows all ✓)

**If all checked → You're ready to create S-tier characters!**

---

## 🎯 **SUMMARY**

**What you accomplished:**
1. ✓ Created RunPod account
2. ✓ Deployed RTX 5090 GPU pod
3. ✓ Installed complete TITAN infrastructure
4. ✓ Downloaded AI models
5. ✓ Started all services
6. ✓ Verified system health

**Total setup time:** ~60 minutes  
**Total cost:** ~$1-2 for setup

**You now have:** A professional-grade AI character creation workstation.

---

**Next Step:** Read `docs/01-FIRST-PROJECT.md` to create your first character!

---

**Version:** 1.0  
**Last Updated:** November 2025  
**For:** S-Tier Character Creation Toolkit v2.0
