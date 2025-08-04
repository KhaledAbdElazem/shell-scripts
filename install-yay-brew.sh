#!/bin/bash

echo "🛠 Starting installation of yay and Homebrew..."

### 1. Install yay
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

### 2. Install Homebrew
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "🔧 Adding Homebrew to your shell config..."
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed."
fi

### ✅ Done!
echo ""
echo "🎉 yay and brew are ready to use!"
echo "📦 Try: yay -S package-name  OR  brew install package-name"
