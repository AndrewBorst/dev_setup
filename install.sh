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
    fzf \
    tmux \
    unzip \
    xclip \
    python-is-python3 \
    python3-venv \
    python3-pip \
    libfuse2t64 \
    pipx \
    plocate \
    glances

# -------------------------------------------------------------------
# GitHub CLI
# -------------------------------------------------------------------
if ! command -v gh &>/dev/null; then
    echo ">>> Installing GitHub CLI..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh
else
    echo ">>> GitHub CLI already installed, skipping."
fi

# -------------------------------------------------------------------
# Docker
# -------------------------------------------------------------------
if ! command -v docker &>/dev/null; then
    echo ">>> Installing Docker..."
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /tmp/docker.asc
    sudo cp /tmp/docker.asc /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo usermod -aG docker "$USER"
    echo ">>> NOTE: Log out and back in for docker group to take effect."
else
    echo ">>> Docker already installed, skipping."
fi

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
# tmux config (vi keys + clipboard + 256 colors)
# -------------------------------------------------------------------
echo ">>> Setting up tmux.conf..."
cat << 'TMUX' > ~/.tmux.conf
set-window-option -g mode-keys vi
set -g default-terminal "screen-256color"
set -as terminal-features ",xterm-256color:RGB"
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
TMUX

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

    # Add venv aliases
    if ! grep -q 'mkvenv' "$HOME/.bashrc"; then
        cat >> "$HOME/.bashrc" <<'EOF'

# Python venv aliases
alias av="source venv/bin/activate"
alias sdn="sudo shutdown now"
alias update="sudo apt update && sudo apt upgrade -y"
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
# LazyVim (Neovim IDE config)
# -------------------------------------------------------------------
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
if [[ ! -d "$NVIM_CONFIG_DIR" ]]; then
    echo ">>> Installing LazyVim starter config..."
    git clone https://github.com/LazyVim/starter "$NVIM_CONFIG_DIR"
    rm -rf "$NVIM_CONFIG_DIR/.git"
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
echo ""
echo "Don't forget:"
echo "  - 'gh auth login' to authenticate GitHub CLI"
echo "  - Log out/in if Docker was just installed (group permissions)"
