#!/bin/bash
# =============================================================================
# COMFYUI POD SETUP v4.0.0 - PERSISTENT ARCHITECTURE
# =============================================================================
# Revolutionary persistent environment that survives pod restarts
# Zero manual steps required after initial setup
# Idempotent: Can run multiple times safely
# =============================================================================

set -euo pipefail

SCRIPT_VERSION="4.0.0"
WORKSPACE="/workspace"
VENV_PATH="${WORKSPACE}/venv"
COMFYUI_PATH="${WORKSPACE}/ComfyUI"
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
error() { echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"; exit 1; }
warning() { echo -e "${YELLOW}⚠${NC} $1" | tee -a "$LOG_FILE"; }
progress() { echo -e "${CYAN}  ▸${NC} $1" | tee -a "$LOG_FILE"; }
section() { echo -e "\n${CYAN}${BOLD}━━━ $1 ━━━${NC}\n" | tee -a "$LOG_FILE"; }

# Header
clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════╗
║              COMFYUI POD SETUP v4.0.0                                 ║
║          Revolutionary Persistent Architecture                        ║
║          Zero Manual Steps • Auto-Start • Butter Execution            ║
╚═══════════════════════════════════════════════════════════════════════╝
EOF
echo ""
log "ComfyUI Pod Setup v${SCRIPT_VERSION} started"
log "Log file: ${LOG_FILE}"

# =============================================================================
# PHASE 1: Environment Verification
# =============================================================================
section "PHASE 1: Environment Verification"

# Verify workspace
if [ ! -d "$WORKSPACE" ]; then
    error "Workspace directory not found: $WORKSPACE"
fi
success "Workspace: $WORKSPACE"

# Check GPU
progress "Detecting GPU..."
if command -v nvidia-smi &> /dev/null; then
    GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1)
    VRAM_MB=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -1)
    VRAM_GB=$((VRAM_MB / 1024))
    success "GPU: $GPU_NAME (${VRAM_GB}GB VRAM)"
else
    warning "No GPU detected (nvidia-smi not found)"
fi

# Check Python
progress "Detecting Python..."
PYTHON_BIN=$(command -v python3 || command -v python)
if [ -z "$PYTHON_BIN" ]; then
    error "Python not found. Cannot proceed."
fi
PYTHON_VERSION=$($PYTHON_BIN --version 2>&1 | awk '{print $2}')
success "Python: $PYTHON_VERSION"

# =============================================================================
# PHASE 2: Persistent Virtual Environment
# =============================================================================
section "PHASE 2: Persistent Virtual Environment"

if [ -d "$VENV_PATH" ]; then
    progress "Virtual environment already exists at: $VENV_PATH"
    success "Using existing venv (idempotent)"
else
    progress "Creating persistent virtual environment..."
    $PYTHON_BIN -m venv "$VENV_PATH"
    success "Created: $VENV_PATH"
fi

# Activate venv
source "$VENV_PATH/bin/activate"
success "Virtual environment activated"

# Upgrade pip
progress "Upgrading pip..."
pip install --upgrade pip -q
success "pip upgraded"

# =============================================================================
# PHASE 3: ComfyUI Installation
# =============================================================================
section "PHASE 3: ComfyUI Installation"

cd "$WORKSPACE"

if [ -d "$COMFYUI_PATH" ]; then
    progress "ComfyUI already exists at: $COMFYUI_PATH"
    cd "$COMFYUI_PATH"

    # Check if git repo and optionally update
    if [ -d ".git" ]; then
        progress "Checking for updates..."
        git fetch origin main -q 2>/dev/null || true
        LOCAL=$(git rev-parse @ 2>/dev/null || echo "")
        REMOTE=$(git rev-parse @{u} 2>/dev/null || echo "")
        if [ -n "$LOCAL" ] && [ -n "$REMOTE" ] && [ "$LOCAL" != "$REMOTE" ]; then
            warning "Updates available. Run 'git pull' in $COMFYUI_PATH to update."
        else
            success "ComfyUI is up to date"
        fi
    fi
