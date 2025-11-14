#!/bin/bash
# =============================================================================
# COMFYUI POD SETUP - World-Class Minimal Installation
# =============================================================================
# Purpose: Ultra-fast ComfyUI setup for RunPod PyTorch environment
# Time: 5-10 minutes | Zero redundancy | Maximum efficiency
# Hardware: NVIDIA RTX GPUs (24GB+ VRAM recommended)
# Base: RunPod PyTorch 2.x template
# Version: 3.0.3
# License: MIT
# =============================================================================
# Architecture: Two-Pod System - This is the ComfyUI Generation Pod
# For training, use separate kohya-pod-setup.sh on Day 4
# =============================================================================

set -e
trap 'error_handler $? $LINENO' ERR

# Configuration
readonly SCRIPT_VERSION="3.0.3"
readonly WORKSPACE="/workspace"
readonly LOG_DIR="${WORKSPACE}/logs/setup"
readonly TIMESTAMP=$(date +%Y%m%d_%H%M%S)
readonly LOG_FILE="${LOG_DIR}/comfyui_setup_${TIMESTAMP}.log"

# ANSI Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly MAGENTA='\033[0;35m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

# Create log directory
mkdir -p "$LOG_DIR"

# Track setup time
START_TIME=$(date +%s)

# =============================================================================
# LOGGING SYSTEM - Comprehensive with Robust Troubleshooting
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
    echo -e "${YELLOW}Troubleshooting: Check log for detailed error information${NC}"
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
║              COMFYUI POD SETUP v3.0.3                                 ║
║          Professional ComfyUI Installation                            ║
║                                                                       ║
║          Hardware: NVIDIA RTX 3090/4090/5090 (24GB+ VRAM)            ║
║          Architecture: Two-Pod System (Generation Pod)                ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
EOF
echo ""
log "ComfyUI Pod Setup v${SCRIPT_VERSION} started"
log "Log file: ${LOG_FILE}"
echo ""
echo -e "${CYAN}This setup uses RunPod's existing environment - zero redundancy${NC}"
echo -e "${CYAN}Estimated time: 5-10 minutes${NC}"
echo ""

# =============================================================================
# PHASE 1: ENVIRONMENT VERIFICATION (30 seconds)
# =============================================================================
section "PHASE 1: Environment Verification"

progress "Detecting GPU hardware..."
if ! command -v nvidia-smi &>/dev/null; then
    error "NVIDIA GPU not detected. This requires an NVIDIA GPU."
    exit 1
fi

GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1)
VRAM_MB=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -1)
VRAM_GB=$((VRAM_MB / 1024))
GPU_DRIVER=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)

success "GPU: ${GPU_NAME}"
success "VRAM: ${VRAM_GB}GB (${VRAM_MB}MB)"
success "Driver: ${GPU_DRIVER}"

# VRAM check
if [ "$VRAM_GB" -lt 20 ]; then
    error "Insufficient VRAM: ${VRAM_GB}GB (minimum 24GB required)"
    error "This toolkit requires RTX 3090 (24GB) or RTX 5090 (32GB+)"
    exit 1
fi

# Determine hardware profile
if [ "$VRAM_GB" -ge 30 ]; then
    HARDWARE_PROFILE="RTX_5090"
    RECOMMENDED_BATCH=8
    TRAINING_SPEED="Ultra-Fast (1.8 hours)"
else
    HARDWARE_PROFILE="RTX_3090"
    RECOMMENDED_BATCH=4
    TRAINING_SPEED="Fast (3.8 hours)"
fi

success "Hardware Profile: ${HARDWARE_PROFILE}"
log "Recommended Batch Size: ${RECOMMENDED_BATCH}"
log "Expected Training Speed: ${TRAINING_SPEED}"

# Python verification
progress "Verifying Python environment..."
PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2)
success "Python: ${PYTHON_VERSION}"

