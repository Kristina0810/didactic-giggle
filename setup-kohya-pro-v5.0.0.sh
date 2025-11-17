#!/bin/bash

################################################################################
# Kohya_ss Professional Setup Script v5.0.0
#
# Purpose: One-click, zero-compromise Kohya_ss installation for LoRA training
#          with world-class output and user-friendly reliability
#
# Features:
# - PyTorch 2.1 pinning (stable for training)
# - Error handling with retry logic
# - Idempotent (safe to re-run)
# - Auto-start configuration (on_start.sh + cron)
# - Training directory structure
# - Sample configuration files
# - Progress indicators and logging
# - Health checks
#
# Target: RunPod PyTorch 2.1 template (GPU pre-configured)
# Storage: /workspace (persistent)
#
# Author: Orion (CTO)
# Company: Karman Global LLC
# Date: 2024-11-17
################################################################################

set -euo pipefail  # Exit on error, undefined vars, pipe failures

################################################################################
# CONFIGURATION
################################################################################

WORKSPACE="/workspace"
KOHYA_DIR="${WORKSPACE}/kohya_ss"
LOG_DIR="${WORKSPACE}/logs"
LOG_FILE="${LOG_DIR}/kohya-setup-$(date +%Y%m%d-%H%M%S).log"
PID_FILE="${WORKSPACE}/kohya.pid"
VENV_PATH="${KOHYA_DIR}/venv"

# PyTorch version pinning (2.1.x stable for training)
PYTORCH_VERSION="2.1.2"
CUDA_VERSION="cu118"  # CUDA 11.8 compatible

# Detect Python command (python3 or python)
if command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD="python3"
elif command -v python >/dev/null 2>&1; then
    PYTHON_CMD="python"
else
    PYTHON_CMD=""
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

################################################################################
# LOGGING FUNCTIONS
################################################################################

