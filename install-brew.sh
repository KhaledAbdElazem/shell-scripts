#!/bin/bash

echo "🛠 Starting installation of Homebrew..."

if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo "🔧 Adding Homebrew to your shell config..."
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$HOME/.zshrc"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed."
fi

echo ""
echo "🎉 Homebrew is ready to use!"
echo "📦 Try: brew install package-name"

