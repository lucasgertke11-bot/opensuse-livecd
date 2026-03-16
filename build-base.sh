#!/bin/bash
# Build openSUSE Base using mkosi
# This script generates a minimal openSUSE system directory

set -e

echo "======================================"
echo "  openSUSE Base Builder (mkosi)"
echo "======================================"

# Check if mkosi is installed
if ! command -v mkosi &> /dev/null; then
    echo "mkosi not found! Installing..."
    
    # Detect package manager
    if command -v apt &> /dev/null; then
        echo "Installing mkosi via apt..."
        sudo apt update && sudo apt install -y mkosi
    elif command -v dnf &> /dev/null; then
        echo "Installing mkosi via dnf..."
        sudo dnf install -y mkosi
    elif command -v pacman &> /dev/null; then
        echo "Installing mkosi via pacman..."
        sudo pacman -S --noconfirm mkosi
    elif command -v zypper &> /dev/null; then
        echo "Installing mkosi via zypper..."
        sudo zypper install -y mkosi
    else
        echo "ERROR: No supported package manager found!"
        exit 1
    fi
fi

echo ""
echo "Building openSUSE base system..."
echo "This may take a while on first run (downloading packages)"
echo ""

# Create output directory
mkdir -p output

# Run mkosi to build the base system
sudo mkosi

echo ""
echo "======================================"
echo "  Build Complete!"
echo "======================================"
echo ""
echo "Base system created in: ./output/"
echo ""
echo "To use this base in DistroForge Studio:"
echo "1. This directory becomes your chroot base"
echo "2. Add Calamares: chroot ./output zypper in calamares"
echo "3. Add KDE/GNOME: chroot ./output zypper in patterns-kde-kde"
echo "4. Generate ISO: mkisofs -o mydistro.iso ./output"
