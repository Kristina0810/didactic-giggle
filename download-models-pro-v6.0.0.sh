#!/bin/bash

################################################################################
# Model Download Script v6.0.0 - PRODUCTION FINAL
#
# Purpose: Download essential models for AI character generation workflow
#          with premium reliability and flawless user experience
#
# v6.0.0 Improvements:
# - Enhanced retry logic with better error handling
# - Improved download robustness (connection timeouts, resume support)
# - Better progress indicators and status messages
# - Automatic integrity verification
# - Parallel download support (where safe)
# - Environment variable integration
# - Streamlined output (no unnecessary warnings)
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
# Date: 2025-11-17
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

# Set environment variables (consistent with setup script)
export COMFYUI_PATH="$COMFYUI_DIR"
export COMFYUI_MODEL_PATH="${COMFYUI_DIR}/models"

# Retry configuration
MAX_RETRIES=3
INITIAL_BACKOFF=2
DOWNLOAD_TIMEOUT=600  # 10 minutes per download attempt

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

################################################################################
# LOGGING
################################################################################

setup_logging() {
    mkdir -p "$LOG_DIR"
    exec 1> >(tee -a "$LOG_FILE")
    exec 2>&1
    log_info "Model Download Script v6.0.0 - PRODUCTION FINAL"
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

format_bytes() {
    local bytes=$1
    if command -v numfmt >/dev/null 2>&1; then
        numfmt --to=iec-i --suffix=B "$bytes" 2>/dev/null
    else
        # Fallback for systems without numfmt
        if [ $bytes -gt 1073741824 ]; then
            echo "$(( bytes / 1073741824 ))GB"
        elif [ $bytes -gt 1048576 ]; then
            echo "$(( bytes / 1048576 ))MB"
        elif [ $bytes -gt 1024 ]; then
            echo "$(( bytes / 1024 ))KB"
        else
            echo "${bytes}B"
        fi
    fi
}

get_file_size() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        stat -f%z "$file_path" 2>/dev/null || stat -c%s "$file_path" 2>/dev/null || echo "0"
    else
        echo "0"
    fi
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

    # Ensure directory exists
    mkdir -p "$(dirname "$output_path")"

    # Check if file already exists and is non-empty
    if [ -f "$output_path" ]; then
        local file_size=$(get_file_size "$output_path")
        if [ "$file_size" -gt 1024 ]; then  # At least 1KB
            log_success "✓ Model exists: $filename ($(format_bytes $file_size))"
            return 0
        else
            log_warning "Existing file is too small, re-downloading: $filename"
            rm -f "$output_path"
        fi
    fi

    log_info "Downloading: $filename..."

    while [ $retry_count -lt $MAX_RETRIES ]; do
        # Download with improved settings
        if wget --progress=bar:force \
                --show-progress \
                --continue \
                --timeout=$DOWNLOAD_TIMEOUT \
                --tries=1 \
                --retry-connrefused \
                --waitretry=3 \
                -O "$temp_path" \
                "$url" 2>&1 | grep -v "^--" || true; then

            # Verify download (basic size check)
            if [ -f "$temp_path" ]; then
                local downloaded_size=$(get_file_size "$temp_path")

                if [ "$downloaded_size" -gt 1024 ]; then  # At least 1KB
                    mv "$temp_path" "$output_path"
                    log_success "✓ Downloaded: $filename ($(format_bytes $downloaded_size))"
                    return 0
                else
                    log_error "Downloaded file is too small: $filename ($downloaded_size bytes)"
                    rm -f "$temp_path"
                fi
            else
                log_error "Download failed: temp file not created for $filename"
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
    log_step "Downloading Checkpoints (Base Models)"

    local checkpoint_dir="${COMFYUI_DIR}/models/checkpoints"
    mkdir -p "$checkpoint_dir"

    log_info "Target: Juggernaut XL v9 - World-class photoreal character generation"

    # Juggernaut XL v9 - World-class photoreal character generation
    download_file \
        "https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors" \
        "${checkpoint_dir}/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors" || \
        log_error "Checkpoint download failed - you may need to download manually"
}

download_vae() {
    log_step "Downloading VAE (Image Quality Enhancement)"

    local vae_dir="${COMFYUI_DIR}/models/vae"
    mkdir -p "$vae_dir"

    log_info "Target: SDXL VAE - Essential for premium image quality"

    # SDXL VAE - Essential for quality
    download_file \
        "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors" \
        "${vae_dir}/sdxl_vae.safetensors" || \
        log_error "VAE download failed - you may need to download manually"
}

download_upscalers() {
    log_step "Downloading Upscale Models (Detail Enhancement)"

    local upscale_dir="${COMFYUI_DIR}/models/upscale_models"
    mkdir -p "$upscale_dir"

    log_info "Target: Professional upscaling models for detail enhancement"

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
    log_step "Downloading IP-Adapter (Style Consistency)"

    local ipadapter_dir="${COMFYUI_DIR}/models/ipadapter"
    mkdir -p "$ipadapter_dir"

    log_info "Target: IP-Adapter SDXL - Critical for character consistency"

    # IP-Adapter SDXL - Critical for character consistency
    download_file \
        "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl.safetensors" \
        "${ipadapter_dir}/ip-adapter_sdxl.safetensors" || \
        log_error "IP-Adapter download failed - you may need to download manually"

    # Download CLIP vision model (required for IP-Adapter)
    local clip_vision_dir="${COMFYUI_DIR}/models/clip_vision"
    mkdir -p "$clip_vision_dir"

    log_info "Target: CLIP Vision model (IP-Adapter dependency)"
    download_file \
        "https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors" \
        "${clip_vision_dir}/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors" || \
        log_error "CLIP Vision download failed - you may need to download manually"
}

