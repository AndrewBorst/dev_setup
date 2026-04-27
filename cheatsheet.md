## tmux Pane Management

| Action | Keys |
|---|---|
| Split pane vertically | `Prefix %` |
| Split pane horizontally | `Prefix "` |
| Navigate to pane | `Prefix arrow` |
| Cycle through panes | `Prefix o` |
| Close current pane | `Prefix x` |
| Toggle pane zoom | `Prefix z` |
| Show pane numbers | `Prefix q` |
| Resize pane | `Prefix Ctrl+arrow` |
| Convert pane to window | `Prefix !` |
| Swap panes | `Prefix {` or `Prefix }` |


## tmux Copy/Paste

| Action | Keys |
|---|---|
| Enter copy mode | `Prefix [` |
| Start selection | `Space` |
| Copy selection | `Enter` |
| Paste buffer | `Prefix ]` |
| List paste buffers | `Prefix #` |
| Copy to system clipboard (xclip) | `Prefix [`, select, then `y` (if configured) |


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
