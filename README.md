# RunPod AI Development Environment v4.0.0

**World-class, zero-compromise AI development setup for RunPod**

Revolutionary persistent architecture with zero manual steps required after initial setup.

---

## 🎯 What This Is

A production-ready, two-pod system for professional AI character creation and LoRA training:

- **Pod 1**: ComfyUI for image generation
- **Pod 2**: Kohya_ss for LoRA training

**Key Innovation**: Persistent environment architecture that survives pod restarts with **zero manual intervention**.

---

## ⚡ Quick Start

### ComfyUI Pod

```bash
# One-time setup (run once)
cd /workspace
bash setup-comfyui-v4.0.0.sh

# Download models (optional)
bash download-models.sh

# Done! Restart pod anytime - everything auto-starts
```

### Kohya Training Pod

```bash
# One-time setup (run once)
cd /workspace
bash setup-kohya-v4.0.0.sh

# Done! Restart pod anytime - everything auto-starts
```

---

## 🏗️ Architecture Overview

### The Problem We Solved

Previous approaches failed because they installed Python environments in ephemeral locations (`/opt/venv`) that disappeared on pod restart, requiring manual re-activation every time.

### The v4.0.0 Solution

**Persistent Environment**: Everything lives in `/workspace` (persistent storage)

```
/workspace/
├── venv/                       # Persistent Python environment
├── .bashrc                     # Auto-activates venv in all shells
├── on_start.sh                 # Auto-starts services on pod boot
├── ComfyUI/                    # Application (persists)
├── kohya_ss/                   # Application (persists)
└── logs/                       # All logs (persistent)
```

**Three-Layer Auto-Start System**:

1. **Shell Auto-Activation**: `.bashrc` automatically activates the venv in every terminal session (SSH, Jupyter)
2. **Service Auto-Start**: `on_start.sh` automatically starts services on pod boot
3. **Base Service Preservation**: Auto-start hook calls base entrypoint first, preserving Jupyter/SSH

---

## 🔧 How It Works

### Setup Phase (One-Time)

1. Run setup script
2. Script creates persistent venv in `/workspace/venv`
3. Installs all dependencies to persistent location
4. Creates `.bashrc` for shell auto-activation
5. Creates `on_start.sh` for service auto-start
6. **Done** - no further action required

### Restart Phase (Automatic)

1. Pod restarts
2. RunPod executes `/workspace/on_start.sh` automatically
3. `on_start.sh` starts base services (Jupyter/SSH)
4. `on_start.sh` activates persistent venv
5. `on_start.sh` starts ComfyUI or Kohya
6. **All services running automatically**

When you open SSH/Jupyter:
- Shell sources `/workspace/.bashrc`
- Venv activates automatically
- Correct Python environment immediately available

---

## 📋 Features

### ✅ Persistent Environment
- Virtual environment survives restarts
- All dependencies persist
- No re-installation required

### ✅ Zero Manual Steps
- Services auto-start on boot
- Shells auto-activate venv
- No sourcing, no manual commands

### ✅ Idempotent Scripts
- Safe to run multiple times
- Checks if work already done
- Skips completed steps

### ✅ Base Service Preservation
- Jupyter continues to work
- SSH continues to work
- No conflicts with base image

### ✅ Robust & Professional
- Retry logic on downloads
- Clean, uniform output
- Comprehensive logging
- Error handling throughout

---

## 📦 What's Included

### Setup Scripts

- **`setup-comfyui-v4.0.0.sh`**: ComfyUI installation with persistent architecture
- **`setup-kohya-v4.0.0.sh`**: Kohya_ss installation with persistent architecture
- **`download-models.sh`**: Curated model downloader (v2.0.0) with retry logic

### Generated Files

- **`/workspace/venv/`**: Persistent Python environment
- **`/workspace/.bashrc`**: Shell auto-activation script
- **`/workspace/on_start.sh`**: Service auto-start hook

---

## 🚀 Usage

### Access Services

**ComfyUI**: RunPod Web Interface → Connect → HTTP Service [8188]
**Kohya_ss**: RunPod Web Interface → Connect → HTTP Service [7860]