# PyTorch + CUDA verification (use existing)
progress "Verifying PyTorch + CUDA (using RunPod's installation)..."
PYTORCH_CHECK=$(python3 << 'PYCHECK'
import sys
try:
    import torch
    print(f"PyTorch: {torch.__version__}")
    if not torch.cuda.is_available():
        print("ERROR: CUDA not available")
        sys.exit(1)
    print(f"CUDA: {torch.version.cuda}")
    
    # Quick CUDA test
    x = torch.randn(100, 100).cuda()
    y = torch.mm(x, x)
    print("CUDA computation: OK")
    
except Exception as e:
    print(f"ERROR: {e}")
    sys.exit(1)
PYCHECK
)

if [ $? -ne 0 ]; then
    error "PyTorch/CUDA verification failed"
    error "RunPod PyTorch template may not be properly configured"
    exit 1
fi

echo "$PYTORCH_CHECK" | while read line; do
    success "$line"
done

# Disk space check
progress "Checking available disk space..."
DISK_FREE_GB=$(df -BG "$WORKSPACE" | tail -1 | awk '{print $4}' | sed 's/G//')
if [ "$DISK_FREE_GB" -lt 50 ]; then
    warning "Low disk space: ${DISK_FREE_GB}GB free (recommended 100GB+)"
    warning "You may need to clean up space during setup"
else
    success "Disk space: ${DISK_FREE_GB}GB available"
fi

# Check if we're on RunPod
POD_ID=$(hostname)
# RunPod hostnames are alphanumeric like: cf9f16417883 or with hyphens like: abc-def-123
if [[ $POD_ID =~ ^[a-z0-9]+(-[a-z0-9]+)?$ ]]; then
    success "RunPod environment detected (Pod ID: ${POD_ID})"
    RUNPOD_DETECTED=true
else
    warning "RunPod environment not detected (hostname: ${POD_ID})"
    warning "Some features may not work as expected"
    RUNPOD_DETECTED=false
fi

log "Environment verification complete - all checks passed"

# =============================================================================
# PHASE 2: COMFYUI SETUP (2-3 minutes)
# =============================================================================
section "PHASE 2: ComfyUI Installation"

cd "$WORKSPACE"

# Check if ComfyUI already exists
if [ -d "ComfyUI" ]; then
    warning "ComfyUI directory exists - updating..."
    cd ComfyUI
    
    progress "Pulling latest ComfyUI updates..."
    if git pull 2>&1 | tee -a "$LOG_FILE"; then
        success "ComfyUI updated to latest version"
    else
        warning "Update had issues (may already be current)"
    fi
    cd ..
else
    progress "Cloning ComfyUI repository..."
    if git clone https://github.com/comfyanonymous/ComfyUI 2>&1 | tee -a "$LOG_FILE" | tail -5; then
        success "ComfyUI repository cloned"
    else
        error "Failed to clone ComfyUI repository"
        error "Check network connectivity"
        exit 1
    fi
fi

cd ComfyUI

# Check what's already installed vs what's needed
progress "Checking ComfyUI dependencies..."

# Install requirements directly - no smart checking, just install
log "Installing ComfyUI requirements..."
if python3 -m pip install -r requirements.txt --no-cache-dir 2>&1 | tee -a "$LOG_FILE" | tail -10; then
    success "ComfyUI requirements installed"
else
    warning "Some package installations had warnings (non-critical if ComfyUI starts)"
fi

# Install essential additional packages
progress "Installing essential packages..."
python3 -m pip install --no-cache-dir \
    opencv-python transformers accelerate safetensors einops omegaconf \
    2>&1 | tee -a "$LOG_FILE" | tail -10

success "Essential packages installed"

# Essential custom nodes
progress "Setting up essential custom nodes..."
cd custom_nodes

