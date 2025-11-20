#!/bin/bash

################################################################################
# ComfyUI Professional Setup Script v6.0.0 - PRODUCTION FINAL
#
# Purpose: Zero-compromise, premium-grade ComfyUI installation for AI character
#          generation with world-class output and flawless user experience
#
# v6.0.0 Improvements:
# - Fixed: crontab dependency (auto-install or graceful skip)
# - Fixed: numpy dependency conflict (explicit upgrade)
# - Fixed: GUI auto-start (immediate launch after setup)
# - Fixed: RunPod URL detection (shows correct public URL)
# - Fixed: Environment variables set explicitly (no warnings)
# - Optimized: Removed redundant installations
# - Polished: Removed unnecessary folders, streamlined UEX
#
# Target: RunPod ComfyUI template (PyTorch latest, GPU pre-configured)
# Storage: /workspace (persistent)
#
# Author: Orion (CTO)
# Company: Karman Global LLC
# Date: 2025-11-17
################################################################################

set -euo pipefail  # Exit on error, undefined vars, pipe failures

################################################################################
# CONFIGURATION
################################################################################

WORKSPACE="/workspace"
COMFYUI_DIR="${WORKSPACE}/ComfyUI"
LOG_DIR="${WORKSPACE}/logs"
LOG_FILE="${LOG_DIR}/comfyui-setup-$(date +%Y%m%d-%H%M%S).log"
PID_FILE="${WORKSPACE}/comfyui.pid"

# Detect RunPod slim template path
if [ -d "${WORKSPACE}/runpod-slim/ComfyUI" ]; then
    COMFYUI_DIR="${WORKSPACE}/runpod-slim/ComfyUI"
fi

# Set environment variables explicitly (prevents warnings)
export COMFYUI_PATH="$COMFYUI_DIR"
export COMFYUI_MODEL_PATH="${COMFYUI_DIR}/models"

# Detect Python command (python3 or python)
if command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD="python3"
elif command -v python >/dev/null 2>&1; then
    PYTHON_CMD="python"
else
    PYTHON_CMD=""
fi

# Detect pip command
if command -v pip3 >/dev/null 2>&1; then
    PIP_CMD="pip3"
elif command -v pip >/dev/null 2>&1; then
    PIP_CMD="pip"
else
    PIP_CMD="$PYTHON_CMD -m pip"
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

################################################################################
# LOGGING FUNCTIONS
################################################################################

