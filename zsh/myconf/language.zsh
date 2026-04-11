#!/bin/zsh

# Rust / Cargo
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Go
go env -w GOPRIVATE=github.com/ajainc,ghe.ca-tools.org

# ---------- Lazy-load version managers ----------
# Each tool initializes only on first invocation, keeping shell startup fast.
# How it works: shell functions take precedence over PATH binaries of the same
# name. When e.g. `nodenv` is called, the stub function below runs instead of
# the binary, performs the heavy `eval "$(... init)"`, then re-invokes the real
# command. `command <name>` bypasses the function to reach the actual binary.

# jenv (Java)
jenv() {
  unfunction jenv 2>/dev/null
  eval export PATH="$HOME/.jenv/shims:${PATH}"
  unset JAVA_HOME
  jenv rehash 2>/dev/null
  # Re-define jenv as the real shell function
  eval "$(command jenv init - zsh)"
  jenv "$@"
}

# scalaenv
scalaenv() {
  unfunction scalaenv 2>/dev/null
  eval "$(command scalaenv init -)"
  scalaenv "$@"
}

# nodenv (Node.js)
nodenv() {
  unfunction nodenv 2>/dev/null
  eval "$(command nodenv init - zsh)"
  nodenv "$@"
}

# pyenv (Python)
pyenv() {
  unfunction pyenv 2>/dev/null
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(command pyenv init -)"
  pyenv "$@"
}
