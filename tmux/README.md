# Tmux Configuration

## Config

`.tmux.conf` — prefix is `C-a`, vi keybindings enabled.

Key bindings:
- `prefix + t` — lazygit popup
- `prefix + |` / `prefix + -` — split panes
- `prefix + h/j/k/l` — pane navigation

Plugins (via tpm):
- tmux-fingers — copy text with hints
- tmux-resurrect — save/restore sessions
- tmux-continuum — automatic session saving

## Tmuxinator

Session templates in `tmuxinator/`:

| Session | Root | Layout |
|---------|------|--------|
| `conv-apps` | `~/CyberAgent/Dynalyst/conv-apps` | nvim + claude + shell |
| `conv-formation` | `~/CyberAgent/Dynalyst/conv-formation` | nvim + shell |
| `conv-digdag` | `~/CyberAgent/Dynalyst/conv-digdag-jobs2` | nvim + shell |

Sessions auto-start on tmux server launch (configured in `.tmux.conf`).
