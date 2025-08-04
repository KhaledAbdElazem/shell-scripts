#!/bin/bash

echo "🌀 Starting Zsh + Oh My Zsh + Powerlevel10k setup..."

# Step 1: Install zsh if not already installed
if ! command -v zsh &> /dev/null; then
    echo "📦 Installing zsh..."
    sudo pacman -Sy --noconfirm zsh
else
    echo "✅ zsh is already installed."
fi

# Step 2: Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "✨ Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh is already installed."
fi

# Step 3: Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "🎨 Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
else
    echo "✅ Powerlevel10k is already installed."
fi

# Step 4: Set Powerlevel10k as the default theme
echo "🛠️ Setting Powerlevel10k as the default theme..."

ZSHRC="$HOME/.zshrc"

if grep -q '^ZSH_THEME=' "$ZSHRC"; then
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
else
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

# Step 5: Add NVM setup and aliases to .zshrc if not already present
if ! grep -q 'nvm.sh' "$ZSHRC"; then
    echo "🔗 Adding NVM setup and aliases to .zshrc..."
    cat << 'EOF' >> "$ZSHRC"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

alias nodev='node -v'
alias npmv='npm -v'
alias nvm-open='nvim ~/.nvm'
EOF
fi

# Step 6: Set Zsh as default shell (optional)
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "🔄 Changing default shell to Zsh..."
    chsh -s /bin/zsh
fi

# Final message
echo ""
echo "✅ Zsh setup is complete!"
echo ""
echo "👉 What to do next:"
echo "1. Close this terminal and open a new one."
echo "2. You will be prompted to configure Powerlevel10k the first time."
echo "3. Choose the style and options you like."
echo "4. To reconfigure later, just run: p10k configure"
echo ""
echo "💡 Tip: For best appearance, install the 'MesloLGS NF' font:"
echo "   https://github.com/romkatv/powerlevel10k#manual-font-installation"
