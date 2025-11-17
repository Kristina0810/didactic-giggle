#!/bin/bash

################################################################################
# ComfyUI Professional Setup Script v5.0.0
#
# Purpose: One-click, zero-compromise ComfyUI installation for AI character
#          generation with world-class output and user-friendly reliability
#
# Features:
# - Error handling with retry logic
# - Idempotent (safe to re-run)
# - Auto-start configuration
# - Custom nodes + dependencies
# - Model downloads (via separate script)
# - Progress indicators and logging
# - Health checks
#
# Target: RunPod ComfyUI template (PyTorch latest, GPU pre-configured)
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
COMFYUI_DIR="${WORKSPACE}/ComfyUI"
LOG_DIR="${WORKSPACE}/logs"
LOG_FILE="${LOG_DIR}/comfyui-setup-$(date +%Y%m%d-%H%M%S).log"
PID_FILE="${WORKSPACE}/comfyui.pid"

# Detect RunPod slim template path
if [ -d "${WORKSPACE}/runpod-slim/ComfyUI" ]; then
    COMFYUI_DIR="${WORKSPACE}/runpod-slim/ComfyUI"
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
    log_info "ComfyUI Professional Setup v5.0.0 - Started"
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

    if ! command_exists python; then
        log_error "Python not found. This script requires Python 3.10+"
        exit 1
    fi

    if ! command_exists git; then
        log_error "Git not found. Installing git..."
        apt-get update && apt-get install -y git
    fi

    if ! command_exists wget; then
        log_error "wget not found. Installing wget..."
        apt-get update && apt-get install -y wget
    fi

    local python_version=$(python --version 2>&1 | awk '{print $2}')
    log_success "Python version: $python_version"

    if ! python -c "import torch" 2>/dev/null; then
        log_warning "PyTorch not found. Ensure you're running on RunPod GPU template."
    else
        local torch_version=$(python -c "import torch; print(torch.__version__)")
        log_success "PyTorch version: $torch_version"
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
# COMFYUI INSTALLATION
################################################################################

install_comfyui_base() {
    log_info "Installing ComfyUI base requirements..."

    if [ ! -d "$COMFYUI_DIR" ]; then
        log_error "ComfyUI directory not found: $COMFYUI_DIR"
        log_error "This script is designed for RunPod ComfyUI template."
        log_error "Please use the RunPod ComfyUI template or install ComfyUI manually first."
        exit 1
    fi

    cd "$COMFYUI_DIR"

    if [ -f "requirements.txt" ]; then
        log_info "Installing requirements.txt..."
        retry_command 3 python -m pip install -r requirements.txt
        log_success "Base requirements installed"
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
        log_info "Custom node already installed: $node_name (skipping)"
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
            if retry_command 3 python -m pip install -r requirements.txt; then
                log_success "Dependencies installed for $node_name"
            else
                log_warning "Failed to install dependencies for $node_name (non-fatal)"
            fi
        fi

        # Run install.py if it exists
        if [ -f "${node_dir}/install.py" ]; then
            log_info "Running install.py for $node_name..."
            cd "$node_dir"
            if python install.py; then
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
    log_info "Installing custom nodes for character generation workflow..."

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
        log_info "Installing custom node $current/$total..."
        install_custom_node "$node_url"
    done

    log_success "Custom nodes installation completed"
}

################################################################################
# DIRECTORY STRUCTURE
################################################################################

create_directory_structure() {
    log_info "Creating directory structure..."

    local dirs=(
        "${COMFYUI_DIR}/models/checkpoints"
        "${COMFYUI_DIR}/models/vae"
        "${COMFYUI_DIR}/models/upscale_models"
        "${COMFYUI_DIR}/models/ipadapter"
        "${COMFYUI_DIR}/models/controlnet"
        "${COMFYUI_DIR}/models/loras"
        "${COMFYUI_DIR}/input"
        "${COMFYUI_DIR}/output"
        "${WORKSPACE}/workflows"
        "${WORKSPACE}/training-images"
        "${LOG_DIR}"
    )

    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
        log_info "Created: $dir"
    done

    log_success "Directory structure created"
}

