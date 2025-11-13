#!/bin/bash
# =============================================================================
# KOHYA TRAINING POD SETUP - Dedicated Training Environment
# =============================================================================
# Purpose: Minimal Kohya_ss setup for LoRA training (Day 4 only)
# Time: 5-10 minutes | Zero interference | Maximum GPU utilization
# Hardware: NVIDIA RTX GPUs (24GB+ VRAM recommended)
# Base: RunPod PyTorch 2.x template
# Version: 3.0.3
# License: MIT
# =============================================================================
# Architecture: Two-Pod System - This is the Training Pod
# Use this pod only for Day 4 training, then pause to save costs
# =============================================================================

set -e
trap 'error_handler $? $LINENO' ERR

# Configuration
readonly SCRIPT_VERSION="3.0.3"
readonly WORKSPACE="/workspace"
readonly LOG_DIR="${WORKSPACE}/logs/setup"
readonly TIMESTAMP=$(date +%Y%m%d_%H%M%S)
readonly LOG_FILE="${LOG_DIR}/kohya_setup_${TIMESTAMP}.log"

# ANSI Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

# Create log directory
mkdir -p "$LOG_DIR"

# Track setup time
START_TIME=$(date +%s)

# =============================================================================
# LOGGING SYSTEM
# =============================================================================

log() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo -e "${CYAN}▸${NC} $1"
    echo "$msg" >> "$LOG_FILE"
}

success() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] ✓ $1"
    echo -e "${GREEN}✓${NC} $1"
    echo "$msg" >> "$LOG_FILE"
}

warning() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] ⚠ $1"
    echo -e "${YELLOW}⚠${NC} $1"
    echo "$msg" >> "$LOG_FILE"
}

error() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] ✗ $1"
    echo -e "${RED}✗${NC} $1" >&2
    echo "$msg" >> "$LOG_FILE"
}

error_handler() {
    local exit_code=$1
    local line_no=$2
    error "Setup failed at line $line_no with exit code $exit_code"
    echo -e "${YELLOW}Full log: ${LOG_FILE}${NC}"
    exit $exit_code
}

section() {
    echo ""
    echo -e "${BOLD}${BLUE}━━━ $1 ━━━${NC}"
    echo ""
    local section_msg="[$(date '+%Y-%m-%d %H:%M:%S')] === $1 ==="
    echo "$section_msg" >> "$LOG_FILE"
}

progress() {
    echo -e "${CYAN}  ▸ $1${NC}"
    echo "  [PROGRESS] $1" >> "$LOG_FILE"
}

# =============================================================================
# HEADER
# =============================================================================

clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║              KOHYA TRAINING POD SETUP v3.0.3                          ║
║          Professional LoRA Training Environment                       ║
║                                                                       ║
║          Hardware: NVIDIA RTX 3090/4090/5090 (24GB+ VRAM)            ║
║          Architecture: Two-Pod System (Training Pod)                  ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
EOF
echo ""
log "Kohya Training Pod Setup v${SCRIPT_VERSION} started"
log "Log file: ${LOG_FILE}"
echo ""
echo -e "${CYAN}This pod is dedicated to LoRA training (Day 4 only)${NC}"
echo -e "${CYAN}Estimated time: 5-10 minutes${NC}"
echo ""

# =============================================================================
# PHASE 1: ENVIRONMENT VERIFICATION (30 seconds)
# =============================================================================
section "PHASE 1: Environment Verification"

progress "Detecting GPU hardware..."
if ! command -v nvidia-smi &>/dev/null; then
    error "NVIDIA GPU not detected"
    exit 1
fi

GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1)
VRAM_MB=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -1)
VRAM_GB=$((VRAM_MB / 1024))
GPU_DRIVER=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)

success "GPU: ${GPU_NAME}"
success "VRAM: ${VRAM_GB}GB"
success "Driver: ${GPU_DRIVER}"

# VRAM check
if [ "$VRAM_GB" -lt 20 ]; then
    error "Insufficient VRAM: ${VRAM_GB}GB (minimum 24GB required)"
    exit 1
fi

# Training profile
if [ "$VRAM_GB" -ge 30 ]; then
    TRAINING_PROFILE="RTX_5090"
    RECOMMENDED_BATCH=6
    ESTIMATED_TIME="1.8 hours"
else
    TRAINING_PROFILE="RTX_3090"
    RECOMMENDED_BATCH=4
    ESTIMATED_TIME="3.8 hours"
