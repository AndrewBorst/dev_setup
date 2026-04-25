#!/usr/bin/env bash
set -euo pipefail

echo "=== Dev Setup Install Script ==="
echo ""

# Update package lists
sudo apt update

# -------------------------------------------------------------------
# Essentials
# -------------------------------------------------------------------
echo ">>> Installing essential packages..."
sudo apt install -y \
    git \
    curl \
    wget \
    build-essential \
    ripgrep \
    fd-find \
    tmux \
    unzip \
    xclip

# -------------------------------------------------------------------
# Python build dependencies (needed by pyenv)
# -------------------------------------------------------------------
echo ">>> Installing Python build dependencies..."
sudo apt install -y \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

# -------------------------------------------------------------------
# pyenv
# -------------------------------------------------------------------
if [[ ! -d "$HOME/.pyenv" ]]; then
    echo ">>> Installing pyenv..."
    curl -fsSL https://pyenv.run | bash

    # Add pyenv to current shell
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # Persist in .bashrc if not already there
    if ! grep -q 'pyenv init' "$HOME/.bashrc"; then
        cat >> "$HOME/.bashrc" <<'EOF'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF
    fi
else
    echo ">>> pyenv already installed, skipping."
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Install latest Python 3 via pyenv
PYTHON_VERSION=$(pyenv install --list | grep -E '^\s+3\.[0-9]+\.[0-9]+$' | tail -1 | tr -d ' ')
if ! pyenv versions --bare | grep -q "^${PYTHON_VERSION}$"; then
    echo ">>> Installing Python ${PYTHON_VERSION} via pyenv..."
    pyenv install "$PYTHON_VERSION"
else
    echo ">>> Python ${PYTHON_VERSION} already installed."
fi
pyenv global "$PYTHON_VERSION"

# -------------------------------------------------------------------
# Python dev tools
# -------------------------------------------------------------------
echo ">>> Installing Python dev tools..."
pip install --upgrade pip
pip install black ruff mypy pynvim

# -------------------------------------------------------------------
# Neovim (latest stable AppImage)
# -------------------------------------------------------------------
echo ">>> Installing Neovim..."
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"
NVIM_DEST="$HOME/.local/bin/nvim"
mkdir -p "$HOME/.local/bin"

curl -fsSL -o "$NVIM_DEST" "$NVIM_URL"
chmod u+x "$NVIM_DEST"

# Ensure ~/.local/bin is on PATH
if ! grep -q '\.local/bin' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
export PATH="$HOME/.local/bin:$PATH"

echo ">>> Neovim version: $(nvim --version | head -1)"

# -------------------------------------------------------------------
# kickstart.nvim (sensible Neovim starter config)
# -------------------------------------------------------------------
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
if [[ ! -d "$NVIM_CONFIG_DIR" ]]; then
    echo ">>> Installing kickstart.nvim config..."
    git clone https://github.com/nvim-lua/kickstart.nvim.git "$NVIM_CONFIG_DIR"
else
    echo ">>> Neovim config already exists at $NVIM_CONFIG_DIR, skipping."
fi

# -------------------------------------------------------------------
# Done
# -------------------------------------------------------------------
echo ""
echo "=== Install complete! ==="
echo "Open a new terminal or run:  source ~/.bashrc"
echo "Then run:  nvim"
