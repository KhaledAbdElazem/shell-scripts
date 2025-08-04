#!/bin/bash

echo "🛠 Starting installation of yay..."

if ! command -v yay &> /dev/null; then
    echo "📦 Installing yay (AUR helper)..."
    sudo pacman -Sy --noconfirm git base-devel
    cd /tmp || exit
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
else
    echo "✅ yay is already installed."
fi

echo ""
echo "🎉 yay is ready to use!"
echo "📦 Try: yay -S package-name"
