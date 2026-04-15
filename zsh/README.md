# Zsh Configuration

Framework: [zim](https://zimfw.sh/) with vi mode.

## Files

| File | Symlinked to | Purpose |
|------|-------------|---------|
| `zshenv` | `~/.zshenv` | Environment variables, PATH |
| `zshrc` | `~/.zshrc` | Interactive shell config, loads `myconf/*.zsh` |
| `zprofile` | `~/.zprofile` | Login shell config |
| `zlogin` | `~/.zlogin` | Post-login hooks |
| `zimrc` | `~/.zimrc` | Zim module definitions |

## Directories

### `myconf/`

Shell functions, keybindings, and tool integrations. All `*.zsh` files are auto-sourced by `zshrc`.

| File | Purpose |
|------|---------|
| `git.zsh` | Git functions with fzf (branch switch, rebase, add, diff, worktree cd) |
| `util.zsh` | General utilities (z search, file select, mkcd, etc.) |
| `tmux.zsh` | Tmux session switcher (`^t^o`) |
| `tmux_conf.zsh` | Tmux auto-attach on login |
| `language.zsh` | Lazy-loaded version managers (jenv, scalaenv, nodenv, pyenv, cargo) |
| `tools.zsh` | fzf config and initialization |
| `docker.zsh` | Docker exec/logs with fzf |
| `chrome.zsh` | Chrome tab switching via chrome-cli |
| `claude.zsh` | Claude Code account switching |
| `keybind.zsh` | Vi mode keybindings |
| `kube_ps1_settings.zsh` | Kubernetes prompt settings |
| `dynalyst.zsh` | Work-specific aliases |
| `zim.zsh` | Zim framework initialization |

### `abbr/`

`abbr.yaml` — abbreviation definitions managed as YAML, applied by `abbr-loader`.

Categories: alias, git, k8s, tools, shell, work, claude, global.

### `zim/`

Bundled zim modules (e.g. gitster theme).