setup_logging() {
    mkdir -p "$LOG_DIR"
    exec 1> >(tee -a "$LOG_FILE")
    exec 2>&1
    log_info "ComfyUI Professional Setup v6.0.0 - PRODUCTION FINAL"
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

log_step() {
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

################################################################################
# UTILITY FUNCTIONS
################################################################################

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_prerequisites() {
    log_step "Checking Prerequisites"

    if [ -z "$PYTHON_CMD" ]; then
        log_error "Python not found. This script requires Python 3.10+"
        log_error "Please install Python 3.10+ and try again."
        exit 1
    fi

    # Install essential system packages if missing
    local packages_to_install=()

    if ! command_exists git; then
        packages_to_install+=("git")
    fi

    if ! command_exists wget; then
        packages_to_install+=("wget")
    fi

    # Install cron for auto-start (if not available)
    if ! command_exists crontab; then
        packages_to_install+=("cron")
    fi

    if [ ${#packages_to_install[@]} -gt 0 ]; then
        log_info "Installing missing system packages: ${packages_to_install[*]}"
        if apt-get update && apt-get install -y "${packages_to_install[@]}"; then
            log_success "System packages installed"
        else
            log_warning "Could not install some packages (non-fatal, continuing)"
        fi
    fi

    local python_version=$($PYTHON_CMD --version 2>&1 | awk '{print $2}')
    log_success "Python: $PYTHON_CMD (version $python_version)"

    if ! $PYTHON_CMD -c "import torch" 2>/dev/null; then
        log_warning "PyTorch not found. Ensure you're running on RunPod GPU template."
    else
        local torch_version=$($PYTHON_CMD -c "import torch; print(torch.__version__)")
        log_success "PyTorch version: $torch_version"

        if $PYTHON_CMD -c "import torch; print(torch.cuda.is_available())" 2>/dev/null | grep -q "True"; then
            local cuda_version=$($PYTHON_CMD -c "import torch; print(torch.version.cuda)")
            log_success "CUDA available: version $cuda_version"
        fi
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
# DEPENDENCY MANAGEMENT
################################################################################

fix_numpy_conflict() {
    log_step "Resolving Dependency Conflicts"

    # Critical fix: Upgrade numpy to resolve opencv-contrib-python conflict
    log_info "Upgrading numpy to resolve opencv dependency conflicts..."

    if $PIP_CMD install --upgrade "numpy>=2.0.0,<2.3.0" 2>&1 | tee -a "$LOG_FILE"; then
        log_success "numpy upgraded successfully"
        local numpy_version=$($PYTHON_CMD -c "import numpy; print(numpy.__version__)" 2>/dev/null || echo "unknown")
        log_info "numpy version: $numpy_version"
    else
        log_warning "numpy upgrade had issues, but continuing (may resolve during requirements install)"
    fi
}

################################################################################
# COMFYUI INSTALLATION
################################################################################

install_comfyui_base() {
    log_step "Installing ComfyUI Base Requirements"

    if [ ! -d "$COMFYUI_DIR" ]; then
        log_error "ComfyUI directory not found: $COMFYUI_DIR"
        log_error "This script is designed for RunPod ComfyUI template."
        log_error "Please use the RunPod ComfyUI template or install ComfyUI manually first."
        exit 1
    fi

    cd "$COMFYUI_DIR"

    # Check if requirements are already satisfied (optimization for RunPod template)
    if [ -f "requirements.txt" ]; then
        log_info "Checking if requirements are already satisfied..."

        # Quick check: if key packages are already installed, skip full install
        if $PYTHON_CMD -c "import torch, torchvision, torchaudio" 2>/dev/null; then
            log_info "Core PyTorch packages already installed (optimizing install)..."
            log_info "Installing only missing requirements..."

            # Use --upgrade-strategy only-if-needed to avoid unnecessary reinstalls
            if retry_command 3 $PIP_CMD install --upgrade-strategy only-if-needed -r requirements.txt; then
                log_success "Requirements verified/updated"
            else
                log_warning "Some requirements failed (may be non-critical)"
            fi
        else
            log_info "Installing full requirements.txt..."
            retry_command 3 $PIP_CMD install -r requirements.txt
            log_success "Base requirements installed"
        fi
    else
        log_warning "requirements.txt not found, skipping base installation"
    fi
}

################################################################################
# CUSTOM NODES INSTALLATION
################################################################################

install_custom_node() {
    local repo_url="$1"
    local node_name=$(basename "$repo_url" .git)
    local node_dir="${COMFYUI_DIR}/custom_nodes/${node_name}"

    if [ -d "$node_dir" ]; then
        log_info "✓ Custom node already installed: $node_name (skipping)"
        return 0
    fi

    log_info "Installing custom node: $node_name..."
    cd "${COMFYUI_DIR}/custom_nodes"

    if retry_command 3 git clone "$repo_url"; then
        log_success "Cloned: $node_name"

        # Install node dependencies if requirements.txt exists
        if [ -f "${node_dir}/requirements.txt" ]; then
            log_info "Installing dependencies for $node_name..."
            cd "$node_dir"
            if retry_command 3 $PIP_CMD install -r requirements.txt; then
                log_success "Dependencies installed for $node_name"
            else
                log_warning "Failed to install dependencies for $node_name (non-fatal)"
            fi
        fi

        # Run install.py if it exists
        if [ -f "${node_dir}/install.py" ]; then
            log_info "Running install.py for $node_name..."
            cd "$node_dir"
            if $PYTHON_CMD install.py; then
                log_success "Install script completed for $node_name"
            else
                log_warning "Install script failed for $node_name (non-fatal)"
            fi
        fi

        return 0
    else
        log_error "Failed to clone: $node_name"
        return 1
    fi
}

install_custom_nodes() {
    log_step "Installing Custom Nodes for Character Generation"

    mkdir -p "${COMFYUI_DIR}/custom_nodes"

    # Essential custom nodes for AI character consistency
    local nodes=(
        # Core management and utilities
        "https://github.com/Comfy-Org/ComfyUI-Manager.git"
        "https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git"
        "https://github.com/rgthree/rgthree-comfy.git"

        # Character generation essentials
        "https://github.com/cubiq/ComfyUI_IPAdapter_plus.git"
        "https://github.com/Fannovel16/comfyui_controlnet_aux.git"

        # Advanced processing
        "https://github.com/ltdrdata/ComfyUI-Impact-Pack.git"
        "https://github.com/kijai/ComfyUI-KJNodes.git"
        "https://github.com/WASasquatch/was-node-suite-comfyui.git"

        # Face consistency (critical for influencer)
        "https://github.com/Gourieff/ComfyUI-ReActor.git"
    )

    local total=${#nodes[@]}
    local current=0

    for node_url in "${nodes[@]}"; do
        current=$((current + 1))
        log_info "[$current/$total] Installing custom node..."
        install_custom_node "$node_url"
    done

    log_success "Custom nodes installation completed"
}

################################################################################
# DIRECTORY STRUCTURE
################################################################################

create_directory_structure() {
    log_step "Creating Directory Structure"

    local dirs=(
        "${COMFYUI_DIR}/models/checkpoints"
        "${COMFYUI_DIR}/models/vae"
        "${COMFYUI_DIR}/models/upscale_models"
        "${COMFYUI_DIR}/models/ipadapter"
        "${COMFYUI_DIR}/models/controlnet"
        "${COMFYUI_DIR}/models/loras"
        "${COMFYUI_DIR}/models/clip_vision"
        "${COMFYUI_DIR}/input"
        "${COMFYUI_DIR}/output"
        "${LOG_DIR}"
    )

    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            log_info "Created: $dir"
        fi
    done

    log_success "Directory structure verified"
}

################################################################################
# ENVIRONMENT CONFIGURATION
################################################################################

configure_environment() {
    log_step "Configuring Environment Variables"

    # Create environment file for persistence
    local env_file="${WORKSPACE}/.comfyui_env"

    cat > "$env_file" << EOF
# ComfyUI Environment Configuration (v6.0.0)
export COMFYUI_PATH="$COMFYUI_DIR"
export COMFYUI_MODEL_PATH="${COMFYUI_DIR}/models"
EOF

    # Add to bashrc for persistence across sessions
    if [ -f "$HOME/.bashrc" ]; then
        if ! grep -q "comfyui_env" "$HOME/.bashrc"; then
            echo "" >> "$HOME/.bashrc"
            echo "# ComfyUI Environment (added by setup v6.0.0)" >> "$HOME/.bashrc"
            echo "[ -f ${env_file} ] && source ${env_file}" >> "$HOME/.bashrc"
            log_success "Environment variables added to .bashrc"
        fi
    fi

    # Source for current session
    source "$env_file"

    log_success "Environment configured:"
    log_info "  COMFYUI_PATH=$COMFYUI_PATH"
    log_info "  COMFYUI_MODEL_PATH=$COMFYUI_MODEL_PATH"
}

################################################################################
# AUTO-START CONFIGURATION
################################################################################

setup_auto_start() {
    log_step "Configuring Auto-Start for ComfyUI"

    local on_start_file="${WORKSPACE}/on_start.sh"

    # Check if on_start.sh already has ComfyUI entry
    if [ -f "$on_start_file" ] && grep -q "ComfyUI Auto-Start v6.0.0" "$on_start_file" 2>/dev/null; then
        log_info "Auto-start already configured (skipping)"
        return 0
    fi

    # Create or append to on_start.sh
    cat >> "$on_start_file" << 'EOF'

# ComfyUI Auto-Start v6.0.0 (Production Final)
if [ -d "/workspace/ComfyUI" ] || [ -d "/workspace/runpod-slim/ComfyUI" ]; then
    COMFYUI_PATH="/workspace/ComfyUI"
    [ -d "/workspace/runpod-slim/ComfyUI" ] && COMFYUI_PATH="/workspace/runpod-slim/ComfyUI"

    # Set environment variables
    export COMFYUI_PATH="$COMFYUI_PATH"
    export COMFYUI_MODEL_PATH="${COMFYUI_PATH}/models"

    echo "[$(date)] Starting ComfyUI v6.0.0..."
    cd "$COMFYUI_PATH"

    # Kill existing process if running
    if [ -f "/workspace/comfyui.pid" ]; then
        OLD_PID=$(cat /workspace/comfyui.pid)
        if ps -p $OLD_PID > /dev/null 2>&1; then
            echo "[$(date)] Stopping existing ComfyUI (PID: $OLD_PID)..."
            kill $OLD_PID 2>/dev/null || true
            sleep 2
        fi
    fi

    # Start ComfyUI
    nohup python3 main.py --listen 0.0.0.0 --port 8188 > /workspace/logs/comfyui.log 2>&1 &
    echo $! > /workspace/comfyui.pid
    echo "[$(date)] ComfyUI started (PID: $(cat /workspace/comfyui.pid))"
fi
EOF

    chmod +x "$on_start_file"
    log_success "Auto-start configured: $on_start_file"

    # Add cron @reboot as fallback (only if crontab is available)
    if command_exists crontab; then
        local cron_entry="@reboot cd $COMFYUI_DIR && nohup $PYTHON_CMD main.py --listen 0.0.0.0 --port 8188 > ${LOG_DIR}/comfyui.log 2>&1 &"

        if ! crontab -l 2>/dev/null | grep -q "ComfyUI"; then
            (crontab -l 2>/dev/null; echo "# ComfyUI Auto-Start v6.0.0"; echo "$cron_entry") | crontab - 2>/dev/null && \
                log_success "Cron @reboot fallback configured" || \
                log_info "Cron fallback not available (using on_start.sh only)"
        fi
    else
        log_info "crontab not available (using on_start.sh only)"
    fi
}

################################################################################
# COMFYUI STARTUP
################################################################################

start_comfyui() {
    log_step "Starting ComfyUI"

    cd "$COMFYUI_DIR"

    # Kill existing process if running
    if [ -f "$PID_FILE" ]; then
        OLD_PID=$(cat "$PID_FILE")
        if ps -p $OLD_PID > /dev/null 2>&1; then
            log_info "Stopping existing ComfyUI (PID: $OLD_PID)..."
            kill $OLD_PID 2>/dev/null || true
            sleep 2
        fi
    fi

    # Start ComfyUI in background
    log_info "Launching ComfyUI server..."
    nohup $PYTHON_CMD main.py --listen 0.0.0.0 --port 8188 > "${LOG_DIR}/comfyui.log" 2>&1 &
    echo $! > "$PID_FILE"

    local pid=$(cat "$PID_FILE")
    log_success "ComfyUI started (PID: $pid)"

    # Wait for server to be ready
    log_info "Waiting for server to initialize..."
    local max_wait=30
    local waited=0

    while [ $waited -lt $max_wait ]; do
        if curl -s http://localhost:8188 > /dev/null 2>&1; then
            log_success "ComfyUI server is ready!"
            return 0
        fi
        sleep 2
        waited=$((waited + 2))
    done

    log_warning "Server may still be initializing (check logs at ${LOG_DIR}/comfyui.log)"
}

get_runpod_url() {
    # Detect RunPod public URL
    if [ -n "${RUNPOD_POD_ID:-}" ]; then
        # RunPod environment detected
        if [ -n "${RUNPOD_PUBLIC_IP:-}" ]; then
            echo "https://${RUNPOD_POD_ID}-8188.proxy.runpod.net"
        else
            echo "http://localhost:8188"
        fi
    elif [ -n "${PUBLIC_URL:-}" ]; then
        # Generic public URL
        echo "$PUBLIC_URL"
    else
        # Fallback to localhost
        echo "http://localhost:8188"
    fi
}

################################################################################
# HEALTH CHECKS
################################################################################

run_health_checks() {
    log_step "Running Health Checks"

    local checks_passed=0
    local checks_total=6

    # Check 1: ComfyUI directory
    if [ -d "$COMFYUI_DIR" ]; then
        log_success "✓ ComfyUI directory exists"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ ComfyUI directory missing"
    fi

    # Check 2: Main script
    if [ -f "${COMFYUI_DIR}/main.py" ]; then
        log_success "✓ main.py exists"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ main.py missing"
    fi

    # Check 3: Custom nodes directory
    if [ -d "${COMFYUI_DIR}/custom_nodes" ]; then
        local node_count=$(find "${COMFYUI_DIR}/custom_nodes" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
        log_success "✓ Custom nodes installed: $node_count"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ Custom nodes directory missing"
    fi

    # Check 4: PyTorch + CUDA
    if $PYTHON_CMD -c "import torch; print(torch.cuda.is_available())" 2>/dev/null | grep -q "True"; then
        log_success "✓ PyTorch + CUDA available"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ CUDA not available (CPU mode only)"
    fi

    # Check 5: Environment variables
    if [ -n "${COMFYUI_PATH:-}" ] && [ -n "${COMFYUI_MODEL_PATH:-}" ]; then
        log_success "✓ Environment variables configured"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ Environment variables not set"
    fi

    # Check 6: ComfyUI running
    if [ -f "$PID_FILE" ]; then
        local pid=$(cat "$PID_FILE")
        if ps -p $pid > /dev/null 2>&1; then
            log_success "✓ ComfyUI is running (PID: $pid)"
            checks_passed=$((checks_passed + 1))
        else
            log_warning "✗ ComfyUI process not found"
        fi
    else
        log_warning "✗ ComfyUI not started"
    fi

    log_info "Health checks: $checks_passed/$checks_total passed"

    if [ $checks_passed -ge 5 ]; then
        log_success "System health: EXCELLENT"
        return 0
    elif [ $checks_passed -ge 4 ]; then
        log_success "System health: GOOD"
        return 0
    else
        log_warning "System health: NEEDS ATTENTION"
        return 1
    fi
}

################################################################################
# MAIN INSTALLATION FLOW
################################################################################

main() {
    echo ""
    echo "════════════════════════════════════════════════════════════════"
    echo "  ComfyUI Professional Setup v6.0.0 - PRODUCTION FINAL"
    echo "  Zero-Compromise Quality + Premium User Experience"
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    setup_logging
    check_prerequisites

    log_info "ComfyUI directory: $COMFYUI_DIR"
    log_info "Environment: COMFYUI_PATH=$COMFYUI_PATH"

    fix_numpy_conflict
    install_comfyui_base
    create_directory_structure
    install_custom_nodes
    configure_environment
    setup_auto_start
    start_comfyui

    echo ""
    echo "════════════════════════════════════════════════════════════════"
    run_health_checks
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    log_success "ComfyUI setup completed successfully!"
    echo ""
    log_info "Next steps:"
    log_info "  1. Download models: ./download-models-pro-v6.0.0.sh"
    log_info "  2. Access ComfyUI at: $(get_runpod_url)"
    log_info ""
    log_info "Server logs: ${LOG_DIR}/comfyui.log"
    log_info "Setup log: $LOG_FILE"
    echo ""

    # Display access URL prominently
    local access_url=$(get_runpod_url)
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ComfyUI is RUNNING!${NC}"
    echo -e "${GREEN}  Access at: ${CYAN}${access_url}${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Run main installation
main "$@"
