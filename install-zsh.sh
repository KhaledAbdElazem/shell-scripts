#!/bin/bash

# ========================
# Zema's Ultimate ZSH Setup Script
# ========================

set -e

USER_HOME="/home/$USER"
ZSH_CUSTOM="$USER_HOME/.oh-my-zsh/custom"

echo "🔧 Installing required packages..."
sudo pacman -Sy --noconfirm zsh fzf git curl

echo "📦 Installing Oh My Zsh..."
if [ ! -d "$USER_HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "⚡ Installing plugins..."

# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# fzf-tab
git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"

# fast directory jumping
# (z is already included with Oh My Zsh)

echo "🎨 Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

echo "🧠 Updating .zshrc..."

# Backup old .zshrc
cp "$USER_HOME/.zshrc" "$USER_HOME/.zshrc.backup.$(date +%s)"

# Overwrite with new config
cat > "$USER_HOME/.zshrc" <<EOF
export ZSH="$USER_HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
)

source \$ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

# Ensure ownership
chown "$USER:$USER" "$USER_HOME/.zshrc"

echo "✅ Changing default shell to zsh..."
sudo chsh -s "$(which zsh)" "$USER"

echo "🎉 Done! Restart terminal and enjoy zsh 🚀"
echo "🔔 First time you open terminal, Powerlevel10k will ask you to configure it."