### Manual Controls (if needed)

```bash
# Restart services manually
bash /workspace/on_start.sh

# View logs
tail -f /workspace/logs/comfyui.log
tail -f /workspace/logs/kohya.log
tail -f /workspace/logs/startup.log

# Stop services
pkill -f "python.*main.py"          # Stop ComfyUI
pkill -f "kohya_gui.py"              # Stop Kohya
```

### Training Workflow (Kohya Pod)

```bash
# 1. Upload training images
/workspace/training/datasets/raw/

# 2. Configure training
/workspace/training/configs/sample_lora_config.toml

# 3. Start training via Kohya Web UI

# 4. Find outputs
/workspace/training/outputs/lora/
```

---

## 🔍 Verification

After setup, verify the persistent architecture:

```bash
# Check venv exists and persists
ls -la /workspace/venv/

# Check auto-start hook
cat /workspace/on_start.sh

# Check shell auto-activation
cat /workspace/.bashrc

# Test venv activation (should see (venv) prefix)
source /workspace/.bashrc
which python
```

---

## 📊 Comparison: v3.2.0 vs v4.0.0

| Feature | v3.2.0 (Failed) | v4.0.0 (Revolutionary) |
|---------|----------------|------------------------|
| **Venv Location** | `/opt/venv` (ephemeral) | `/workspace/venv` (persistent) |
| **After Restart** | Manual activation required | Fully automatic |
| **Shell Sessions** | Must source manually | Auto-activated |
| **Service Start** | Manual command required | Auto-starts on boot |
| **User Experience** | High friction | Butter execution |
| **Architecture** | Broken by design | Persistent by design |

---

## 🎓 Technical Details

### RunPod Integration

RunPod's base images automatically execute `/workspace/on_start.sh` if present. We leverage this standard hook to:

1. Preserve base services (call base entrypoint)
2. Activate our persistent environment
3. Start our custom services

### Base Service Preservation

The `on_start.sh` script checks for and executes base entrypoints in priority order:

1. `/start.sh`
2. `/run.sh`
3. `/runpod-entrypoint.sh`

This ensures Jupyter and SSH continue to function.

### Shell Integration

We modify standard shell RC files (`~/.bashrc`, `~/.bash_profile`, `~/.profile`) to source `/workspace/.bashrc`, ensuring venv activation in all shell types (login, non-login, interactive).

---

## 🛠️ Troubleshooting

### Services didn't auto-start after restart

```bash
# Check startup logs
cat /workspace/logs/startup.log

# Manually start services
bash /workspace/on_start.sh
```

### Python packages not found

```bash
# Verify venv exists
ls /workspace/venv/

# Manually activate
source /workspace/venv/bin/activate

# Check Python location
which python  # Should point to /workspace/venv/bin/python
```

### Need to update ComfyUI/Kohya

```bash
cd /workspace/ComfyUI  # or kohya_ss
git pull
```

---

## 📝 Version History

### v4.0.0 (Current)
- **Revolutionary persistent architecture**
- Moved venv to `/workspace/venv`
- Implemented auto-activation via `.bashrc`
- Implemented auto-start via `on_start.sh`
- Zero manual steps required
- Idempotent setup scripts
- Enhanced download script with retry logic

### v3.2.0 (Deprecated)
- Used ephemeral `/opt/venv`
- Required manual activation after every restart
- Required manual service start
- Failed to meet "butter execution" standard

---

## 🏆 Standards Met

✅ **Zero Manual Steps**: Set up once, works forever
✅ **Persistent Environment**: Survives all restarts
✅ **Base Service Preservation**: Jupyter/SSH intact
✅ **Idempotent Scripts**: Safe to re-run
✅ **Professional Grade**: Clean, robust, documented
✅ **Butter Execution**: World-class user experience

---

## 📄 License

MIT

---

## 🤝 Support

For issues or questions, refer to setup logs:
- `/workspace/logs/setup/`
- `/workspace/logs/startup.log`
- `/workspace/logs/comfyui.log` or `/workspace/logs/kohya.log`

---

**Built for RunPod. Designed for professionals. Zero compromise.**