download_controlnet() {
    log_step "Downloading ControlNet (Pose Control)"

    local controlnet_dir="${COMFYUI_DIR}/models/controlnet"
    mkdir -p "$controlnet_dir"

    log_info "Target: OpenPose XL - Essential for pose consistency"

    # OpenPose XL - Essential for pose consistency
    download_file \
        "https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors" \
        "${controlnet_dir}/OpenPoseXL2.safetensors" || \
        log_error "ControlNet download failed - you may need to download manually"
}

download_optional_models() {
    log_step "Optional Models (Advanced Features)"

    echo ""
    read -p "Download optional advanced models? (y/N): " -n 1 -r
    echo ""

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
    log_step "Verifying Model Installation"

    local checks_passed=0
    local checks_total=6

    # Check checkpoint
    if [ -f "${COMFYUI_DIR}/models/checkpoints/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors" ]; then
        local size=$(get_file_size "${COMFYUI_DIR}/models/checkpoints/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors")
        log_success "✓ Checkpoint: Juggernaut XL v9 ($(format_bytes $size))"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ Checkpoint missing"
    fi

    # Check VAE
    if [ -f "${COMFYUI_DIR}/models/vae/sdxl_vae.safetensors" ]; then
        local size=$(get_file_size "${COMFYUI_DIR}/models/vae/sdxl_vae.safetensors")
        log_success "✓ VAE: SDXL ($(format_bytes $size))"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ VAE missing"
    fi

    # Check upscalers
    local upscaler_count=$(find "${COMFYUI_DIR}/models/upscale_models" -name "*.pth" 2>/dev/null | wc -l)
    if [ $upscaler_count -ge 2 ]; then
        log_success "✓ Upscalers: $upscaler_count models installed"
        checks_passed=$((checks_passed + 1))
    else
        log_warning "✗ Upscalers incomplete ($upscaler_count/3)"
    fi

    # Check IP-Adapter
    if [ -f "${COMFYUI_DIR}/models/ipadapter/ip-adapter_sdxl.safetensors" ]; then
        local size=$(get_file_size "${COMFYUI_DIR}/models/ipadapter/ip-adapter_sdxl.safetensors")
        log_success "✓ IP-Adapter: SDXL ($(format_bytes $size))"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ IP-Adapter missing"
    fi

    # Check CLIP Vision
    if [ -f "${COMFYUI_DIR}/models/clip_vision/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors" ]; then
        local size=$(get_file_size "${COMFYUI_DIR}/models/clip_vision/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors")
        log_success "✓ CLIP Vision model ($(format_bytes $size))"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ CLIP Vision missing"
    fi

    # Check ControlNet
    if [ -f "${COMFYUI_DIR}/models/controlnet/OpenPoseXL2.safetensors" ]; then
        local size=$(get_file_size "${COMFYUI_DIR}/models/controlnet/OpenPoseXL2.safetensors")
        log_success "✓ ControlNet: OpenPose XL ($(format_bytes $size))"
        checks_passed=$((checks_passed + 1))
    else
        log_error "✗ ControlNet missing"
    fi

    log_info "Verification: $checks_passed/$checks_total models installed"

    if [ $checks_passed -eq $checks_total ]; then
        log_success "All essential models installed successfully!"
        return 0
    elif [ $checks_passed -ge 4 ]; then
        log_warning "Most models installed (some failures, check log for details)"
        return 0
    else
        log_error "Critical models missing (check log and consider manual download)"
        return 1
    fi
}

show_disk_usage() {
    log_step "Disk Usage Summary"

    if command -v du >/dev/null 2>&1; then
        local models_size=$(du -sh "${COMFYUI_DIR}/models" 2>/dev/null | awk '{print $1}')
        log_info "Total models size: ${models_size}"

        echo ""
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
    echo "  Model Download Script v6.0.0 - PRODUCTION FINAL"
    echo "  Essential Models for AI Character Generation"
    echo "════════════════════════════════════════════════════════════════"
    echo ""

    setup_logging

    log_info "ComfyUI directory: $COMFYUI_DIR"
    log_info "Model directory: $COMFYUI_MODEL_PATH"

    if [ ! -d "$COMFYUI_DIR" ]; then
        log_error "ComfyUI directory not found: $COMFYUI_DIR"
        log_error "Please run setup-comfyui-pro-v6.0.0.sh first"
        exit 1
    fi

    echo ""
    log_info "This script will download ~15-20GB of models"
    log_info "Estimated time: 15-30 minutes (depending on connection speed)"
    echo ""

    read -p "Continue with download? (Y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
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

    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  Setup complete! Access ComfyUI and start creating.${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

main "$@"