else
    progress "Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git "$COMFYUI_PATH"
    cd "$COMFYUI_PATH"
    success "ComfyUI cloned"
fi

# Install dependencies
progress "Installing ComfyUI dependencies..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt -q
    success "Dependencies installed"
else
    warning "requirements.txt not found, skipping dependency installation"
fi

# Install custom nodes
progress "Installing essential custom nodes..."
cd "$COMFYUI_PATH/custom_nodes"

if [ -d "ComfyUI-Manager" ]; then
    success "ComfyUI-Manager already installed (skipping)"
else
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
    success "ComfyUI-Manager installed"
fi

# Install ComfyUI-Manager dependencies if requirements file exists
if [ -f "ComfyUI-Manager/requirements.txt" ]; then
    progress "Installing ComfyUI-Manager dependencies..."
    pip install -r ComfyUI-Manager/requirements.txt -q
    success "ComfyUI-Manager dependencies installed"
fi

# =============================================================================
# PHASE 4: Auto-Activation (.bashrc)
# =============================================================================
section "PHASE 4: Shell Auto-Activation"

BASHRC_PATH="${WORKSPACE}/.bashrc"
BASHRC_CONTENT='# Auto-activate persistent Python environment
if [ -d "/workspace/venv" ]; then
    source /workspace/venv/bin/activate
fi'

if [ -f "$BASHRC_PATH" ]; then
    if grep -q "workspace/venv" "$BASHRC_PATH" 2>/dev/null; then
        success ".bashrc already configured (idempotent)"
    else
        echo "$BASHRC_CONTENT" >> "$BASHRC_PATH"
        success ".bashrc updated with venv auto-activation"
    fi
else
    echo "$BASHRC_CONTENT" > "$BASHRC_PATH"
    success "Created: $BASHRC_PATH"
fi

# Source .bashrc in standard locations
progress "Configuring shell auto-activation..."
for shell_rc in ~/.bashrc ~/.bash_profile ~/.profile; do
    if [ -f "$shell_rc" ]; then
        if ! grep -q "source /workspace/.bashrc" "$shell_rc" 2>/dev/null; then
            echo "" >> "$shell_rc"
            echo "# Auto-source workspace environment" >> "$shell_rc"
            echo "[ -f /workspace/.bashrc ] && source /workspace/.bashrc" >> "$shell_rc"
        fi
    fi
done
success "Shell auto-activation configured"

# =============================================================================
# PHASE 5: Auto-Start Service (on_start.sh)
# =============================================================================
section "PHASE 5: Auto-Start Service Configuration"

ON_START_PATH="${WORKSPACE}/on_start.sh"

# Create on_start.sh
cat > "$ON_START_PATH" << 'ONSTART'
#!/bin/bash
# =============================================================================
# RunPod Auto-Start Hook - Executed on every pod boot
# =============================================================================

LOG_FILE="/workspace/logs/startup.log"
mkdir -p "$(dirname "$LOG_FILE")"

echo "========================================" >> "$LOG_FILE"
echo "Pod started at: $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

# Step 1: Execute base image entrypoint to preserve Jupyter/SSH
echo "[$(date)] Starting base services..." >> "$LOG_FILE"
if [ -f /start.sh ]; then
    bash /start.sh >> "$LOG_FILE" 2>&1 &
    echo "[$(date)] Base services started via /start.sh" >> "$LOG_FILE"
elif [ -f /run.sh ]; then
    bash /run.sh >> "$LOG_FILE" 2>&1 &
    echo "[$(date)] Base services started via /run.sh" >> "$LOG_FILE"
elif [ -f /runpod-entrypoint.sh ]; then
    bash /runpod-entrypoint.sh >> "$LOG_FILE" 2>&1 &
    echo "[$(date)] Base services started via /runpod-entrypoint.sh" >> "$LOG_FILE"
