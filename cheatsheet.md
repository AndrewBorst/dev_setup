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


## Neovim File Explorer (nvim-tree / Netrw)

| Action | Keys |
|---|---|
| Open file explorer | `:NvimTreeToggle` or `:Explore` |
| Open file from explorer | `Enter` |
| Open file in horizontal split | `Ctrl+x` (Netrw) / `s` (nvim-tree) |
| Open file in vertical split | `Ctrl+v` (Netrw) / `v` (nvim-tree) |
| Open file in new tab | `t` |
| Preview file | `p` |
| Go up a directory | `-` |
| Refresh explorer | `R` |
| Create new file | `a` (nvim-tree) / `%` (Netrw) |

## Neovim Splits / Panes

| Action | Keys |
|---|---|
| Split horizontally | `:split` or `Ctrl+w s` |
| Split vertically | `:vsplit` or `Ctrl+w v` |
| Navigate to left pane | `Ctrl+w h` |
| Navigate to right pane | `Ctrl+w l` |
| Navigate to pane above | `Ctrl+w k` |
| Navigate to pane below | `Ctrl+w j` |
| Cycle through panes | `Ctrl+w w` |
| Close current pane | `Ctrl+w c` or `:close` |
| Close all other panes | `Ctrl+w o` or `:only` |
| Equalize pane sizes | `Ctrl+w =` |
| Increase pane height | `Ctrl+w +` |
| Decrease pane height | `Ctrl+w -` |
| Increase pane width | `Ctrl+w >` |
| Decrease pane width | `Ctrl+w <` |
| Swap panes | `Ctrl+w x` |
| Move pane to new tab | `Ctrl+w T` |


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