fi

success "Training Profile: ${TRAINING_PROFILE}"
log "Recommended Batch: ${RECOMMENDED_BATCH}"
log "Estimated Time: ${ESTIMATED_TIME} (800 images, 10 epochs)"

# Python verification
progress "Verifying Python + PyTorch..."
PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2)
success "Python: ${PYTHON_VERSION}"

# PyTorch verification
PYTORCH_CHECK=$(python3 << 'PYCHECK'
import torch
print(f"PyTorch: {torch.__version__}")
print(f"CUDA: {torch.version.cuda if torch.cuda.is_available() else 'Not available'}")
PYCHECK
)

if [ $? -ne 0 ]; then
    error "PyTorch verification failed"
    exit 1
fi

echo "$PYTORCH_CHECK" | while read line; do
    success "$line"
done

# Disk space
DISK_FREE_GB=$(df -BG "$WORKSPACE" | tail -1 | awk '{print $4}' | sed 's/G//')
if [ "$DISK_FREE_GB" -lt 30 ]; then
    warning "Low disk space: ${DISK_FREE_GB}GB (need ~30GB for dataset + outputs)"
else
    success "Disk space: ${DISK_FREE_GB}GB available"
fi

POD_ID=$(hostname)
success "Pod ID: ${POD_ID}"

# =============================================================================
# PHASE 2: KOHYA_SS INSTALLATION (3-5 minutes)
# =============================================================================
section "PHASE 2: Kohya_ss Installation"

cd "$WORKSPACE"

# Check if Kohya exists
if [ -d "kohya_ss" ]; then
    warning "Kohya_ss directory exists - updating..."
    cd kohya_ss
    
    progress "Pulling latest Kohya updates..."
    if git pull 2>&1 | tee -a "$LOG_FILE" | tail -5; then
        success "Kohya_ss updated"
    else
        warning "Update had issues (may already be current)"
    fi
    cd ..
else
    progress "Cloning Kohya_ss repository..."
    if git clone https://github.com/bmaltais/kohya_ss 2>&1 | tee -a "$LOG_FILE" | tail -5; then
        success "Kohya_ss cloned"
    else
        error "Failed to clone Kohya_ss"
        exit 1
    fi
fi

cd kohya_ss

# Initialize submodules
progress "Initializing submodules..."
git submodule update --init --recursive 2>&1 | tee -a "$LOG_FILE" | tail -3

# Check and install training dependencies
progress "Checking training dependencies..."

TRAINING_PACKAGES=(
    "accelerate"
    "transformers"
    "diffusers"
    "bitsandbytes"
    "tensorboard"
    "toml"
    "omegaconf"
    "easygui"
)

MISSING=()
for pkg in "${TRAINING_PACKAGES[@]}"; do
    pkg_import=$(echo "$pkg" | sed 's/-/_/g')
    if ! python3 -c "import ${pkg_import}" 2>/dev/null; then
        MISSING+=("$pkg")
    fi
done

