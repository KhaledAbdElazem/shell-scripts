#!/bin/bash

echo -e "\n🚀 Starting Dev Tools Installation...\n"

# Function to print steps
function step() {
  echo -e "\n👉 \033[1;34m$1\033[0m"
}

# Check for yay
if ! command -v yay &> /dev/null; then
  step "Installing yay..."
  git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay
  makepkg -si --noconfirm
  cd ~
  rm -rf ~/yay
else
  step "yay already installed ✅"
fi

# List of packages to install
packages=(
  lazygit
  bat
  btop
  gh
  zoxide
  ripgrep
  fd
  navi
  tldr
  fzf
  htop
  xclip
  neovim
  lsd
)

step "Installing dev tools with yay..."

for pkg in "${packages[@]}"; do
  echo -e "\n📦 Installing \033[1;32m$pkg\033[0m..."
  yay -S --noconfirm $pkg
done

# Optional: Initialize zoxide
if command -v zoxide &> /dev/null; then
  echo -e "\n⚙️  Adding zoxide init to your shell config..."

  if [[ "$SHELL" == *"zsh" ]]; then
    echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
  elif [[ "$SHELL" == *"bash" ]]; then
    echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
  fi
fi

step "All tools installed successfully 🎉"
echo -e "\n🧠 Next Steps:"
echo "🔹 Open a new terminal or run 'source ~/.zshrc' to apply zoxide if you're using zsh."
echo "🔹 Run 'tldr <command>' or 'navi' to try cheatsheets."
echo "🔹 Enjoy your pimped out terminal, boss 😎"

