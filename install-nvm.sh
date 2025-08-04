#!/bin/bash

echo "📦 Installing NVM and latest Node.js..."

# Step 1: Install NVM
if [ ! -d "$HOME/.nvm" ]; then
    echo "⬇️ Downloading NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    echo "✅ NVM is already installed."
fi

# Step 2: Load NVM in current shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Step 3: Install latest Node.js
echo "⬇️ Installing latest Node.js..."
nvm install node
nvm alias default node

# Step 4: Verify installation
echo ""
echo "✅ Node.js and npm installed!"
node -v
npm -v
echo ""
echo "👉 You can now use Node.js and npm in your terminal."