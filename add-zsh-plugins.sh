#!/bin/bash

echo "🔌 Installing Zsh plugins: autosuggestions & syntax-highlighting..."

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Step 1: Install zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "📦 Cloning zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "✅ zsh-autosuggestions already installed."
fi

# Step 2: Install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "📦 Cloning zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "✅ zsh-syntax-highlighting already installed."
fi

# Step 3: Enable plugins in .zshrc
ZSHRC="$HOME/.zshrc"

if grep -q '^plugins=' "$ZSHRC"; then
    echo "🔧 Updating plugins list in .zshrc..."
    sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
else
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
fi

# Step 4: Append plugin source if needed
if ! grep -q "zsh-syntax-highlighting.zsh" "$ZSHRC"; then
    echo "🔗 Sourcing syntax-highlighting plugin..."
    echo "source \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$ZSHRC"
fi

echo ""
echo "✅ Plugins installed and configured!"
echo "🔄 Restart your terminal or run: source ~/.zshrc"