if [ ${#MISSING[@]} -eq 0 ]; then
    success "All training dependencies already installed"
else
    log "Installing ${#MISSING[@]} training packages..."
    pip install "${MISSING[@]}" --no-cache-dir 2>&1 | tee -a "$LOG_FILE" | tail -10
    success "Training dependencies installed"
fi

# Install Gradio for web UI
progress "Checking Gradio (web interface)..."
if ! python3 -c "import gradio" 2>/dev/null; then
    log "Installing Gradio..."
    pip install "gradio>=4.0.0" --no-cache-dir 2>&1 | tee -a "$LOG_FILE" | tail -5 || {
        warning "Latest Gradio failed, trying specific version..."
        pip install gradio==4.19.2 --no-cache-dir 2>&1 | tee -a "$LOG_FILE" | tail -5
    }
    success "Gradio installed"
else
    success "Gradio already installed"
fi

# Verification
progress "Verifying Kohya environment..."
python3 << 'VERIFY' 2>&1 | tee -a "$LOG_FILE"
import sys
try:
    import torch
    import accelerate
    import transformers
    import diffusers
    import bitsandbytes
    print("✓ All critical packages verified")
except ImportError as e:
    print(f"✗ Missing package: {e}")
    sys.exit(1)
VERIFY

if [ $? -ne 0 ]; then
    error "Kohya environment verification failed"
    exit 1
fi

success "Kohya_ss installation complete"

# =============================================================================
# PHASE 3: TRAINING STRUCTURE (10 seconds)
# =============================================================================
section "PHASE 3: Training Directory Structure"

progress "Creating training directories..."

cd "$WORKSPACE"

mkdir -p training/{datasets,outputs/loras,configs,logs}
mkdir -p training/datasets/upload  # For uploaded datasets

# Create recommended training config template
cat > training/configs/recommended-${TRAINING_PROFILE}.toml << TOML
# Kohya Training Configuration
# Profile: ${TRAINING_PROFILE}
# Auto-generated by setup script

[model]
pretrained_model_name_or_path = "/workspace/models/base_checkpoint.safetensors"
v2 = false
v_parameterization = false

[dataset]
resolution = 1024
batch_size = ${RECOMMENDED_BATCH}
enable_bucket = true
bucket_no_upscale = false
min_bucket_reso = 256
max_bucket_reso = 1536

[training]
output_dir = "/workspace/training/outputs/loras"
output_name = "character_lora"
save_model_as = "safetensors"
max_train_epochs = 10
save_every_n_epochs = 2

learning_rate = 1e-4
lr_scheduler = "cosine_with_restarts"
lr_warmup_steps = 0

optimizer_type = "AdamW8bit"
mixed_precision = "fp16"
save_precision = "fp16"

[network]
network_module = "networks.lora"
network_dim = 128
network_alpha = 64

[logging]
logging_dir = "/workspace/training/logs"
log_prefix = "character_lora"
TOML

success "Training structure created"
success "Config template: training/configs/recommended-${TRAINING_PROFILE}.toml"

# =============================================================================
# PHASE 4: WEB UI CONFIGURATION (30 seconds)
# =============================================================================
section "PHASE 4: Web UI Configuration"

progress "Creating persistent environment initialization script..."

# Create persistent init script for Kohya
cat > "$WORKSPACE/init-kohya-env.sh" << 'INIT_SCRIPT'
#!/bin/bash
# ==============================================================================
# PERSISTENT ENVIRONMENT INITIALIZATION - KOHYA POD
# ==============================================================================
# Location: /workspace/init-kohya-env.sh (survives pod restarts)
# Purpose: Configure environment on pod boot
# Usage: Set as Container Start Command in RunPod
# ==============================================================================

LOG_FILE="/workspace/logs/init-$(date +%Y%m%d-%H%M%S).log"
mkdir -p /workspace/logs

{
    echo "=== Kohya Environment Initialization ==="
    echo "Time: $(date)"
    echo "Pod: $(hostname)"
    
    # Detect Python environment
    if [ -d "/opt/venv" ]; then
        VENV_PATH="/opt/venv"
    elif [ -d "/venv" ]; then
        VENV_PATH="/venv"
    else
        echo "Warning: No venv detected, using system Python"
        VENV_PATH=""
    fi
    
    # Configure root user's bashrc (ephemeral, recreated each start)
    echo "Configuring shell environment..."
    cat > /root/.bashrc << 'ROOTBASH'
# Default bash configuration
[ -z "$PS1" ] && return

# Activate venv if available
if [ -d "/opt/venv" ] && [ -z "$VIRTUAL_ENV" ]; then
    source /opt/venv/bin/activate
elif [ -d "/venv" ] && [ -z "$VIRTUAL_ENV" ]; then
    source /venv/bin/activate
fi

# Workspace shortcut
alias ws='cd /workspace'
ROOTBASH
    
    echo "✓ Shell environment configured"
    echo "=== Initialization Complete ==="
    
} >> "$LOG_FILE" 2>&1

# Pass through to original entrypoint
if [ $# -gt 0 ]; then
    exec "$@"
else
    exec sleep infinity
fi
INIT_SCRIPT

chmod +x "$WORKSPACE/init-kohya-env.sh"

success "Persistent initialization script created"
log "Location: /workspace/init-kohya-env.sh"

progress "Configuring Kohya web interface..."

# Create launch script
cat > "$WORKSPACE/start-kohya.sh" << 'LAUNCH'
#!/bin/bash
# Kohya_ss Web UI Launcher

cd /workspace/kohya_ss

# Detect Python with packages
if [ -d "/opt/venv" ]; then
    PYTHON_CMD="/opt/venv/bin/python"
elif [ -d "/venv" ]; then
    PYTHON_CMD="/venv/bin/python"
else
    PYTHON_CMD="python3"
fi

echo "Starting Kohya_ss Web UI..."
echo "Using Python: $PYTHON_CMD"
echo "Running on port 7860"
echo ""
echo "Press Ctrl+C to stop"
echo ""

$PYTHON_CMD kohya_gui.py \
    --listen 0.0.0.0 \
    --server_port 7860 \
    --headless \
    --share
LAUNCH

chmod +x "$WORKSPACE/start-kohya.sh"

success "Web UI configured"
log "Launch command: bash /workspace/start-kohya.sh"

# =============================================================================
# INSTALLATION COMPLETE
# =============================================================================

cd "$WORKSPACE"

SETUP_TIME=$(( ($(date +%s) - START_TIME) / 60 ))

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                                       ║${NC}"
echo -e "${GREEN}║         Kohya Training Pod Setup Complete ✓                           ║${NC}"
echo -e "${GREEN}║            *** Dedicated Training Environment ***                     ║${NC}"
echo -e "${GREEN}║                                                                       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Save installation record
cat > "$WORKSPACE/.kohya_pod_info" << INFO
SCRIPT_VERSION=${SCRIPT_VERSION}
INSTALL_DATE=$(date)
POD_ID=${POD_ID}
GPU=${GPU_NAME}
VRAM=${VRAM_GB}GB
PROFILE=${TRAINING_PROFILE}
BATCH_SIZE=${RECOMMENDED_BATCH}
ESTIMATED_TIME=${ESTIMATED_TIME}
PYTHON=${PYTHON_VERSION}
ARCHITECTURE=TWO_POD_SYSTEM
POD_PURPOSE=KOHYA_TRAINING
INFO

echo -e "${CYAN}Installation Summary:${NC}"
echo "  Pod Purpose: LoRA Training (Day 4 only)"
echo "  Hardware: ${GPU_NAME} (${VRAM_GB}GB)"
echo "  Training Profile: ${TRAINING_PROFILE}"
echo "  Batch Size: ${RECOMMENDED_BATCH}"
echo "  Estimated Training Time: ${ESTIMATED_TIME}"
echo ""

echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  CRITICAL: Enable Persistent Environment (One-Time Setup)             ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "To ensure environment persists across pod restarts:"
echo ""
echo "  1. Go to RunPod → Edit Pod"
echo "  2. Find 'Docker Command' or 'Container Start Command' field"
echo "  3. Enter exactly:"
echo ""
echo -e "     ${YELLOW}bash /workspace/init-kohya-env.sh sleep infinity${NC}"
echo ""
echo "  4. Save changes"
echo ""
echo "This configures the Python environment for all new shells."
echo ""

echo -e "${CYAN}Access Kohya:${NC}"
echo "  Use RunPod's web interface to access port 7860"
echo "  Or check RunPod dashboard for pod URL"
echo ""

echo -e "${CYAN}Quick Start:${NC}"
echo "  1. Upload your dataset to: /workspace/training/datasets/upload/"
echo ""
echo "  2. Start Kohya web interface:"
echo -e "     ${YELLOW}bash /workspace/start-kohya.sh${NC}"
echo ""
echo "  3. Configure training in web UI:"
echo "     - Load recommended config from: training/configs/"
echo "     - Set dataset path"
echo "     - Start training"
echo ""

echo -e "${CYAN}Training Workflow:${NC}"
echo "  1. Transfer dataset from ComfyUI pod (upload to this pod)"
echo "  2. Start Kohya web UI"
echo "  3. Configure and start training (~${ESTIMATED_TIME})"
echo "  4. Download trained LoRA checkpoints"
echo "  5. Transfer back to ComfyUI pod for testing"
echo "  6. Stop/pause this pod when done (save costs)"
echo ""

echo -e "${GREEN}Features:${NC}"
echo "  ✓ Dedicated training environment (no interference)"
echo "  ✓ 100% GPU utilization for training"
echo "  ✓ Optimized batch size for your hardware"
echo "  ✓ Web UI for easy configuration"
echo "  ✓ Comprehensive logging"
echo ""

echo -e "${YELLOW}Setup Time:${NC} ${SETUP_TIME} minutes"
echo ""

echo -e "${CYAN}Logs saved to:${NC} ${LOG_FILE}"
echo ""

echo -e "${BOLD}${GREEN}Setup successful! Kohya training pod is ready.${NC}"
echo ""
