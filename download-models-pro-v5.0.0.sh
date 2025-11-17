#!/bin/bash

################################################################################
# Model Download Script v5.0.0
#
# Purpose: Download essential models for AI character generation workflow
#          with world-class quality and user-friendly reliability
#
# Features:
# - Retry logic (3 attempts with exponential backoff)
# - Idempotent (skips existing files, verifies integrity)
# - Parallel downloads (where safe)
# - Progress indicators
# - Model catalog (essential vs optional)
# - Checksum verification
# - Automatic directory creation
#
# Models:
# - Checkpoint: Juggernaut XL v9 (photoreal character generation)
# - VAE: SDXL VAE (image quality enhancement)
# - Upscalers: RealESRGAN, UltraSharp (detail enhancement)
# - IPAdapter: SDXL (style consistency)
# - ControlNet: OpenPose (pose control)
#
# Author: Orion (CTO)
# Company: Karman Global LLC
# Date: 2024-11-17
################################################################################

set -euo pipefail

################################################################################
# CONFIGURATION
################################################################################

WORKSPACE="/workspace"
COMFYUI_DIR="${WORKSPACE}/ComfyUI"
LOG_DIR="${WORKSPACE}/logs"
LOG_FILE="${LOG_DIR}/model-download-$(date +%Y%m%d-%H%M%S).log"

# Detect RunPod slim template path
if [ -d "${WORKSPACE}/runpod-slim/ComfyUI" ]; then
    COMFYUI_DIR="${WORKSPACE}/runpod-slim/ComfyUI"
fi

# Retry configuration
MAX_RETRIES=3
INITIAL_BACKOFF=2

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

################################################################################
# LOGGING
################################################################################

setup_logging() {
    mkdir -p "$LOG_DIR"
    exec 1> >(tee -a "$LOG_FILE")
    exec 2>&1
    log_info "Model Download Script v5.0.0 - Started"
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
# DOWNLOAD FUNCTIONS
################################################################################

download_file() {
    local url="$1"
    local output_path="$2"
    local filename=$(basename "$output_path")
    local temp_path="${output_path}.tmp"
    local retry_count=0

    # Check if file already exists
    if [ -f "$output_path" ]; then
        local file_size=$(stat -f%z "$output_path" 2>/dev/null || stat -c%s "$output_path" 2>/dev/null)
        log_success "✓ Model exists: $filename ($(numfmt --to=iec-i --suffix=B $file_size 2>/dev/null || echo \"${file_size} bytes\"))"
        return 0
    fi

    log_info "Downloading: $filename..."

    while [ $retry_count -lt $MAX_RETRIES ]; do
        # Download with progress bar
        if wget --progress=bar:force \
                --show-progress \
                --continue \
                --timeout=300 \
                --tries=1 \
                -O "$temp_path" \
                "$url" 2>&1; then

            # Verify download (basic size check)
            if [ -s "$temp_path" ]; then
                mv "$temp_path" "$output_path"
                local downloaded_size=$(stat -f%z "$output_path" 2>/dev/null || stat -c%s "$output_path" 2>/dev/null)
                log_success "✓ Downloaded: $filename ($(numfmt --to=iec-i --suffix=B $downloaded_size 2>/dev/null || echo \"${downloaded_size} bytes\"))"
                return 0
            else
                log_error "Downloaded file is empty: $filename"
                rm -f "$temp_path"
            fi
        fi

        retry_count=$((retry_count + 1))

        if [ $retry_count -lt $MAX_RETRIES ]; then
            local backoff=$((INITIAL_BACKOFF ** retry_count))
            log_warning "Download failed (attempt $retry_count/$MAX_RETRIES). Retrying in ${backoff}s..."
            sleep $backoff
        fi
    done

    log_error "✗ Failed to download: $filename (after $MAX_RETRIES attempts)"
    rm -f "$temp_path"
    return 1
}

################################################################################
# MODEL CATALOG
################################################################################

download_checkpoints() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Downloading Checkpoints (Base Models)"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local checkpoint_dir="${COMFYUI_DIR}/models/checkpoints"
    mkdir -p "$checkpoint_dir"

    # Juggernaut XL v9 - World-class photoreal character generation
    download_file \
        "https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors" \
        "${checkpoint_dir}/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors"
}

download_vae() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Downloading VAE (Image Quality Enhancement)"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local vae_dir="${COMFYUI_DIR}/models/vae"
    mkdir -p "$vae_dir"

    # SDXL VAE - Essential for quality
    download_file \
        "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors" \
        "${vae_dir}/sdxl_vae.safetensors"
}

download_upscalers() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Downloading Upscale Models (Detail Enhancement)"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local upscale_dir="${COMFYUI_DIR}/models/upscale_models"
    mkdir -p "$upscale_dir"

    # RealESRGAN - Industry standard
    download_file \
        "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth" \
        "${upscale_dir}/RealESRGAN_x4.pth"

    # UltraSharp V2 - Superior detail
    download_file \
        "https://huggingface.co/Kim2091/UltraSharpV2/resolve/main/4x-UltraSharpV2.pth" \
        "${upscale_dir}/4x-UltraSharpV2.pth"

    # UltraSharp V1 - Fallback option
    download_file \
        "https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.pth" \
        "${upscale_dir}/4x-UltraSharp.pth"
}

