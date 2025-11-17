# ComfyUI Professional Setup v6.0.0 - PRODUCTION FINAL

**Zero-Compromise Quality + Premium User Experience**

This is the definitive, production-ready version of the ComfyUI setup scripts designed for AI character generation with world-class output and flawless reliability.

---

## 🎯 What's New in v6.0.0

### Critical Fixes
- ✅ **Fixed: Missing crontab dependency** - Auto-install or graceful fallback
- ✅ **Fixed: numpy dependency conflict** - Explicit numpy upgrade to resolve opencv incompatibility
- ✅ **Fixed: GUI auto-start failure** - ComfyUI now starts immediately after setup completes
- ✅ **Fixed: Confusing localhost URL** - Automatic RunPod URL detection and display

### User Experience Improvements
- ✅ **Zero warnings** - COMFYUI_PATH and COMFYUI_MODEL_PATH set explicitly
- ✅ **Streamlined folders** - Removed unnecessary training-images/workflows directories
- ✅ **Optimized installation** - Intelligent detection of existing packages (no redundant installs)
- ✅ **Enhanced download robustness** - Better retry logic, timeout handling, and progress indicators
- ✅ **Premium polish** - Clear step indicators, better logging, professional output formatting

---

## 🚀 Quick Start

### Prerequisites
- RunPod GPU pod with PyTorch template (recommended)
- Or any Linux environment with Python 3.10+ and CUDA-capable GPU
- 50GB+ free disk space (for models)

### Installation

**Step 1: Clone and Run Setup**
```bash
cd /workspace
git clone https://github.com/Kristina0810/didactic-giggle.git
cd didactic-giggle

# Run the setup script
./setup-comfyui-pro-v6.0.0.sh
```

**Step 2: Download Models**
```bash
# Download essential models (~15-20GB)
./download-models-pro-v6.0.0.sh
```

**Step 3: Access ComfyUI**
The setup script will display the correct URL for your environment:
- **RunPod**: `https://<pod-id>-8188.proxy.runpod.net`
- **Local**: `http://localhost:8188`

ComfyUI is automatically started after setup completes!

---

## 📋 What Gets Installed

### Base System
- ComfyUI (latest from RunPod template or manual install)
- Python dependencies (with conflict resolution)
- System packages (git, wget, cron)

### Custom Nodes (9 Essential)
1. **ComfyUI-Manager** - Node management and updates
2. **ComfyUI-Custom-Scripts** - Workflow utilities
3. **rgthree-comfy** - Enhanced workflow tools
4. **ComfyUI_IPAdapter_plus** - Image prompt adapter
5. **comfyui_controlnet_aux** - ControlNet preprocessors
6. **ComfyUI-Impact-Pack** - Advanced image processing
7. **ComfyUI-KJNodes** - Additional utility nodes
8. **was-node-suite-comfyui** - Comprehensive node suite
9. **ComfyUI-ReActor** - Face swapping for character consistency

### Models (Essential Set)
- **Checkpoint**: Juggernaut XL v9 (~6.5GB) - Photoreal character generation
- **VAE**: SDXL VAE (~335MB) - Image quality enhancement
- **Upscalers**: RealESRGAN, UltraSharp V1/V2 (~200MB total) - Detail enhancement
- **IP-Adapter**: SDXL (~3.4GB) - Style consistency
- **CLIP Vision**: ViT-H-14 (~2.5GB) - Image encoding
- **ControlNet**: OpenPose XL (~2.5GB) - Pose control

**Total: ~15-20GB**

### Optional Models
- Additional ControlNet models (Canny, Depth)

---

## 🔧 Features

### Reliability
- **Idempotent** - Safe to re-run without breaking existing setup
- **Retry logic** - Automatic retry with exponential backoff for network failures
- **Error handling** - Comprehensive error detection and graceful degradation
- **Health checks** - Automatic verification of installation integrity

### Auto-Start
- **RunPod on_start.sh** - Automatic startup on pod restart
- **Cron fallback** - @reboot job for additional reliability
- **PID management** - Safe process tracking and cleanup

### User Experience
- **Progress indicators** - Clear visual feedback at every step
- **Environment variables** - Automatic configuration (no manual edits needed)
- **Smart URL detection** - Shows correct access URL for your environment
- **Comprehensive logging** - All actions logged to `/workspace/logs/`

### Performance
- **Optimized installs** - Skips redundant package installations on RunPod template
- **Parallel downloads** - Multiple simultaneous downloads where safe
- **Resume support** - Continue interrupted downloads

---

## 📁 Directory Structure

After installation:

```
/workspace/
├── ComfyUI/                          # Main ComfyUI installation
│   ├── custom_nodes/                 # 9 essential custom nodes
│   ├── models/
│   │   ├── checkpoints/              # Base models
│   │   ├── vae/                      # VAE models
│   │   ├── upscale_models/           # Upscalers
│   │   ├── ipadapter/                # IP-Adapter models
│   │   ├── controlnet/               # ControlNet models
│   │   ├── clip_vision/              # CLIP vision encoders
│   │   └── loras/                    # LoRA models (user-added)
│   ├── input/                        # Input images
│   └── output/                       # Generated images
├── logs/                             # All logs
│   ├── comfyui-setup-*.log          # Setup logs
│   ├── model-download-*.log         # Download logs
│   └── comfyui.log                  # Runtime logs
├── on_start.sh                       # Auto-start script
├── comfyui.pid                       # Process ID file
└── .comfyui_env                      # Environment variables
```

---

## 🔍 Troubleshooting

### ComfyUI won't start
```bash
# Check logs
tail -f /workspace/logs/comfyui.log

# Manual start
cd /workspace/ComfyUI
python3 main.py --listen 0.0.0.0 --port 8188
```

### Model download failed
```bash
# Re-run download script (resumes from where it left off)
./download-models-pro-v6.0.0.sh

# Check specific model manually
ls -lh /workspace/ComfyUI/models/checkpoints/
```

### Environment variables not set
```bash
# Source the environment file
source /workspace/.comfyui_env

# Verify
echo $COMFYUI_PATH
echo $COMFYUI_MODEL_PATH
```

### Permission denied
```bash
# Make scripts executable
chmod +x setup-comfyui-pro-v6.0.0.sh
chmod +x download-models-pro-v6.0.0.sh
```

---

## 📊 System Requirements

### Minimum
- **GPU**: NVIDIA GPU with 8GB+ VRAM (RTX 3060 Ti or better)
- **RAM**: 16GB system RAM
- **Storage**: 50GB free space
- **OS**: Linux (Ubuntu 20.04+ recommended)
- **Python**: 3.10+

### Recommended (for optimal performance)
- **GPU**: NVIDIA GPU with 16GB+ VRAM (RTX 4080 or better)
- **RAM**: 32GB+ system RAM
- **Storage**: 100GB+ free space
- **Network**: Stable high-speed connection for model downloads

---

## 🎓 Next Steps

After successful installation:

1. **Explore ComfyUI Manager**
   - Access the Manager tab to install additional custom nodes
   - Update existing nodes to latest versions

2. **Download Additional Models**
   - Visit [CivitAI](https://civitai.com) for community models
   - Add LoRAs for specific styles/characters
   - Download additional ControlNet models

3. **Create Your First Workflow**
   - Load example workflows from ComfyUI Manager
   - Experiment with the installed models
   - Join the ComfyUI community for inspiration

4. **Optimize for Production**
   - Configure model caching
   - Set up batch processing
   - Implement API integration

---

## 🤝 Support

### Logs Location
All logs are stored in `/workspace/logs/` with timestamps:
- Setup: `comfyui-setup-YYYYMMDD-HHMMSS.log`
- Downloads: `model-download-YYYYMMDD-HHMMSS.log`
- Runtime: `comfyui.log`

### Common Issues
See [Troubleshooting](#-troubleshooting) section above.

### Manual Installation
If automated setup fails, refer to the official [ComfyUI documentation](https://github.com/comfyanonymous/ComfyUI).

---

## 📜 Version History

### v6.0.0 (2025-11-17) - PRODUCTION FINAL
**Critical Fixes:**
- Fixed missing crontab dependency (auto-install cron package)
- Fixed numpy dependency conflict (explicit upgrade to numpy>=2.0.0)
- Fixed GUI auto-start failure (immediate launch after setup)
- Fixed confusing localhost URL (RunPod URL auto-detection)

**UEX Improvements:**
- Eliminated environment variable warnings
- Removed unnecessary folders (training-images, workflows)
- Optimized installation (no redundant package installs)
- Enhanced download robustness and progress indicators
- Professional output formatting and logging

### v5.0.0 (2024-11-17)
- Clean slate architecture
- Production-ready + beginner-friendly
- Initial stable release

---

## 📄 License

This project is provided as-is for educational and commercial use.

**Author**: Orion (CTO)
**Company**: Karman Global LLC
**Date**: 2025-11-17

---

## ⭐ Acknowledgments

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI) - The amazing node-based UI
- RunPod - GPU cloud infrastructure
- ComfyUI community - Custom nodes and workflows
- All model creators and Hugging Face

---

**This is the final, definitive version. Ready for production deployment.**