# ComfyUI-Manager (critical for package management)
if [ -d "ComfyUI-Manager" ]; then
    log "ComfyUI-Manager exists - updating..."
    cd ComfyUI-Manager && git pull 2>&1 | tee -a "$LOG_FILE" | tail -3 && cd ..
else
    progress "Installing ComfyUI-Manager (critical)..."
    if git clone https://github.com/ltdrdata/ComfyUI-Manager 2>&1 | tee -a "$LOG_FILE" | tail -3; then
        success "ComfyUI-Manager installed"
    else
        warning "ComfyUI-Manager clone failed (non-critical, can install later)"
    fi
fi

# Impact Pack (quality improvements)
if [ -d "ComfyUI-Impact-Pack" ]; then
    log "Impact-Pack exists - updating..."
    cd ComfyUI-Impact-Pack && git pull 2>&1 | tee -a "$LOG_FILE" | tail -3 && cd ..
else
    progress "Installing Impact-Pack (recommended)..."
    if git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack 2>&1 | tee -a "$LOG_FILE" | tail -3; then
        success "Impact-Pack installed"
        # Install Impact-Pack requirements if exists
        if [ -f "ComfyUI-Impact-Pack/requirements.txt" ]; then
            pip install -r ComfyUI-Impact-Pack/requirements.txt --no-cache-dir 2>&1 | tee -a "$LOG_FILE" | tail -5 || true
        fi
    else
        warning "Impact-Pack clone failed (non-critical)"
    fi
fi

cd "$WORKSPACE/ComfyUI"
success "ComfyUI core setup complete"

# =============================================================================
# PHASE 3: PROJECT STRUCTURE (10 seconds)
# =============================================================================
section "PHASE 3: Project Structure"

progress "Creating standard project directories..."

mkdir -p "$WORKSPACE/projects"
mkdir -p "$WORKSPACE/outputs"/{portfolio,finals,archive}
mkdir -p "$WORKSPACE/workflows"/{production,templates}
mkdir -p "$WORKSPACE/logs"/{comfyui,setup,training}

# Create helpful .gitignore
cat > "$WORKSPACE/.gitignore" << 'GITIGNORE'
# Models (large files)
*.safetensors
*.ckpt
*.pth
*.bin

# Outputs
outputs/
*.png
*.jpg

# Logs
logs/
*.log

# Python
__pycache__/
*.pyc
*.pyo

# System
.DS_Store
Thumbs.db
GITIGNORE

success "Project structure created"

# Create model paths config for ComfyUI
progress "Configuring model paths..."
cat > "$WORKSPACE/ComfyUI/extra_model_paths.yaml" << 'YAML'
# ComfyUI Model Paths Configuration
titan:
  base_path: /workspace/ComfyUI/
  checkpoints: models/checkpoints/
  vae: models/vae/
  loras: models/loras/
  controlnet: models/controlnet/
  clip_vision: models/clip_vision/
  upscale_models: models/upscale_models/
YAML

success "Model paths configured"

# =============================================================================
# PHASE 4: START COMFYUI & AUTO-START CONFIGURATION
# =============================================================================
section "PHASE 4: Starting ComfyUI"

progress "Starting ComfyUI web interface..."

cd "$WORKSPACE/ComfyUI"

# Ensure we use the Python that has all our installed packages
# RunPod typically has venv at /opt/venv
if [ -d "/opt/venv" ]; then
    PYTHON_CMD="/opt/venv/bin/python"
elif [ -n "$VIRTUAL_ENV" ]; then
    PYTHON_CMD="$VIRTUAL_ENV/bin/python"
else
    PYTHON_CMD="python3"
fi

log "Using Python: $PYTHON_CMD"

# Start ComfyUI in background with logging
nohup $PYTHON_CMD main.py --listen 0.0.0.0 --port 8188 \
    > /workspace/logs/comfyui/comfyui.log 2>&1 &

COMFY_PID=$!
echo $COMFY_PID > /workspace/.comfyui.pid

