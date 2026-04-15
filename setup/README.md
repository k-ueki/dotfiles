# Setup Scripts

Bootstrap scripts for a fresh macOS environment.

## Scripts

| Script | Purpose |
|--------|---------|
| `setup.sh` | Main entry point — runs Homebrew install, font setup, tool clones, dotfile linking, and `brew bundle` |
| `setup_dotfiles.sh` | Creates symlinks from dotfiles to their expected locations |
| `setup_tools.sh` | Clones external tools: z, zsh-abbr, chrome-cli |
| `setup_fonts.sh` | Ricty font installation (needs update for modern macOS) |

## Brewfile

`Brewfile` contains all Homebrew packages, casks, and VS Code extensions.

Key categories:
- **Languages**: go, sbt, scala, node (via nodenv), python (via pyenv), rust (via rustup)
- **Kubernetes**: kubectl, kubectx, kubens, k9s, helm
- **CLI tools**: fzf, ripgrep, bat, jq, lazygit, gh, awscli
- **Apps**: Alacritty, Claude, Cursor, GoLand, Raycast

## Usage

```sh
cd ~/dotfiles
./setup/setup.sh
```
