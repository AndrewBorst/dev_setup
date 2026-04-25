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
- **Essentials**: git, curl, wget, build-essential, ripgrep, fd-find, fzf, xclip, python-is-python3

## Bash Aliases

| Alias | Command |
|---|---|
| `av` | `source venv/bin/activate` |

## Files

- `install.sh` — main install script
- `cheatsheet.md` — commands I can't remember (tmux, neovim copy/paste, etc.)