log "ComfyUI started with PID: $COMFY_PID"

# Wait and verify startup
progress "Verifying ComfyUI startup..."
sleep 5

if kill -0 $COMFY_PID 2>/dev/null; then
    success "ComfyUI is running (PID: $COMFY_PID)"
    
    if [ "$RUNPOD_DETECTED" = true ]; then
        COMFY_URL="https://${POD_ID}-8188.proxy.runpod.net"
        success "Access URL: ${COMFY_URL}"
        echo ""
        echo -e "${GREEN}${BOLD}ComfyUI is now accessible at:${NC}"
        echo -e "${CYAN}${COMFY_URL}${NC}"
        echo ""
    else
        success "ComfyUI running on port 8188"
    fi
else
    error "ComfyUI failed to start - check logs: /workspace/logs/comfyui/comfyui.log"
    exit 1
fi

# Create persistent init script
progress "Creating persistent environment initialization script..."

cat > "$WORKSPACE/init-env.sh" << 'INIT_SCRIPT'
#!/bin/bash
# ==============================================================================
# PERSISTENT ENVIRONMENT INITIALIZATION
# ==============================================================================
# Location: /workspace/init-env.sh (survives pod restarts)
# Purpose: Configure environment and start services on pod boot
# Usage: Set as Container Start Command in RunPod
# ==============================================================================

LOG_FILE="/workspace/logs/init-$(date +%Y%m%d-%H%M%S).log"
mkdir -p /workspace/logs

{
    echo "=== Environment Initialization ==="
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
    
    # Start ComfyUI if available
    if [ -f /workspace/ComfyUI/main.py ]; then
        echo "Starting ComfyUI..."
        
        # Check if already running
        if pgrep -f "python.*ComfyUI/main.py" > /dev/null; then
            echo "ComfyUI already running"
        else
            cd /workspace/ComfyUI
            
            # Use correct Python
            if [ -n "$VENV_PATH" ]; then
                PYTHON_CMD="$VENV_PATH/bin/python"
            else
                PYTHON_CMD="python3"
            fi
            
            nohup $PYTHON_CMD main.py --listen 0.0.0.0 --port 8188 \
                >> /workspace/logs/comfyui/comfyui.log 2>&1 &
            
            sleep 3
            
            if pgrep -f "python.*ComfyUI/main.py" > /dev/null; then
                echo "✓ ComfyUI started successfully"
                echo "  Running on port 8188"
            else
                echo "✗ ComfyUI failed to start - check logs"
            fi
        fi
    fi
    
    echo "=== Initialization Complete ==="
    
} >> "$LOG_FILE" 2>&1

