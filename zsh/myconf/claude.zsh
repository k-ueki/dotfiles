# Claude Code account display in prompt

# Function to get current Claude Code account
claude_account() {
  local account_info cache_file="$HOME/.claude_account_cache"
  local cache_age=300  # 5 minutes cache

  # Use cached value if recent
  if [[ -f "$cache_file" ]]; then
    local cache_mtime=$(stat -f %m "$cache_file" 2>/dev/null || stat -c %Y "$cache_file" 2>/dev/null)
    local current_time=$(date +%s)
    if (( current_time - cache_mtime < cache_age )); then
      account_info=$(cat "$cache_file")
      if [[ -n "$account_info" ]]; then
        echo "%{$fg[cyan]%}[󰧑 ${account_info}]%{$reset_color%}"
        return
      fi
    fi
  fi

  # Try to get account info from Claude Code config
  if [[ -f "$HOME/.claude/config.json" ]]; then
    account_info=$(jq -r '.email // .account // .user // empty' "$HOME/.claude/config.json" 2>/dev/null)
  fi

  # Try settings files
  if [[ -z "$account_info" ]]; then
    account_info=$(jq -r '.email // .account // .user // empty' "$HOME/.claude/settings.json" 2>/dev/null)
  fi

  # Cache the result
  if [[ -n "$account_info" ]]; then
    echo "$account_info" > "$cache_file"
    echo "%{$fg[cyan]%}[󰧑 ${account_info}]%{$reset_color%}"
  fi
}

# Manual usage: call claude_account() to see your current account
# Example: Run `claude_account` in terminal

# To add to your prompt, manually edit your prompt configuration:
# RPROMPT='$(claude_account)$(kube_ps1)'$RPROMPT
# or
# PROMPT='$(claude_account) '$PROMPT
