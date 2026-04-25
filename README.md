# dev_setup

Linux install script for new machines and commands I can't remember.

## Quick Start

```bash
git clone https://github.com/AndrewBorst/dev_setup.git
cd dev_setup
chmod +x install.sh
./install.sh
```

## What's Included

- **Neovim** (latest stable via AppImage) with **LazyVim** starter config
- **Python dev tooling**: pyenv, python3, pip, venv, black, ruff, mypy, pynvim
- **tmux** with vi keys, 256 color, and system clipboard support
- **GitHub CLI** (`gh`)
- **Docker** (docker-ce, compose, buildx)
- **Essentials**: git, curl, wget, build-essential, ripgrep, fd-find, fzf, xclip, pipx, plocate, glances, libfuse2t64, python-is-python3

## Bash Aliases

| Alias | Command |
|---|---|
| `av` | `source venv/bin/activate` |
| `sdn` | `sudo shutdown now` |
| `update` | `sudo apt update && sudo apt upgrade -y` |

## Files

- `install.sh` — main install script
- `cheatsheet.md` — commands I can't remember (tmux, neovim copy/paste, etc.)