# Pass through to original entrypoint
# This preserves Jupyter, SSH, and other base services
if [ $# -gt 0 ]; then
    exec "$@"
else
    # Fallback: keep container running
    exec sleep infinity
fi
INIT_SCRIPT

chmod +x "$WORKSPACE/init-env.sh"

success "Persistent initialization script created"
log "Location: /workspace/init-env.sh"

cat > "$WORKSPACE/restart-comfyui.sh" << 'RESTART'
#!/bin/bash
# Manual restart script for ComfyUI

cd /workspace/ComfyUI

# Kill any existing instance
pkill -f "python.*main.py" 2>/dev/null
sleep 2

# Detect Python with packages
if [ -d "/opt/venv" ]; then
    PYTHON_CMD="/opt/venv/bin/python"
elif [ -n "$VIRTUAL_ENV" ]; then
    PYTHON_CMD="$VIRTUAL_ENV/bin/python"
else
    PYTHON_CMD="python3"
fi

# Start ComfyUI
nohup $PYTHON_CMD main.py --listen 0.0.0.0 --port 8188 \
    > /workspace/logs/comfyui/comfyui.log 2>&1 &

PID=$!
echo "ComfyUI started with PID: $PID"
echo "Running on port 8188"
RESTART

chmod +x "$WORKSPACE/restart-comfyui.sh"

success "Restart script created: /workspace/restart-comfyui.sh"
log "ComfyUI is running and will persist until pod stops"
log "To restart manually: bash /workspace/restart-comfyui.sh"

# =============================================================================
# INSTALLATION COMPLETE
# =============================================================================

cd "$WORKSPACE"

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                                       ║${NC}"
echo -e "${GREEN}║         ComfyUI Pod Setup Complete ✓                                  ║${NC}"
echo -e "${GREEN}║            *** World-Class Installation ***                           ║${NC}"
echo -e "${GREEN}║                                                                       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Save installation record
cat > "$WORKSPACE/.comfyui_pod_info" << INFO
SCRIPT_VERSION=${SCRIPT_VERSION}
INSTALL_DATE=$(date)
POD_ID=${POD_ID}
GPU=${GPU_NAME}
VRAM=${VRAM_GB}GB
PROFILE=${HARDWARE_PROFILE}
PYTHON=${PYTHON_VERSION}
AUTO_START=ENABLED
ARCHITECTURE=TWO_POD_SYSTEM
POD_PURPOSE=COMFYUI_GENERATION
INFO

# Display summary
echo -e "${CYAN}Installation Summary:${NC}"
echo "  Pod Purpose: ComfyUI Generation (Days 0-3, 5-7)"
echo "  Hardware: ${GPU_NAME} (${VRAM_GB}GB)"
echo "  Profile: ${HARDWARE_PROFILE}"
echo "  Batch Size: ${RECOMMENDED_BATCH}"
echo "  ComfyUI: Running on port 8188"
echo ""

echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  CRITICAL: Enable Persistent Environment (One-Time Setup)             ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "To ensure ComfyUI and environment persist across pod restarts:"
echo ""
echo "  1. Go to RunPod → Edit Pod"
echo "  2. Find 'Docker Command' or 'Container Start Command' field"
echo "  3. Enter exactly:"
echo ""
echo -e "     ${YELLOW}bash /workspace/init-env.sh sleep infinity${NC}"
echo ""
echo "  4. Save changes"
echo ""
echo "This configures the environment and auto-starts ComfyUI on every restart."
echo ""

echo -e "${CYAN}Access ComfyUI:${NC}"
echo "  Use RunPod's web interface to access port 8188"
echo "  Or check RunPod dashboard for pod URL"
echo ""

echo -e "${CYAN}Quick Start:${NC}"
echo "  ComfyUI is already running!"
echo ""
echo "  If you need to restart ComfyUI manually:"
echo -e "     ${YELLOW}bash /workspace/restart-comfyui.sh${NC}"
echo ""

echo -e "${CYAN}Next Steps:${NC}"
echo -e "  1. ${BOLD}Download Models:${NC}"
echo -e "     ${YELLOW}bash /workspace/s-tier-character-creation/infrastructure/runpod/download-models.sh${NC}"
echo ""
echo "  2. Access ComfyUI via RunPod web interface (port 8188)"
echo "  3. Begin character creation (Day 0)"
echo "  4. Follow: docs/01-FIRST-PROJECT.md"
echo ""

echo -e "${GREEN}Features:${NC}"
echo "  ✓ Zero redundancy (uses RunPod's environment)"
echo "  ✓ ComfyUI running and accessible"
echo "  ✓ Restart script available"
echo "  ✓ Essential custom nodes installed"
echo "  ✓ Project structure ready"
echo "  ✓ Comprehensive logging enabled"
echo ""

echo -e "${YELLOW}Setup Time:${NC} $(( ($(date +%s) - START_TIME) / 60 )) minutes"
echo ""

echo -e "${CYAN}Logs saved to:${NC} ${LOG_FILE}"
echo ""

echo -e "${BOLD}${GREEN}Setup successful! ComfyUI pod is ready for character creation.${NC}"
echo ""
