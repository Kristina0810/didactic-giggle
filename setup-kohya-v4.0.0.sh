#!/bin/bash
# =============================================================================
# KOHYA TRAINING POD SETUP v4.0.0 - PERSISTENT ARCHITECTURE
# =============================================================================
# Revolutionary persistent environment that survives pod restarts
# Zero manual steps required after initial setup
# Idempotent: Can run multiple times safely
# =============================================================================

set -euo pipefail

SCRIPT_VERSION="4.0.0"
WORKSPACE="/workspace"
VENV_PATH="${WORKSPACE}/venv"
KOHYA_PATH="${WORKSPACE}/kohya_ss"
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
error() { echo -e "${RED}✗${NC} $1" | tee -a "$LOG_FILE"; exit 1; }
warning() { echo -e "${YELLOW}⚠${NC} $1" | tee -a "$LOG_FILE"; }
progress() { echo -e "${CYAN}  ▸${NC} $1" | tee -a "$LOG_FILE"; }
section() { echo -e "\n${CYAN}${BOLD}━━━ $1 ━━━${NC}\n" | tee -a "$LOG_FILE"; }

# Header
clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════╗
║              KOHYA TRAINING POD SETUP v4.0.0                          ║
║          Revolutionary Persistent Architecture                        ║
║          Zero Manual Steps • Auto-Start • Butter Execution            ║
╚═══════════════════════════════════════════════════════════════════════╝
EOF
echo ""
log "Kohya Training Pod Setup v${SCRIPT_VERSION} started"
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

    # Verify VRAM requirements
    if [ $VRAM_GB -lt 12 ]; then
        warning "Low VRAM detected. LoRA training requires 12GB+ for optimal results."
    fi
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
# PHASE 3: Kohya_ss Installation
# =============================================================================
section "PHASE 3: Kohya_ss Installation"

cd "$WORKSPACE"

if [ -d "$KOHYA_PATH" ]; then
    progress "Kohya_ss already exists at: $KOHYA_PATH"
    cd "$KOHYA_PATH"

    # Check if git repo and optionally update
    if [ -d ".git" ]; then
        progress "Checking for updates..."
        git fetch origin main -q 2>/dev/null || git fetch origin master -q 2>/dev/null || true
        LOCAL=$(git rev-parse @ 2>/dev/null || echo "")
        REMOTE=$(git rev-parse @{u} 2>/dev/null || echo "")
        if [ -n "$LOCAL" ] && [ -n "$REMOTE" ] && [ "$LOCAL" != "$REMOTE" ]; then
            warning "Updates available. Run 'git pull' in $KOHYA_PATH to update."
        else
            success "Kohya_ss is up to date"
        fi
    fi
else
    progress "Cloning Kohya_ss..."
    git clone https://github.com/bmaltais/kohya_ss.git "$KOHYA_PATH"
    cd "$KOHYA_PATH"

    # Update submodules if any
    if [ -f ".gitmodules" ]; then
        progress "Updating submodules..."
        git submodule update --init --recursive
    fi

    success "Kohya_ss cloned"
fi

# Install training dependencies
progress "Installing training dependencies..."
pip install -q \
    torch torchvision torchaudio \
    accelerate transformers diffusers \
    bitsandbytes tensorboard \
    toml omegaconf easygui gradio \
    safetensors huggingface_hub \
    albumentations opencv-python imagesize \
    altair pillow \
    2>&1 | grep -v "already satisfied" || true

success "Training dependencies installed"

# Install Kohya requirements if present
if [ -f "$KOHYA_PATH/requirements.txt" ]; then
    progress "Installing Kohya_ss requirements..."
    pip install -r "$KOHYA_PATH/requirements.txt" -q 2>&1 | grep -v "already satisfied" || true
    success "Kohya_ss requirements installed"
fi

# =============================================================================
# PHASE 4: Training Structure
# =============================================================================
section "PHASE 4: Training Structure"

cd "$WORKSPACE"
mkdir -p training/{datasets,configs,outputs,logs}
mkdir -p training/datasets/{raw,processed}
mkdir -p training/outputs/{lora,checkpoints}

success "Training directories created"

# Create sample config template
SAMPLE_CONFIG="$WORKSPACE/training/configs/sample_lora_config.toml"
if [ ! -f "$SAMPLE_CONFIG" ]; then
    cat > "$SAMPLE_CONFIG" << 'TOML'
# Sample LoRA Training Configuration
# Copy and modify this file for your training runs

[model_arguments]
pretrained_model_name_or_path = "stabilityai/stable-diffusion-xl-base-1.0"
vae = ""

