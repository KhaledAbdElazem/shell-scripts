#!/bin/bash

echo "🚀 Starting full Zsh + Node.js dev environment setup..."

### 1. Install zsh
if ! command -v zsh &> /dev/null; then
    echo "📦 Installing zsh..."
    sudo pacman -Sy --noconfirm zsh
else
    echo "✅ zsh is already installed."
fi

### 2. Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "✨ Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh is already installed."
fi

### 3. Install Powerlevel10k
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "🎨 Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "✅ Powerlevel10k is already installed."
fi

### 4. Set Powerlevel10k as default theme
ZSHRC="$HOME/.zshrc"
if grep -q '^ZSH_THEME=' "$ZSHRC"; then
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
else
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

### 5. Install NVM
if ! command -v curl &> /dev/null; then
    echo "📦 Installing curl..."
    sudo pacman -Sy --noconfirm curl
fi

if [ ! -d "$HOME/.nvm" ]; then
    echo "⬇️ Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    echo "✅ NVM is already installed."
fi

### 6. Install latest Node.js
echo "⬇️ Installing latest Node.js..."
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node
nvm use node

### 7. Add NVM setup + aliases to .zshrc
if ! grep -q 'nvm.sh' "$ZSHRC"; then
    echo "🔧 Adding NVM setup and aliases to .zshrc..."
    cat << 'EOF' >> "$ZSHRC"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Helpful aliases
alias nodev='node -v'
alias npmv='npm -v'
alias nvm-open='nvim ~/.nvm'
EOF
fi

### 8. Install Zsh Plugins
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "🔌 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "🔌 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Enable plugins in .zshrc
if grep -q '^plugins=' "$ZSHRC"; then
    sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
else
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
fi

# Source syntax-highlighting at the end
if ! grep -q 'zsh-syntax-highlighting.zsh' "$ZSHRC"; then
    echo "source \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$ZSHRC"
fi

### 9. Set Zsh as default shell
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "🔁 Changing default shell to zsh..."
    chsh -s /bin/zsh
fi

### ✅ Done!
echo ""
echo "🎉 Your Zsh + Node.js dev setup is complete!"
echo ""
echo "👉 What to do next:"
echo "1. Close this terminal and open a new one."
echo "2. Configure Powerlevel10k when it asks."
echo "3. Make sure you're using a Nerd Font like MesloLGS NF:"
echo "   https://github.com/romkatv/powerlevel10k#manual-font-installation"
echo ""
echo "⚡ You’re ready to code like a beast! 💻🔥"
