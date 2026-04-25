# Commands I Can't Remember

## tmux Copy/Paste

| Action | Keys |
|---|---|
| Enter copy mode | `Ctrl-b [` |
| Start selection | `Space` |
| Copy selection | `Enter` |
| Paste buffer | `Ctrl-b ]` |
| List paste buffers | `Ctrl-b #` |
| Copy to system clipboard (xclip) | `Ctrl-b [`, select, then `y` (if configured) |

### tmux.conf for system clipboard

```bash
# Add to ~/.tmux.conf
set -g mouse on
setw -g mode-keys vi
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -selection clipboard"
```

## Neovim Copy/Paste

| Action | Keys |
|---|---|
| Yank (copy) line | `yy` |
| Yank selection | `v` select then `y` |
| Yank to system clipboard | `"+y` |
| Paste from system clipboard | `"+p` |
| Yank entire file | `:%y+` |
| Yank to end of line | `y$` |
| Paste before cursor | `P` |
| Paste after cursor | `p` |

### Enable system clipboard in Neovim

```lua
-- Add to init.lua
vim.opt.clipboard = "unnamedplus"
```

This makes `y` and `p` use the system clipboard by default (no `"+` prefix needed).
