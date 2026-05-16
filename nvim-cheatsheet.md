# Neovim Cheatsheet

## File Explorer (nvim-tree / Netrw)

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

## Splits / Panes

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


## Copy/Paste

| Action | Keys |
|---|---|
| Yank (copy) line | `yy` |
| Yank selection | `v` select then `y` |
| Yank to system clipboard | `"+y` |
| Yank entire file | `:%y+` |
| Yank to end of line | `y$` |
| Paste before cursor | `P` |
| Paste after cursor | `p` |
| Paste from system clipboard | `"+p` |


## Copying from Messages Buffer

**Note:** `:%y` doesn't work in the `:mess` output buffer.

Instead:
1. `:mess` to open messages
2. Manually select the error with `V` + arrow keys
3. `y` to yank
4. Paste wherever needed
