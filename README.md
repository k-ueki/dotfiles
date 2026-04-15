# dotfiles

Personal development environment for macOS (Apple Silicon).

## Structure

```
dotfiles/
├── alacritty/       # Terminal emulator config
├── bin/             # Custom CLI tools and scripts
│   ├── for_dynalyst/  # Work-specific scripts (AWS auth, ArgoCD)
│   └── tmux/          # Tmux wrapper and pane manager
├── karabiner/       # Keyboard remapping (Karabiner-Elements)
├── nix/             # Nix / home-manager config
├── nvim/            # Neovim config (lazy.nvim, see nvim/README.md)
├── setup/           # Bootstrap scripts and Brewfile
├── tmux/            # Tmux config and tmuxinator sessions
├── tools/           # Source code for custom tools (e.g. abbr-loader)
└── zsh/             # Zsh config (zim, abbreviations, functions)
```

## Quick Start

```sh
git clone https://github.com/k-ueki/dotfiles ~/dotfiles
cd ~/dotfiles
./setup/setup.sh
```

This will:
1. Install Homebrew (if missing)
2. Install packages via `brew bundle` (see `setup/Brewfile`)
3. Clone required tools (z, zsh-abbr, chrome-cli)
4. Create symlinks for all config files

## Key Tools

| Tool | Description |
|------|-------------|
| `myhelp` | Interactive command/keybinding reference (fzf) |
| `git-wt` | Git worktree manager with fzf |
| `git-branch-create` | Create branches in `user_date_hash` format |
| `abbr-loader` | Fast YAML-to-zsh-abbr loader (writes directly to user-abbreviations) |
| `tmux-pane-manager` | Tmux pane killer/respawner with fzf |
| `aip` | AWS SAML auth + allow-my-ip for work |
| `dyn-argo` | ArgoCD cluster access via kubectx |

## Shell

- **Framework**: [zim](https://zimfw.sh/) with vi mode
- **Theme**: gitster (bundled in `zsh/zim/`)
- **Abbreviations**: Managed in `zsh/abbr/abbr.yaml`, applied by `abbr-loader`
- **Version managers**: jenv, scalaenv, nodenv, pyenv (all lazy-loaded)

## Editor

Neovim with lazy.nvim. See [nvim/README.md](nvim/README.md) for plugin list and keymaps.

## Symlinks

Managed by `setup/setup_dotfiles.sh`:

| Source | Target |
|--------|--------|
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `nvim/` | `~/.config/nvim` |
| `zsh/zprofile` | `~/.zprofile` |
| `zsh/zshenv` | `~/.zshenv` |
| `zsh/zshrc` | `~/.zshrc` |
| `zsh/zlogin` | `~/.zlogin` |
| `zsh/zimrc` | `~/.zimrc` |
| `.ideavimrc` | `~/.ideavimrc` |
| `alacritty/` | `~/.config/alacritty` |
| `claude/` | `~/.claude` |
| `karabiner/karabiner.json` | `~/.config/karabiner/karabiner.json` |
| `tmux/tmuxinator/` | `~/.config/tmuxinator` |
