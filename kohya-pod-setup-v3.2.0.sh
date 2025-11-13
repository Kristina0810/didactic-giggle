#!/bin/bash
# KOHYA TRAINING POD SETUP v3.2.0 - PERMANENT SOLUTION
# Simplified, robust, production-ready

set -euo pipefail

SCRIPT_VERSION="3.2.0"
WORKSPACE="/workspace"
START_TIME=$(date +%s)

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

# Logging
LOG_DIR="$WORKSPACE/logs/setup"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/kohya_setup_$(date +%Y%m%d_%H%M%S).log"

log() { echo "  $1" | tee -a "$LOG_FILE"; }
success() { echo -e "${GREEN}✓${NC} $1" | tee -a "$LOG_FILE"; }
error() { echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"; }
progress() { echo -e "${CYAN}  ▸${NC} $1" | tee -a "$LOG_FILE"; }
section() { echo -e "\n${CYAN}${BOLD}━━━ $1 ━━━${NC}\n" | tee -a "$LOG_FILE"; }

# Header
clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════╗
║              KOHYA TRAINING POD SETUP v3.2.0                          ║
║          Professional LoRA Training Environment                       ║
║          Hardware: NVIDIA RTX 3090/4090/5090 (24GB+ VRAM)            ║
║          Architecture: Two-Pod System (Training Pod)                  ║
╚═══════════════════════════════════════════════════════════════════════╝
EOF
echo ""
log "Kohya Training Pod Setup v${SCRIPT_VERSION} started"
log "Log file: ${LOG_FILE}"

# Environment check
section "PHASE 1: Environment Verification"
progress "Detecting GPU..."
if command -v nvidia-smi &> /dev/null; then
    GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1)
    VRAM_MB=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -1)
    VRAM_GB=$((VRAM_MB / 1024))
    success "GPU: $GPU_NAME"
    success "VRAM: ${VRAM_GB}GB"
fi

# Install Kohya
section "PHASE 2: Kohya_ss Installation"
cd "$WORKSPACE"

if [ ! -d "kohya_ss" ]; then
    progress "Cloning Kohya_ss..."
    git clone https://github.com/bmaltais/kohya_ss.git
    cd kohya_ss
    git submodule update --init --recursive
    success "Kohya_ss cloned"
fi

cd "$WORKSPACE/kohya_ss"

# Install dependencies
progress "Installing training dependencies..."
/opt/venv/bin/pip install --break-system-packages -q \
    accelerate transformers diffusers bitsandbytes tensorboard \
    toml omegaconf easygui gradio

success "Dependencies installed"

# Create training structure
section "PHASE 3: Training Structure"
cd "$WORKSPACE"
mkdir -p training/{datasets,configs,outputs,logs}
success "Training directories created"

# Create permanent environment activation script
section "PHASE 4: Environment Configuration"

cat > activate-env.sh << 'ACTIVATE'
#!/bin/bash
# Activate Python environment - source this in all terminals
if [ -d "/opt/venv" ]; then
    source /opt/venv/bin/activate
elif [ -d "/venv" ]; then
    source /venv/bin/activate
fi
ACTIVATE
chmod +x activate-env.sh
success "Created: /workspace/activate-env.sh"

# Create start script
cat > start-kohya.sh << 'START'
#!/bin/bash
# Start Kohya_ss Web UI

# Activate environment
source /workspace/activate-env.sh

# Start
cd /workspace/kohya_ss
python kohya_gui.py --listen 0.0.0.0 --server_port 7860 --headless
START
chmod +x start-kohya.sh
success "Created: /workspace/start-kohya.sh"

# Summary
section "Installation Complete"
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Kohya Training Pod Setup Complete ✓                                  ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}IMPORTANT: After EVERY pod restart, run:${NC}"
echo -e "  ${YELLOW}source /workspace/activate-env.sh${NC}"
echo ""
echo -e "${CYAN}Then start Kohya:${NC}"
echo -e "  ${YELLOW}bash /workspace/start-kohya.sh${NC}"
echo ""
echo -e "${CYAN}Access Kohya:${NC}"
echo "  Use RunPod web interface → Connect → HTTP Service [7860]"
echo ""
log "Setup completed in $(( ($(date +%s) - START_TIME) / 60 )) minutes"