setup_logging() {
    mkdir -p "$LOG_DIR"
    exec 1> >(tee -a "$LOG_FILE")
    exec 2>&1
    log_info "Kohya_ss Professional Setup v5.0.0 - Started"
    log_info "Log file: $LOG_FILE"
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

################################################################################
# UTILITY FUNCTIONS
################################################################################

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_prerequisites() {
    log_info "Checking prerequisites..."

    if [ -z "$PYTHON_CMD" ]; then
        log_error "Python not found. This script requires Python 3.10+"
        log_error "Please install Python 3.10+ and try again."
        exit 1
    fi

    if ! command_exists git; then
        log_warning "Git not found. Installing git..."
        apt-get update && apt-get install -y git
    fi

    if ! command_exists wget; then
        log_warning "wget not found. Installing wget..."
        apt-get update && apt-get install -y wget
    fi

    local python_version=$($PYTHON_CMD --version 2>&1 | awk '{print $2}')
    log_success "Python: $PYTHON_CMD (version $python_version)"

    # Check for CUDA availability
    if command_exists nvidia-smi; then
        log_success "NVIDIA GPU detected"
        nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader | head -1
    else
        log_warning "No NVIDIA GPU detected (CPU training will be slow)"
    fi
}

retry_command() {
    local max_attempts="$1"
    shift
    local cmd=("$@")
    local attempt=1

    while [ $attempt -le $max_attempts ]; do
        if "${cmd[@]}"; then
            return 0
        fi

        log_warning "Command failed (attempt $attempt/$max_attempts). Retrying in $((2**attempt)) seconds..."
        sleep $((2**attempt))
        attempt=$((attempt + 1))
    done

    log_error "Command failed after $max_attempts attempts: ${cmd[*]}"
    return 1
}

################################################################################
# KOHYA_SS INSTALLATION
################################################################################

clone_kohya() {
    log_info "Cloning Kohya_ss repository..."

    if [ -d "$KOHYA_DIR" ]; then
        log_info "Kohya_ss directory already exists (skipping clone)"
        cd "$KOHYA_DIR"
        log_info "Updating repository..."
        git pull || log_warning "Could not update repository (using existing version)"
        return 0
    fi

    cd "$WORKSPACE"
    if retry_command 3 git clone --recursive https://github.com/bmaltais/kohya_ss.git; then
        log_success "Kohya_ss cloned successfully"
        return 0
    else
        log_error "Failed to clone Kohya_ss"
        return 1
    fi
}

setup_virtual_environment() {
    log_info "Setting up virtual environment with PyTorch ${PYTORCH_VERSION}..."

    cd "$KOHYA_DIR"

    # Create venv if it doesn't exist
    if [ ! -d "$VENV_PATH" ]; then
        log_info "Creating virtual environment..."
        $PYTHON_CMD -m venv "$VENV_PATH"
        log_success "Virtual environment created"
    else
        log_info "Virtual environment already exists (skipping creation)"
    fi

    # Activate venv
    source "${VENV_PATH}/bin/activate"
    log_success "Virtual environment activated"

    # Upgrade pip
    log_info "Upgrading pip..."
    python3 -m pip install --upgrade pip setuptools wheel

    # Check if PyTorch is already installed with correct version
    if python3 -c "import torch; print(torch.__version__)" 2>/dev/null | grep -q "^${PYTORCH_VERSION}"; then
        log_success "PyTorch ${PYTORCH_VERSION} already installed (skipping)"
    else
        log_info "Installing PyTorch ${PYTORCH_VERSION} with CUDA ${CUDA_VERSION}..."

        # Install PyTorch 2.1.2 with CUDA 11.8
        retry_command 3 python3 -m pip install \
            torch==${PYTORCH_VERSION}+${CUDA_VERSION} \
            torchvision==0.16.2+${CUDA_VERSION} \
            torchaudio==${PYTORCH_VERSION}+${CUDA_VERSION} \
            --index-url https://download.pytorch.org/whl/${CUDA_VERSION}

        log_success "PyTorch ${PYTORCH_VERSION} installed"
    fi

    # Verify PyTorch installation
    local torch_version=$(python3 -c "import torch; print(torch.__version__)" 2>/dev/null || echo "NOT INSTALLED")
    local cuda_available=$(python3 -c "import torch; print(torch.cuda.is_available())" 2>/dev/null || echo "False")

    log_info "PyTorch version: $torch_version"
    log_info "CUDA available: $cuda_available"

    if [ "$cuda_available" = "True" ]; then
        local cuda_version=$(python3 -c "import torch; print(torch.version.cuda)" 2>/dev/null)
        log_success "CUDA version: $cuda_version"
    else
        log_warning "CUDA not available - training will be CPU-only (slow)"
    fi
}

install_kohya_dependencies() {
    log_info "Installing Kohya_ss dependencies..."

    cd "$KOHYA_DIR"
    source "${VENV_PATH}/bin/activate"

    # Check if requirements.txt exists
    if [ ! -f "requirements.txt" ]; then
        log_error "requirements.txt not found in Kohya_ss directory"
        return 1
    fi

    # Install requirements with retry logic
    log_info "Installing requirements.txt (this may take several minutes)..."
    if retry_command 3 python3 -m pip install -r requirements.txt; then
        log_success "Requirements installed successfully"
    else
        log_error "Failed to install requirements"
        return 1
    fi

    # Install additional dependencies for stability
    log_info "Installing additional stability dependencies..."
    retry_command 3 python3 -m pip install \
        xformers==0.0.23.post1 \
        bitsandbytes==0.41.1 \
        lion-pytorch==0.1.2 \
        lycoris-lora==1.8.3 \
        prodigyopt==1.0 \
        scipy \
        tensorboard

    log_success "All dependencies installed"
}

run_setup_script() {
    log_info "Running Kohya_ss setup script..."

    cd "$KOHYA_DIR"

    # Check if setup-runpod.sh exists
    if [ -f "setup-runpod.sh" ]; then
        log_info "Found setup-runpod.sh, executing..."
        chmod +x setup-runpod.sh

        # Run setup script (may fail if already configured, non-fatal)
        if ./setup-runpod.sh; then
            log_success "Setup script completed successfully"
        else
            log_warning "Setup script returned non-zero exit (may be already configured)"
        fi
    else
        log_info "setup-runpod.sh not found (using manual setup)"
    fi
}

################################################################################
# DIRECTORY STRUCTURE
################################################################################

create_training_structure() {
    log_info "Creating training directory structure..."

    local dirs=(
        "${WORKSPACE}/training/datasets/raw"
        "${WORKSPACE}/training/datasets/processed"
        "${WORKSPACE}/training/datasets/prepared"
        "${WORKSPACE}/training/configs"
        "${WORKSPACE}/training/outputs/lora"
        "${WORKSPACE}/training/outputs/checkpoints"
        "${WORKSPACE}/training/outputs/samples"
        "${WORKSPACE}/training/logs"
        "${LOG_DIR}"
    )

    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        log_info "Created: $dir"
    done

    log_success "Training directory structure created"
}

create_sample_config() {
    log_info "Creating sample training configuration..."

    local config_file="${WORKSPACE}/training/configs/sample-lora-config.toml"

    if [ -f "$config_file" ]; then
        log_info "Sample config already exists (skipping)"
        return 0
    fi

    cat > "$config_file" << 'EOF'
# Kohya_ss LoRA Training Configuration - Sample
# Edit this file for your specific character training needs

[model]
pretrained_model_name_or_path = "/workspace/ComfyUI/models/checkpoints/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors"
vae = "/workspace/ComfyUI/models/vae/sdxl_vae.safetensors"
v2 = false
v_parameterization = false

[dataset]
# Point to your prepared dataset (50-100 images recommended)
train_data_dir = "/workspace/training/datasets/prepared/character-001"
resolution = "1024,1024"
batch_size = 1
enable_bucket = true
min_bucket_reso = 512
max_bucket_reso = 2048
bucket_reso_steps = 64

[training]
# Training parameters optimized for character consistency
output_dir = "/workspace/training/outputs/lora"
output_name = "character-001-lora"
save_model_as = "safetensors"

max_train_epochs = 10
save_every_n_epochs = 2

learning_rate = 1e-4
lr_scheduler = "cosine"
lr_warmup_steps = 100

optimizer_type = "AdamW8bit"
mixed_precision = "fp16"
save_precision = "fp16"

# LoRA specific settings
network_module = "networks.lora"
network_dim = 32
network_alpha = 16

# Memory optimization
gradient_checkpointing = true
gradient_accumulation_steps = 1
max_grad_norm = 1.0

# Logging
logging_dir = "/workspace/training/logs"
log_prefix = "character-001"

[sample]
# Generate sample images during training
sample_every_n_epochs = 2
sample_prompts = "/workspace/training/configs/sample-prompts.txt"
sample_sampler = "euler_a"
EOF

    log_success "Sample config created: $config_file"

    # Create sample prompts file
    local prompts_file="${WORKSPACE}/training/configs/sample-prompts.txt"
    cat > "$prompts_file" << 'EOF'
# Sample prompts for training validation
# Each line generates one image per checkpoint

photo of a woman, professional photography, high quality, detailed face --n low quality, blurry
portrait of a woman, elegant, luxury setting, professional lighting --n amateur, low quality
woman smiling, candid photo, natural lighting, high resolution --n distorted, blurry
EOF

    log_success "Sample prompts created: $prompts_file"
}

################################################################################
# AUTO-START CONFIGURATION
################################################################################

setup_auto_start() {
    log_info "Configuring auto-start for Kohya_ss..."

    local on_start_file="${WORKSPACE}/on_start.sh"

    # Check if on_start.sh already has Kohya entry
    if [ -f "$on_start_file" ] && grep -q "Kohya" "$on_start_file" 2>/dev/null; then
        log_info "Auto-start already configured (skipping)"
        return 0
    fi

    # Create or append to on_start.sh
    cat >> "$on_start_file" << 'EOF'

# Kohya_ss Auto-Start (v5.0.0)
if [ -d "/workspace/kohya_ss" ]; then
    echo "[$(date)] Starting Kohya_ss..."
    cd /workspace/kohya_ss

    # Kill existing process if running
    if [ -f "/workspace/kohya.pid" ]; then
        OLD_PID=$(cat /workspace/kohya.pid)
        if ps -p $OLD_PID > /dev/null 2>&1; then
            echo "[$(date)] Stopping existing Kohya_ss (PID: $OLD_PID)..."
            kill $OLD_PID 2>/dev/null || true
            sleep 2
        fi
    fi

    # Activate venv and start GUI
    source /workspace/kohya_ss/venv/bin/activate
    nohup python3 gui.py --listen 0.0.0.0 --server_port 7860 > /workspace/logs/kohya.log 2>&1 &
    echo $! > /workspace/kohya.pid
    echo "[$(date)] Kohya_ss started (PID: $(cat /workspace/kohya.pid))"
fi
EOF

    chmod +x "$on_start_file"
    log_success "Auto-start configured: $on_start_file"

    # Also add cron @reboot as fallback
    local cron_entry="@reboot cd ${KOHYA_DIR} && source ${VENV_PATH}/bin/activate && nohup python3 gui.py --listen 0.0.0.0 --server_port 7860 > ${LOG_DIR}/kohya.log 2>&1 &"

    if ! crontab -l 2>/dev/null | grep -q "kohya"; then
        (crontab -l 2>/dev/null; echo "$cron_entry") | crontab -
        log_success "Cron @reboot fallback configured"
    fi
}

create_activation_script() {
    log_info "Creating venv activation helper script..."

    local activate_script="${WORKSPACE}/activate-kohya.sh"

    cat > "$activate_script" << 'EOF'
#!/bin/bash
# Quick activation script for Kohya_ss virtual environment

if [ -d "/workspace/kohya_ss/venv" ]; then
    source /workspace/kohya_ss/venv/bin/activate
    echo "Kohya_ss virtual environment activated"
    echo "PyTorch version: $(python3 -c 'import torch; print(torch.__version__)')"
    echo "CUDA available: $(python3 -c 'import torch; print(torch.cuda.is_available())')"
    echo ""
    echo "To start Kohya GUI: cd /workspace/kohya_ss && python3 gui.py"
else
    echo "Error: Kohya_ss virtual environment not found"
    exit 1
fi
EOF

    chmod +x "$activate_script"
    log_success "Activation script created: $activate_script"
}

################################################################################
# HEALTH CHECKS
################################################################################

run_health_checks() {
    log_info "Running health checks..."

    local checks_passed=0
    local checks_total=6

    # Check 1: Kohya directory
    if [ -d "$KOHYA_DIR" ]; then
        log_success "✓ Kohya_ss directory exists"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ Kohya_ss directory missing"
    fi

    # Check 2: Virtual environment
    if [ -d "$VENV_PATH" ]; then
        log_success "✓ Virtual environment exists"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ Virtual environment missing"
    fi

    # Check 3: PyTorch installation
    source "${VENV_PATH}/bin/activate" 2>/dev/null || true
    if python3 -c "import torch" 2>/dev/null; then
        local torch_ver=$(python3 -c "import torch; print(torch.__version__)")
        log_success "✓ PyTorch installed: $torch_ver"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ PyTorch not installed"
    fi

    # Check 4: CUDA availability
    if python3 -c "import torch; print(torch.cuda.is_available())" 2>/dev/null | grep -q "True"; then
        log_success "✓ CUDA available"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ CUDA not available (CPU mode)"
    fi

    # Check 5: Training directories
    if [ -d "${WORKSPACE}/training" ]; then
        log_success "✓ Training directories exist"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ Training directories missing"
    fi

    # Check 6: Auto-start configuration
    if [ -f "${WORKSPACE}/on_start.sh" ] && grep -q "Kohya" "${WORKSPACE}/on_start.sh"; then
        log_success "✓ Auto-start configured"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ Auto-start not configured"
    fi

    log_info "Health checks: $checks_passed/$checks_total passed"

    if [ $checks_passed -ge 5 ]; then
        log_success "System health: EXCELLENT"
        return 0
    elif [ $checks_passed -ge 4 ]; then
        log_warning "System health: GOOD (minor issues)"
        return 0
    else
        log_error "System health: NEEDS ATTENTION"
        return 1
    fi
}

################################################################################
# MAIN INSTALLATION FLOW
################################################################################

main() {
    echo ""
    echo "════════════════════════════════════════════════════════════════"
    echo "  Kohya_ss Professional Setup v5.0.0"
    echo "  PyTorch ${PYTORCH_VERSION} + World-Class Training Environment"
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    setup_logging
    check_prerequisites

    clone_kohya
    setup_virtual_environment
    install_kohya_dependencies
    run_setup_script
    create_training_structure
    create_sample_config
    setup_auto_start
    create_activation_script

    echo ""
    echo "════════════════════════════════════════════════════════════════"
    run_health_checks
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    log_success "Kohya_ss setup completed successfully!"
    log_info "Next steps:"
    log_info "  1. Prepare your character dataset (50-100 images)"
    log_info "  2. Start Kohya GUI: cd ${KOHYA_DIR} && source venv/bin/activate && python3 gui.py"
    log_info "  3. Or restart pod (auto-start configured)"
    log_info ""
    log_info "Access Kohya_ss at: http://localhost:7860"
    log_info "Training directory: ${WORKSPACE}/training"
    log_info "Sample config: ${WORKSPACE}/training/configs/sample-lora-config.toml"
    log_info "Log file: $LOG_FILE"
    log_info ""
    log_info "Quick venv activation: source ${WORKSPACE}/activate-kohya.sh"
}

# Run main installation
main "$@"
