#!/bin/bash
# =============================================================================
# MODEL DOWNLOADER v2.0.0 - Curated Top Models for S-Tier Character Creation
# =============================================================================
# Purpose: Download essential models for ComfyUI character generation
# Models: Carefully curated top choices only
# Time: 5-20 minutes depending on selections and network
# Features: Idempotent, robust retry logic, clean progress indication
# Version: 2.0.0
# License: MIT
# =============================================================================

set -euo pipefail

# Configuration
readonly WORKSPACE="/workspace"
readonly MODELS_DIR="${WORKSPACE}/ComfyUI/models"
readonly LOG_FILE="${WORKSPACE}/logs/model-downloads.log"

# ANSI Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly NC='\033[0m'

# Create log
mkdir -p "$(dirname "$LOG_FILE")"

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

log() {
    echo -e "${CYAN}▸${NC} $1"
    echo "[$(date)] $1" >> "$LOG_FILE"
}

success() {
    echo -e "${GREEN}✓${NC} $1"
    echo "[$(date)] ✓ $1" >> "$LOG_FILE"
}

error() {
    echo -e "${RED}✗${NC} $1" >&2
    echo "[$(date)] ✗ $1" >> "$LOG_FILE"
}

download_with_progress() {
    local url="$1"
    local output="$2"
    local desc="$3"
    local temp_output="${output}.tmp"
    local max_retries=3
    local retry_count=0

    echo ""
    log "Downloading: $desc"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    while [ $retry_count -lt $max_retries ]; do
        if [ $retry_count -gt 0 ]; then
            log "Retry attempt $retry_count/$max_retries..."
            sleep 2
        fi

        # Download with progress bar
        if wget --progress=bar:force --show-progress -O "$temp_output" "$url" 2>&1 | \
            grep --line-buffered -oP '\d+%' | \
            while read -r percent; do
                echo -ne "\r${CYAN}  Progress: ${GREEN}${percent}${NC}     "
            done
        then
            echo -ne "\r${GREEN}  Progress: 100% - Complete!${NC}          \n"
            mv "$temp_output" "$output"
            success "Downloaded: $desc"
            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo ""
            return 0
        fi

        retry_count=$((retry_count + 1))
        rm -f "$temp_output"
    done

    # All retries failed
    echo -ne "\r${RED}  Download failed after $max_retries attempts${NC}     \n"
    error "Failed to download: $desc"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    return 1
}

# Smart download - checks if file exists first
download_if_needed() {
    local url="$1"
    local output="$2"
    local desc="$3"
    
    if [ -f "$output" ]; then
        echo ""
        success "Already exists: $(basename "$output") (skipping download)"
        log "File: $output"
        echo ""
        return 0
    else
        download_with_progress "$url" "$output" "$desc"
    fi
}

# =============================================================================
# HEADER
# =============================================================================

clear
cat << "EOF"
╔═══════════════════════════════════════════════════════════════════════╗
║                                                                       ║
║              MODEL DOWNLOADER v2.0.0                                  ║
║          Curated Top Models for Character Creation                    ║
║          Idempotent • Retry Logic • Professional Grade                ║
║                                                                       ║
╚═══════════════════════════════════════════════════════════════════════╝
EOF
echo ""
echo -e "${CYAN}This script downloads essential models for ComfyUI${NC}"
echo -e "${CYAN}All models are carefully curated top choices${NC}"
echo ""

# Verify ComfyUI exists
if [ ! -d "$MODELS_DIR" ]; then
    error "ComfyUI models directory not found: $MODELS_DIR"
    error "Please run comfyui-pod-setup.sh first"
    exit 1
fi

# =============================================================================
# SECTION 1: BASE CHECKPOINTS (REQUIRED)
# =============================================================================

echo ""
echo -e "${BOLD}${CYAN}━━━ BASE CHECKPOINTS (Required) ━━━${NC}"
echo ""
echo "Base checkpoints are essential for image generation."
echo "Choose ONE from the top SDXL models:"
echo ""
echo -e "  ${BOLD}1. JuggernautXL v9${NC} (6.5GB) ${GREEN}[RECOMMENDED]${NC}"
echo "     - Best overall quality and consistency"
echo "     - Photorealistic with artistic flexibility"
echo "     - Industry standard for character creation"
echo ""
echo -e "  ${BOLD}2. RealVisXL v4${NC} (6.5GB)"
echo "     - Ultra-photorealistic"
echo "     - Excellent for professional headshots"
echo "     - Slightly less flexible than Juggernaut"
echo ""
echo -e "  ${BOLD}3. DreamShaper XL${NC} (6.5GB)"
echo "     - Balanced artistic/realistic"
echo "     - Great color and lighting"
echo "     - Good for creative character styles"
echo ""
echo -e "  ${BOLD}4. Skip${NC} - Download manually later"
echo ""

read -p "Select checkpoint [1-4]: " CHECKPOINT_CHOICE