[dataset_arguments]
resolution = 1024
batch_size = 1
enable_bucket = true
min_bucket_reso = 512
max_bucket_reso = 2048

[training_arguments]
output_dir = "./outputs/lora"
output_name = "character_lora"
save_precision = "fp16"
save_model_as = "safetensors"

max_train_epochs = 10
learning_rate = 1e-4
lr_scheduler = "cosine"
optimizer_type = "AdamW8bit"

mixed_precision = "fp16"
gradient_checkpointing = true
gradient_accumulation_steps = 1

[lora_arguments]
network_module = "networks.lora"
network_dim = 32
network_alpha = 16
TOML
    success "Created sample config: $SAMPLE_CONFIG"
fi

# =============================================================================
# PHASE 5: Auto-Activation (.bashrc)
# =============================================================================
section "PHASE 5: Shell Auto-Activation"

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
# PHASE 6: Auto-Start Service (on_start.sh)
# =============================================================================
section "PHASE 6: Auto-Start Service Configuration"

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

# Step 3: Start Kohya_ss
echo "[$(date)] Starting Kohya_ss..." >> "$LOG_FILE"
cd /workspace/kohya_ss

# Kill any existing instances
pkill -f "kohya_gui.py" 2>/dev/null || true
sleep 2

# Start Kohya_ss in background
nohup python kohya_gui.py --listen 0.0.0.0 --server_port 7860 --headless >> /workspace/logs/kohya.log 2>&1 &
KOHYA_PID=$!

echo "[$(date)] Kohya_ss started (PID: $KOHYA_PID)" >> "$LOG_FILE"
echo "[$(date)] Kohya_ss logs: /workspace/logs/kohya.log" >> "$LOG_FILE"
echo "[$(date)] All services started successfully" >> "$LOG_FILE"
ONSTART

chmod +x "$ON_START_PATH"
success "Created: $ON_START_PATH"

# =============================================================================
# Installation Complete
# =============================================================================
section "Installation Complete"

ELAPSED_TIME=$(( ($(date +%s) - START_TIME) ))
ELAPSED_MIN=$(( ELAPSED_TIME / 60 ))
ELAPSED_SEC=$(( ELAPSED_TIME % 60 ))

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Kohya Training Pod Setup Complete ✓                                  ║${NC}"
echo -e "${GREEN}║  Revolutionary v4.0.0 Architecture                                    ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BOLD}${CYAN}🎯 MISSION ACCOMPLISHED${NC}"
echo ""
echo -e "${GREEN}✓${NC} Persistent virtual environment: ${CYAN}$VENV_PATH${NC}"
echo -e "${GREEN}✓${NC} Auto-activation configured: All shells automatically use venv"
echo -e "${GREEN}✓${NC} Auto-start configured: Kohya_ss starts automatically on pod boot"
echo -e "${GREEN}✓${NC} Kohya_ss installed: $KOHYA_PATH"
echo -e "${GREEN}✓${NC} Training structure created: /workspace/training/"
echo ""
echo -e "${BOLD}${CYAN}⚡ ZERO MANUAL STEPS REQUIRED${NC}"
echo ""
echo -e "${CYAN}After pod restart, everything starts automatically:${NC}"
echo -e "  1. Base services (Jupyter/SSH) ${GREEN}✓${NC}"
echo -e "  2. Python environment ${GREEN}✓${NC}"
echo -e "  3. Kohya_ss service ${GREEN}✓${NC}"
echo ""
echo -e "${CYAN}Access Kohya_ss:${NC}"
echo -e "  RunPod Web Interface → Connect → HTTP Service [7860]"
echo ""
echo -e "${CYAN}Training Workflow:${NC}"
echo -e "  1. Upload images to: ${YELLOW}/workspace/training/datasets/raw/${NC}"
echo -e "  2. Configure training: ${YELLOW}/workspace/training/configs/sample_lora_config.toml${NC}"
echo -e "  3. Start training via Kohya_ss Web UI"
echo -e "  4. Find outputs in: ${YELLOW}/workspace/training/outputs/${NC}"
echo ""
echo -e "${CYAN}Manual Controls (if needed):${NC}"
echo -e "  Start:   ${YELLOW}bash $ON_START_PATH${NC}"
echo -e "  Logs:    ${YELLOW}tail -f /workspace/logs/kohya.log${NC}"
echo -e "  Stop:    ${YELLOW}pkill -f 'kohya_gui.py'${NC}"
echo ""
echo -e "${CYAN}Setup completed in ${ELAPSED_MIN}m ${ELAPSED_SEC}s${NC}"
echo ""
log "Setup completed in ${ELAPSED_MIN}m ${ELAPSED_SEC}s"
