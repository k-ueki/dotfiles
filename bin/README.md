# Custom CLI Tools

All files in `bin/` and its subdirectories are added to `$PATH` automatically via `zshenv`.

## Scripts

| Script | Description |
|--------|-------------|
| `myhelp` | Interactive command/keybinding reference with fzf |
| `abbr-loader` | YAML-to-zsh-abbr loader (writes user-abbreviations directly) |
| `git-wt` | Git worktree manager (add/remove/list/cd) with fzf |

### `for_dynalyst/`

| Script | Description |
|--------|-------------|
| `aip` | AWS SAML authentication + allow-my-ip |
| `dyn-argo` | ArgoCD setup with sign-in |

### `tmux/`

| Script | Description |
|--------|-------------|
| `tmux` | Wrapper adding `pm` subcommand for pane management |
| `tmux-pane-manager` | fzf-based tmux pane killer/respawner |

## Annotations

Scripts use `@` annotations for `myhelp` integration:

```sh
# @desc   Description of the command
# @usage  command [args]
# @example command foo
# @category git
# @key    ^g^o
```