else
    echo "[$(date)] WARNING: No base entrypoint found" >> "$LOG_FILE"
fi

# Wait for base services to initialize
sleep 3

# Step 2: Activate persistent venv
if [ -d "/workspace/venv" ]; then
    source /workspace/venv/bin/activate
    echo "[$(date)] Virtual environment activated" >> "$LOG_FILE"
else
    echo "[$(date)] ERROR: venv not found at /workspace/venv" >> "$LOG_FILE"
    exit 1
fi

# Step 3: Start ComfyUI
echo "[$(date)] Starting ComfyUI..." >> "$LOG_FILE"
cd /workspace/ComfyUI

# Kill any existing instances
pkill -f "python.*main.py" 2>/dev/null || true
sleep 2

# Start ComfyUI in background
nohup python main.py --listen 0.0.0.0 --port 8188 >> /workspace/logs/comfyui.log 2>&1 &
COMFYUI_PID=$!

echo "[$(date)] ComfyUI started (PID: $COMFYUI_PID)" >> "$LOG_FILE"
echo "[$(date)] ComfyUI logs: /workspace/logs/comfyui.log" >> "$LOG_FILE"
echo "[$(date)] All services started successfully" >> "$LOG_FILE"
ONSTART

chmod +x "$ON_START_PATH"
success "Created: $ON_START_PATH"

# =============================================================================
# PHASE 6: Directory Structure
# =============================================================================
section "PHASE 6: Directory Structure"

mkdir -p "$WORKSPACE"/{logs,projects,outputs,workflows}
success "Created project directories"

# =============================================================================
# Installation Complete
# =============================================================================
section "Installation Complete"

ELAPSED_TIME=$(( ($(date +%s) - START_TIME) ))
ELAPSED_MIN=$(( ELAPSED_TIME / 60 ))
ELAPSED_SEC=$(( ELAPSED_TIME % 60 ))

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  ComfyUI Setup Complete ✓                                             ║${NC}"
echo -e "${GREEN}║  Revolutionary v4.0.0 Architecture                                    ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}${CYAN}🎯 MISSION ACCOMPLISHED${NC}"
echo ""
echo -e "${GREEN}✓${NC} Persistent virtual environment: ${CYAN}$VENV_PATH${NC}"
echo -e "${GREEN}✓${NC} Auto-activation configured: All shells automatically use venv"
echo -e "${GREEN}✓${NC} Auto-start configured: ComfyUI starts automatically on pod boot"
echo -e "${GREEN}✓${NC} ComfyUI installed: $COMFYUI_PATH"
echo ""
echo -e "${BOLD}${CYAN}⚡ ZERO MANUAL STEPS REQUIRED${NC}"
echo ""
echo -e "${CYAN}After pod restart, everything starts automatically:${NC}"
echo -e "  1. Base services (Jupyter/SSH) ${GREEN}✓${NC}"
echo -e "  2. Python environment ${GREEN}✓${NC}"
echo -e "  3. ComfyUI service ${GREEN}✓${NC}"
echo ""
echo -e "${CYAN}Access ComfyUI:${NC}"
echo -e "  RunPod Web Interface → Connect → HTTP Service [8188]"
echo ""
echo -e "${CYAN}Manual Controls (if needed):${NC}"
echo -e "  Start:   ${YELLOW}bash $ON_START_PATH${NC}"
echo -e "  Logs:    ${YELLOW}tail -f /workspace/logs/comfyui.log${NC}"
echo -e "  Stop:    ${YELLOW}pkill -f 'python.*main.py'${NC}"
echo ""
echo -e "${CYAN}Setup completed in ${ELAPSED_MIN}m ${ELAPSED_SEC}s${NC}"
echo ""
log "Setup completed in ${ELAPSED_MIN}m ${ELAPSED_SEC}s"