case $CHECKPOINT_CHOICE in
    1)
        mkdir -p "$MODELS_DIR/checkpoints"
        cd "$MODELS_DIR/checkpoints"
        echo -e "${YELLOW}Estimated time: 2-5 minutes (depending on network speed)${NC}"
        download_if_needed \
            "https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors" \
            "JuggernautXL_v9.safetensors" \
            "JuggernautXL v9 (6.5GB)"
        ;;
    2)
        mkdir -p "$MODELS_DIR/checkpoints"
        cd "$MODELS_DIR/checkpoints"
        echo -e "${YELLOW}Estimated time: 2-5 minutes (depending on network speed)${NC}"
        download_if_needed \
            "https://huggingface.co/SG161222/RealVisXL_V4.0/resolve/main/RealVisXL_V4.0.safetensors" \
            "RealVisXL_v4.safetensors" \
            "RealVisXL v4 (6.5GB)"
        ;;
    3)
        mkdir -p "$MODELS_DIR/checkpoints"
        cd "$MODELS_DIR/checkpoints"
        echo -e "${YELLOW}Estimated time: 2-5 minutes (depending on network speed)${NC}"
        download_if_needed \
            "https://huggingface.co/Lykon/dreamshaper-xl-v2-turbo/resolve/main/DreamShaperXL_Turbo_v2.safetensors" \
            "DreamShaperXL_v2.safetensors" \
            "DreamShaper XL v2 (6.5GB)"
        ;;
    4)
        log "Skipped checkpoint download"
        ;;
    *)
        error "Invalid choice. Skipping checkpoint."
        ;;
esac

# =============================================================================
# SECTION 2: VAE (STRONGLY RECOMMENDED)
# =============================================================================

echo ""
echo -e "${BOLD}${CYAN}━━━ VAE Models (Strongly Recommended) ━━━${NC}"
echo ""
echo "VAE improves image quality and fixes common artifacts."
echo ""
echo -e "  ${BOLD}1. SDXL VAE${NC} (335MB) ${GREEN}[RECOMMENDED]${NC}"
echo "     - Official Stability AI VAE"
echo "     - Fixes color/artifact issues"
echo "     - Essential for quality"
echo ""
echo -e "  ${BOLD}2. Skip${NC}"
echo ""

read -p "Download SDXL VAE? [1-2]: " VAE_CHOICE

if [ "$VAE_CHOICE" = "1" ]; then
    mkdir -p "$MODELS_DIR/vae"
    cd "$MODELS_DIR/vae"
    echo -e "${YELLOW}Estimated time: 15-30 seconds${NC}"
    download_if_needed \
        "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors" \
        "sdxl_vae.safetensors" \
        "SDXL VAE (335MB)"
fi

# =============================================================================
# SECTION 3: UPSCALERS (RECOMMENDED FOR FINAL OUTPUTS)
# =============================================================================

echo ""
echo -e "${BOLD}${CYAN}━━━ Upscale Models (Recommended) ━━━${NC}"
echo ""
echo "Upscalers for high-resolution final outputs (Days 6-7)."
echo ""
echo -e "  ${BOLD}1. RealESRGAN x4 Plus${NC} (67MB) ${GREEN}[RECOMMENDED]${NC}"
echo "     - Best general-purpose upscaler"
echo "     - 4x resolution increase"
echo "     - Fast and high quality"
echo ""
echo -e "  ${BOLD}2. UltraSharp 4x${NC} (67MB)"
echo "     - Ultra-detailed upscaling"
echo "     - Best for close-ups"
echo "     - Slightly slower"
echo ""
echo -e "  ${BOLD}3. Both${NC}"
echo ""
echo -e "  ${BOLD}4. Skip${NC}"
echo ""

read -p "Select upscaler [1-4]: " UPSCALER_CHOICE

case $UPSCALER_CHOICE in
    1)
        mkdir -p "$MODELS_DIR/upscale_models"
        cd "$MODELS_DIR/upscale_models"
        echo -e "${YELLOW}Estimated time: 5-15 seconds${NC}"
        download_if_needed \
            "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth" \
            "RealESRGAN_x4plus.pth" \
            "RealESRGAN x4 Plus (67MB)"
        ;;
    2)
        mkdir -p "$MODELS_DIR/upscale_models"
        cd "$MODELS_DIR/upscale_models"
        echo -e "${YELLOW}Estimated time: 5-15 seconds${NC}"
        download_if_needed \
            "https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.pth" \
            "4x-UltraSharp.pth" \
            "UltraSharp 4x (67MB)"
        ;;
    3)
        mkdir -p "$MODELS_DIR/upscale_models"
        cd "$MODELS_DIR/upscale_models"
        echo -e "${YELLOW}Estimated time: 10-30 seconds (both models)${NC}"
        download_if_needed \
            "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth" \
            "RealESRGAN_x4plus.pth" \
            "RealESRGAN x4 Plus (67MB)"
        download_if_needed \
            "https://huggingface.co/Kim2091/UltraSharp/resolve/main/4x-UltraSharp.pth" \
            "4x-UltraSharp.pth" \
            "UltraSharp 4x (67MB)"
        ;;
    4)
        log "Skipped upscaler downloads"
        ;;