################################################################################
# AUTO-START CONFIGURATION
################################################################################

setup_auto_start() {
    log_info "Configuring auto-start for ComfyUI..."

    local on_start_file="${WORKSPACE}/on_start.sh"

    # Check if on_start.sh already has ComfyUI entry
    if [ -f "$on_start_file" ] && grep -q "ComfyUI" "$on_start_file" 2>/dev/null; then
        log_info "Auto-start already configured (skipping)"
        return 0
    fi

    # Create or append to on_start.sh
    cat >> "$on_start_file" << 'EOF'

# ComfyUI Auto-Start (v5.0.0)
if [ -d "/workspace/ComfyUI" ] || [ -d "/workspace/runpod-slim/ComfyUI" ]; then
    COMFYUI_PATH="/workspace/ComfyUI"
    [ -d "/workspace/runpod-slim/ComfyUI" ] && COMFYUI_PATH="/workspace/runpod-slim/ComfyUI"

    echo "[$(date)] Starting ComfyUI..."
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
    nohup python main.py --listen 0.0.0.0 --port 8188 > /workspace/logs/comfyui.log 2>&1 &
    echo $! > /workspace/comfyui.pid
    echo "[$(date)] ComfyUI started (PID: $(cat /workspace/comfyui.pid))"
fi
EOF

    chmod +x "$on_start_file"
    log_success "Auto-start configured: $on_start_file"

    # Also add cron @reboot as fallback
    local cron_entry="@reboot cd $COMFYUI_DIR && nohup python main.py --listen 0.0.0.0 --port 8188 > ${LOG_DIR}/comfyui.log 2>&1 &"

    if ! crontab -l 2>/dev/null | grep -q "ComfyUI"; then
        (crontab -l 2>/dev/null; echo "$cron_entry") | crontab -
        log_success "Cron @reboot fallback configured"
    fi
}

################################################################################
# HEALTH CHECKS
################################################################################

run_health_checks() {
    log_info "Running health checks..."

    local checks_passed=0
    local checks_total=5

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
        local node_count=$(find "${COMFYUI_DIR}/custom_nodes" -mindepth 1 -maxdepth 1 -type d | wc -l)
        log_success "✓ Custom nodes installed: $node_count"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ Custom nodes directory missing"
    fi

    # Check 4: PyTorch availability
    if python -c "import torch; print(torch.cuda.is_available())" 2>/dev/null | grep -q "True"; then
        log_success "✓ PyTorch + CUDA available"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ CUDA not available (CPU mode only)"
    fi

    # Check 5: Auto-start configuration
    if [ -f "${WORKSPACE}/on_start.sh" ] && grep -q "ComfyUI" "${WORKSPACE}/on_start.sh"; then
        log_success "✓ Auto-start configured"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ Auto-start not configured"
    fi

    log_info "Health checks: $checks_passed/$checks_total passed"

    if [ $checks_passed -ge 4 ]; then
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
    echo "  ComfyUI Professional Setup v5.0.0"
    echo "  World-Class Output + User-Friendly Reliability"
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    setup_logging
    check_prerequisites

    log_info "ComfyUI directory: $COMFYUI_DIR"

    install_comfyui_base
    create_directory_structure
    install_custom_nodes
    setup_auto_start

    echo ""
    echo "════════════════════════════════════════════════════════════════"
    run_health_checks
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    log_success "ComfyUI setup completed successfully!"
    log_info "Next steps:"
    log_info "  1. Run: ./download-models-pro-v5.0.0.sh (download essential models)"
    log_info "  2. Start ComfyUI manually: cd $COMFYUI_DIR && python main.py"
    log_info "  3. Or restart pod (auto-start configured)"
    log_info ""
    log_info "Access ComfyUI at: http://localhost:8188"
    log_info "Log file: $LOG_FILE"
}

# Run main installation
main "$@"
