#!/bin/bash
# COMFY

UI POD SETUP v3.2.0 - PERMANENT SOLUTION
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
LOG_FILE="$LOG_DIR/comfyui_setup_$(date +%Y%m%d_%H%M%S).log"

log() { echo "  $1" | tee -a "$LOG_FILE"; }
success() { echo -e "${GREEN}✓${NC} $1" | tee -a "$LOG_FILE"; }
error() { echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"; }
progress() { echo -e "${CYAN}  ▸${NC} $1" | tee -a "$LOG_FILE"; }
section() { echo -e "\n${CYAN}${BOLD}━━━ $1 ━━━${NC}\n" | tee -a "$LOG_FILE"; }

# Header
clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════╗
║              COMFYUI POD SETUP v3.2.0                                 ║
║          Professional ComfyUI Installation                            ║
║          Hardware: NVIDIA RTX 3090/4090/5090 (24GB+ VRAM)            ║
║          Architecture: Two-Pod System (Generation Pod)                ║
╚═══════════════════════════════════════════════════════════════════════╝
EOF
echo ""
log "ComfyUI Pod Setup v${SCRIPT_VERSION} started"
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

# Install ComfyUI
section "PHASE 2: ComfyUI Installation"
cd "$WORKSPACE"

if [ ! -d "ComfyUI" ]; then
    progress "Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git
    success "ComfyUI cloned"
fi

cd ComfyUI

# Install dependencies
progress "Installing dependencies..."
/opt/venv/bin/pip install -r requirements.txt --break-system-packages -q
success "Dependencies installed"

# Install custom nodes
progress "Installing essential custom nodes..."
cd custom_nodes
[ ! -d "ComfyUI-Manager" ] && git clone https://github.com/ltdrdata/ComfyUI-Manager.git
success "Custom nodes installed"

# Create permanent environment activation script
section "PHASE 3: Environment Configuration"
cd "$WORKSPACE"

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
cat > start-comfyui.sh << 'START'
#!/bin/bash
# Start ComfyUI

# Activate environment
source /workspace/activate-env.sh

# Start
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188
START
chmod +x start-comfyui.sh
success "Created: /workspace/start-comfyui.sh"

# Create background start script  
cat > start-comfyui-bg.sh << 'STARTBG'
#!/bin/bash
# Start ComfyUI in background

source /workspace/activate-env.sh
cd /workspace/ComfyUI

# Kill existing
pkill -f "python.*main.py" 2>/dev/null
sleep 2

# Start
nohup python main.py --listen 0.0.0.0 --port 8188 > /workspace/logs/comfyui.log 2>&1 &
echo "ComfyUI started (PID: $!)"
echo "Logs: tail -f /workspace/logs/comfyui.log"
STARTBG
chmod +x start-comfyui-bg.sh
success "Created: /workspace/start-comfyui-bg.sh"

# Create directories
mkdir -p logs projects outputs workflows

# Summary
section "Installation Complete"
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ComfyUI Setup Complete ✓                                             ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}IMPORTANT: After EVERY pod restart, run:${NC}"
echo -e "  ${YELLOW}source /workspace/activate-env.sh${NC}"
echo ""
echo -e "${CYAN}Then start ComfyUI:${NC}"
echo -e "  ${YELLOW}bash /workspace/start-comfyui-bg.sh${NC}"
echo ""
echo -e "${CYAN}Or run in foreground:${NC}"
echo -e "  ${YELLOW}bash /workspace/start-comfyui.sh${NC}"
echo ""
echo -e "${CYAN}Access ComfyUI:${NC}"
echo "  Use RunPod web interface → Connect → HTTP  Service [8188]"
echo ""
log "Setup completed in $(( ($(date +%s) - START_TIME) / 60 )) minutes"