esac

# =============================================================================
# SECTION 4: IP-ADAPTER (OPTIONAL - Advanced Control)
# =============================================================================

echo ""
echo -e "${BOLD}${CYAN}━━━ IP-Adapter Models (Optional) ━━━${NC}"
echo ""
echo "IP-Adapter for image-guided generation (advanced workflows)."
echo ""
echo -e "  ${BOLD}1. IP-Adapter SDXL${NC} (690MB)"
echo "     - Image-to-image style transfer"
echo "     - Advanced control over generation"
echo ""
echo -e "  ${BOLD}2. Skip${NC} ${YELLOW}[Recommended for beginners]${NC}"
echo ""

read -p "Download IP-Adapter? [1-2]: " IPADAPTER_CHOICE

if [ "$IPADAPTER_CHOICE" = "1" ]; then
    mkdir -p "$MODELS_DIR/ipadapter"
    cd "$MODELS_DIR/ipadapter"
    echo -e "${YELLOW}Estimated time: 30-60 seconds${NC}"
    download_if_needed \
        "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl.safetensors" \
        "ip-adapter_sdxl.safetensors" \
        "IP-Adapter SDXL (690MB)"
fi

# =============================================================================
# SECTION 5: CONTROLNET (OPTIONAL - Advanced Users)
# =============================================================================

echo ""
echo -e "${BOLD}${CYAN}━━━ ControlNet Models (Optional) ━━━${NC}"
echo ""
echo "ControlNet for pose control (Day 6 advanced workflows)."
echo ""
echo -e "  ${BOLD}1. OpenPose SDXL${NC} (2.5GB)"
echo "     - Pose control and consistency"
echo "     - Advanced workflow only"
echo ""
echo -e "  ${BOLD}2. Skip${NC} ${YELLOW}[Recommended for beginners]${NC}"
echo ""

read -p "Download ControlNet OpenPose? [1-2]: " CONTROLNET_CHOICE

if [ "$CONTROLNET_CHOICE" = "1" ]; then
    mkdir -p "$MODELS_DIR/controlnet"
    cd "$MODELS_DIR/controlnet"
    echo -e "${YELLOW}Estimated time: 1-2 minutes${NC}"
    download_if_needed \
        "https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors" \
        "OpenPoseXL2.safetensors" \
        "ControlNet OpenPose (2.5GB)"
fi

# =============================================================================
# SUMMARY
# =============================================================================

cd "$WORKSPACE"

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                                                                       ║${NC}"
echo -e "${GREEN}║         Model Downloads Complete ✓                                    ║${NC}"
echo -e "${GREEN}║                                                                       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Downloaded Models:${NC}"
echo ""

# Check what was downloaded
if [ -d "$MODELS_DIR/checkpoints" ] && [ "$(ls -A $MODELS_DIR/checkpoints 2>/dev/null)" ]; then
    echo -e "${GREEN}✓${NC} Base Checkpoint: $(ls -1 $MODELS_DIR/checkpoints | head -1)"
else
    echo -e "${YELLOW}⚠${NC} No checkpoint downloaded - you'll need to download manually"
fi

if [ -f "$MODELS_DIR/vae/sdxl_vae.safetensors" ]; then
    echo -e "${GREEN}✓${NC} VAE: SDXL VAE"
else
    echo -e "${YELLOW}⚠${NC} No VAE - may have color/artifact issues"
fi

if [ -d "$MODELS_DIR/upscale_models" ] && [ "$(ls -A $MODELS_DIR/upscale_models 2>/dev/null)" ]; then
    UPSCALERS=$(ls -1 $MODELS_DIR/upscale_models | wc -l)
    echo -e "${GREEN}✓${NC} Upscalers: $UPSCALERS model(s)"
else
    echo -e "${YELLOW}⚠${NC} No upscalers - will need for final outputs (Day 7)"
fi

if [ -d "$MODELS_DIR/ipadapter" ] && [ "$(ls -A $MODELS_DIR/ipadapter 2>/dev/null)" ]; then
    echo -e "${GREEN}✓${NC} IP-Adapter: Installed (advanced control)"
fi

if [ -d "$MODELS_DIR/controlnet" ] && [ "$(ls -A $MODELS_DIR/controlnet 2>/dev/null)" ]; then
    echo -e "${GREEN}✓${NC} ControlNet: OpenPose installed"
fi

echo ""
echo -e "${CYAN}Storage Used:${NC}"
du -sh "$MODELS_DIR" 2>/dev/null || echo "Unable to calculate"
echo ""

echo -e "${CYAN}Next Steps:${NC}"
echo "  1. Access ComfyUI: https://$(hostname)-8188.proxy.runpod.net"
echo "  2. Begin character creation (Day 0)"
echo "  3. Follow: docs/01-FIRST-PROJECT.md"
echo ""

echo -e "${YELLOW}Note:${NC} You can re-run this script anytime to download additional models"
echo ""

echo -e "${BOLD}${GREEN}Ready to create S-tier characters!${NC}"
echo ""