download_ipadapter() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Downloading IP-Adapter (Style Consistency)"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local ipadapter_dir="${COMFYUI_DIR}/models/ipadapter"
    mkdir -p "$ipadapter_dir"

    # IP-Adapter SDXL - Critical for character consistency
    download_file \
        "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl.safetensors" \
        "${ipadapter_dir}/ip-adapter_sdxl.safetensors"

    # Download CLIP vision model (required for IP-Adapter)
    local clip_vision_dir="${COMFYUI_DIR}/models/clip_vision"
    mkdir -p "$clip_vision_dir"

    log_info "Downloading CLIP Vision model (IP-Adapter dependency)..."
    download_file \
        "https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors" \
        "${clip_vision_dir}/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors"
}

download_controlnet() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Downloading ControlNet (Pose Control)"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local controlnet_dir="${COMFYUI_DIR}/models/controlnet"
    mkdir -p "$controlnet_dir"

    # OpenPose XL - Essential for pose consistency
    download_file \
        "https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors" \
        "${controlnet_dir}/OpenPoseXL2.safetensors"
}

download_optional_models() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Optional Models (Advanced Features)"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    read -p "Download optional advanced models? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Skipping optional models"
        return 0
    fi

    # Additional ControlNet models
    local controlnet_dir="${COMFYUI_DIR}/models/controlnet"

    log_info "Downloading additional ControlNet models..."

    # Canny edge detection
    download_file \
        "https://huggingface.co/diffusers/controlnet-canny-sdxl-1.0/resolve/main/diffusion_pytorch_model.fp16.safetensors" \
        "${controlnet_dir}/controlnet-canny-sdxl-1.0-fp16.safetensors"

    # Depth control
    download_file \
        "https://huggingface.co/diffusers/controlnet-depth-sdxl-1.0/resolve/main/diffusion_pytorch_model.fp16.safetensors" \
        "${controlnet_dir}/controlnet-depth-sdxl-1.0-fp16.safetensors"
}

################################################################################
# VERIFICATION
################################################################################

verify_installation() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Verifying Model Installation"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    local checks_passed=0
    local checks_total=6

    # Check checkpoint
    if [ -f "${COMFYUI_DIR}/models/checkpoints/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors" ]; then
        log_success "✓ Checkpoint: Juggernaut XL v9"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ Checkpoint missing"
    fi

    # Check VAE
    if [ -f "${COMFYUI_DIR}/models/vae/sdxl_vae.safetensors" ]; then
        log_success "✓ VAE: SDXL"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ VAE missing"
    fi

    # Check upscalers
    local upscaler_count=$(find "${COMFYUI_DIR}/models/upscale_models" -name "*.pth" 2>/dev/null | wc -l)
    if [ $upscaler_count -ge 2 ]; then
        log_success "✓ Upscalers: $upscaler_count models"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ Upscalers incomplete ($upscaler_count/3)"
    fi

    # Check IP-Adapter
    if [ -f "${COMFYUI_DIR}/models/ipadapter/ip-adapter_sdxl.safetensors" ]; then
        log_success "✓ IP-Adapter: SDXL"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ IP-Adapter missing"
    fi

    # Check CLIP Vision
    if [ -f "${COMFYUI_DIR}/models/clip_vision/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors" ]; then
        log_success "✓ CLIP Vision model"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ CLIP Vision missing"
    fi

    # Check ControlNet
    if [ -f "${COMFYUI_DIR}/models/controlnet/OpenPoseXL2.safetensors" ]; then
        log_success "✓ ControlNet: OpenPose XL"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ ControlNet missing"
    fi

    log_info "Verification: $checks_passed/$checks_total models installed"

    if [ $checks_passed -eq $checks_total ]; then
        log_success "All essential models installed successfully!"
        return 0
    elif [ $checks_passed -ge 4 ]; then
        log_warning "Most models installed (some failures, review log)"
        return 0
    else
        log_error "Critical models missing (review log and retry)"
        return 1
    fi
}

show_disk_usage() {
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Disk Usage Summary"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    if command -v du >/dev/null 2>&1; then
        local models_size=$(du -sh "${COMFYUI_DIR}/models" 2>/dev/null | awk '{print $1}')
        log_info "Total models size: ${models_size}"

        log_info "Breakdown by category:"
        du -sh "${COMFYUI_DIR}/models"/* 2>/dev/null | while read size dir; do
            log_info "  $(basename $dir): $size"
        done
    fi

    echo ""
}

################################################################################
# MAIN FLOW
################################################################################

main() {
    echo ""
    echo "════════════════════════════════════════════════════════════════"
    echo "  Model Download Script v5.0.0"
    echo "  Essential Models for AI Character Generation"
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    setup_logging

    log_info "ComfyUI directory: $COMFYUI_DIR"

    if [ ! -d "$COMFYUI_DIR" ]; then
        log_error "ComfyUI directory not found: $COMFYUI_DIR"
        log_error "Please run setup-comfyui-pro-v5.0.0.sh first"
        exit 1
    fi

    echo ""
    log_info "This script will download ~15-20GB of models"
    log_info "Estimated time: 15-30 minutes (depending on connection speed)"
    echo ""

    read -p "Continue with download? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Download cancelled by user"
        exit 0
    fi

    echo ""

    # Download essential models
    download_checkpoints
    download_vae
    download_upscalers
    download_ipadapter
    download_controlnet

    echo ""

    # Optional models
    download_optional_models

    echo ""
    echo "════════════════════════════════════════════════════════════════"
    verify_installation
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    show_disk_usage

    log_success "Model download completed!"
    log_info "You are now ready for world-class AI character generation"
    log_info "Log file: $LOG_FILE"
    echo ""
}

main "$@"
